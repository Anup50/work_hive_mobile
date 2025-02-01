import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hive_mobile/features/user_data/presentation/view_model/bloc/job_seeker_bloc.dart';

class JobSeekerView extends StatefulWidget {
  const JobSeekerView({super.key});

  @override
  State<JobSeekerView> createState() => _JobSeekerViewState();
}

class _JobSeekerViewState extends State<JobSeekerView> {
  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _bioController = TextEditingController(text: '');
  final _skillsController = TextEditingController(text: '');
  final _locationController = TextEditingController(text: '');

  // Check for camera permission
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Information'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  checkCameraPermission();
                                  _browseImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  _browseImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _img != null
                            ? FileImage(_img!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _skillsController,
                    decoration: const InputDecoration(
                      labelText: 'Skills',
                    ),
                  ),
                  _gap,
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                    ),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          final registerState =
                              context.read<JobSeekerBloc>().state;
                          final imageName = registerState.imageName;
                          final prefs = await SharedPreferences.getInstance();

                          String? userId = prefs.getString('userId');

                          context.read<JobSeekerBloc>().add(
                                AddJobSeeker(
                                  context: context,
                                  bio: _bioController.text,
                                  location: _locationController.text,
                                  profilePicture: imageName,
                                  skills: _skillsController.text
                                      .split(',')
                                      .map((e) => e.trim())
                                      .toList(),
                                  userId:
                                      userId, // Send the userId from SharedPreferences
                                ),
                              );
                        }
                      },
                      child: const Text('Add info'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
