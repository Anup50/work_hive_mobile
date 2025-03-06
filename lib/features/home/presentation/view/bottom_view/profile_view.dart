import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/features/auth/presentation/view/signin_view.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/presentation/view_model/bloc/job_seeker_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final either = await TokenSharedPrefs(prefs).getJobSeekerId();

    either.fold((failure) => debugPrint('Error getting ID: ${failure.message}'),
        (id) {
      if (id != null) {
        context.read<JobSeekerBloc>().add(LoadJobSeekerProfileEvent(id: id));
      }
    });
  }

  final _key = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _showStats = true;
  final _bioController = TextEditingController(text: '');
  final _skillsController = TextEditingController(text: '');
  final _locationController = TextEditingController(text: '');

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // Send image to server
          context.read<JobSeekerBloc>().add(
                UploadImage(file: _img!),
              );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onEditProfilePressed(JobSeekerState state) {
    setState(() {
      _isEditing = true;
      _showStats = false;
      _locationController.text = state.jobSeeker?.location ?? '';
      _bioController.text = state.jobSeeker?.bio ?? '';

      if (state.jobSeeker?.skills != null) {
        _skillsController.text = state.jobSeeker!.skills.join(', ');
      }
    });
  }

  void _onSaveProfilePressed() async {
    if (_key.currentState!.validate()) {
      final currentState = context.read<JobSeekerBloc>().state;

      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      // Retrieve job seeker ID using fold
      String? jobSeekerId = await TokenSharedPrefs(prefs).getJobSeekerId().then(
            (either) => either.fold(
              (failure) {
                debugPrint('Failed to get Job Seeker ID: ${failure.message}');
                return null;
              },
              (id) => id,
            ),
          );

      if (jobSeekerId != null) {
        // Create a JobSeekerEntity object
        final jobSeekerEntity = JobSeekerEntity(
          bio: _bioController.text,
          skills:
              _skillsController.text.split(',').map((e) => e.trim()).toList(),
          profilePicture: currentState.imageName ?? _img?.path ?? '',
          userId: userId ?? '',
          location: _locationController.text,
        );

        // Pass the JobSeekerEntity to the UpdateJobSeekerEvent
        context.read<JobSeekerBloc>().add(UpdateJobSeekerEvent(
              id: jobSeekerId,
              jobSeeker: jobSeekerEntity,
            ));

        setState(() {
          _isEditing = false;
          _showStats = true;
        });
      } else {
        debugPrint('Job Seeker ID is null. Cannot proceed with update.');
      }
    }
  }

  void _onLogoutPressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: getIt<LoginBloc>(),
          child: SignInPage(),
        ),
      ),
    );
    debugPrint('User logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            onPressed: _onLogoutPressed,
          ),
        ],
      ), // Blue AppBar
      body: Container(
        color:
            const Color.fromARGB(255, 234, 242, 248), // Bluish-white background
        child: SafeArea(
          child: BlocBuilder<JobSeekerBloc, JobSeekerState>(
            builder: (context, state) {
              print("BlocBuilder State: $state");
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(
                    child: Text(state.errorMessage ?? 'An error occurred'));
              }

              if (state.jobSeeker != null && !_isEditing) {
                _bioController.text = state.jobSeeker?.bio ?? '';
                _locationController.text = state.jobSeeker?.location ?? '';
                print("JobSeeker object: ${state.jobSeeker}");
                if (state.jobSeeker?.skills != null) {
                  print("Skills list: ${state.jobSeeker!.skills}");
                  _skillsController.text = state.jobSeeker!.skills.join(', ');
                }
              }
              print('Profile Picture URL: ${state.jobSeeker?.profilePicture}');
              print('Local Image File: $_img');
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Stack to overlay camera icon on profile picture
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          _browseImage(ImageSource.camera);
                                          Navigator.pop(
                                              context); // Close the modal after selecting camera
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          _browseImage(ImageSource.gallery);
                                          Navigator.pop(
                                              context); // Close the modal after selecting gallery
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: (_img != null)
                                    ? FileImage(_img!)
                                    : (state.jobSeeker?.profilePicture != null
                                            ? NetworkImage(
                                                'https://your-api-base-url/uploads/${state.jobSeeker!.profilePicture!}')
                                            : const AssetImage(
                                                'assets/images/profile.png'))
                                        as ImageProvider,
                              ),
                            ),
                            if (_isEditing)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.jobSeeker?.userName ?? 'Name',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showStats = true; // Show Stats section
                                      _isEditing = false; // Exit edit mode
                                    });
                                  },
                                  child: const Text("View Stats"),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () => _onEditProfilePressed(state),
                                  child: const Text("Edit Profile"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    if (_showStats) _buildStatsAndBlogsSection(),
                    if (_isEditing) _buildEditProfileSection(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatsAndBlogsSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stats & Blogs',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text('Your stats and blogs will be displayed here.'),
      ],
    );
  }

  Widget _buildEditProfileSection() {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Bio Field
          TextFormField(
            controller: _bioController,
            decoration: const InputDecoration(
              labelText: 'Bio',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) => value!.isEmpty ? 'Please enter a bio' : null,
          ),
          const SizedBox(height: 16),

          // Skills Field
          TextFormField(
            controller: _skillsController,
            decoration: const InputDecoration(
              labelText: 'Skills (comma separated)',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Please enter at least one skill' : null,
          ),
          const SizedBox(height: 16),

          // Location Field
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Please enter your location' : null,
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                    _showStats = true;
                  });
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _onSaveProfilePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
