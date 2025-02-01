// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:work_hive_mobile/view/signin_view.dart';
// import 'package:work_hive_mobile/view_model/signup_view_model.dart';

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<SignUpViewModel>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/images/Frame 121(2).png',
//                   height: 50, // Adjust the size as needed
//                   width: 200, // Adjust the size as needed
//                 ),

//                 const SizedBox(height: 16), // Add some space after the image

//                 // Title and subtitle
//                 const Text(
//                   'Create Your',
//                   style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//                 ),
//                 const Text(
//                   'Account',
//                   style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('Fill in the details to sign up'),
//                 const SizedBox(height: 16),

               
//             child: Form(
//               key: _key,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _selectedRole = 'Job Seeker';
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: _selectedRole == 'Job Seeker'
//                                 ? Colors.blue
//                                 : Colors.grey[200],
//                             foregroundColor: _selectedRole == 'Job Seeker'
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                           child: const Text('Job Seeker'),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               _selectedRole = 'Employer';
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: _selectedRole == 'Employer'
//                                 ? Colors.blue
//                                 : Colors.grey[200],
//                             foregroundColor: _selectedRole == 'Employer'
//                                 ? Colors.white
//                                 : Colors.black,
//                           ),
//                           child: const Text('Employer'),
//                         ),
//                       ),
//                     ],
//                   ),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'First Name',
//                     ),
//                     validator: ((value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter first name';
//                       }
//                       return null;
//                     }),
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: const Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email';
//                       }

//                       final emailRegex =
//                           RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
//                       if (!emailRegex.hasMatch(value)) {
//                         return 'Please enter a valid email address';
//                       }

//                       return null;
//                     },
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       prefixIcon: const Icon(Icons.lock),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }

//                       if (value.length < 8) {
//                         return 'Password must be at least 8 characters long';
//                       }

//                       final passwordRegex = RegExp(
//                           r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
//                       if (!passwordRegex.hasMatch(value)) {
//                         return 'Password must include uppercase, lowercase, number, and special character';
//                       }

//                       return null;
//                     },
//                   ),
//                   _gap,
//                   TextFormField(
//                     controller: _confirmPasswordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Confirm Password',
//                       prefixIcon: const Icon(Icons.lock),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please confirm your password';
//                       }

//                       if (value != _passwordController.text) {
//                         return 'Passwords do not match';
//                       }

//                       return null;
//                     },
//                   ),
//                   _gap,
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_key.currentState!.validate()) {
//                           context.read<SignupBloc>().add(
//                                 RegisterUser(
//                                   context: context,
//                                   name: _nameController.text,
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                   role: _selectedRole,
//                                 ),
//                               );
//                         }
//                       },
//                       child: const Text('Register'),
//                     ),
//                   ),
//                 // Or text
//                 const Center(
//                   child: Text(
//                     'Or',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 // Google sign-up button
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Add Google sign-up logic
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     backgroundColor: const Color.fromARGB(255, 193, 227, 242),
//                     foregroundColor: Colors.blue,
//                   ),
//                   icon: Image.asset(
//                     'assets/icons/icons8-google-48.png',
//                     height: 24,
//                     width: 24,
//                   ),
//                   label: const Text('Sign Up with Google',
//                       style: TextStyle(
//                         fontFamily: 'PlusJakartaSans SemiBold',
//                       )),
//                 ),

//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 45),
//                       child: Center(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const SignInPage(),
//                               ),
//                             );
//                           },
//                           child: const Text("Already have an account? Sign In"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 ],
//               ),
//             ),

//                 // Sign Up button


                

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
