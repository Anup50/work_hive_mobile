import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hive_mobile/view/signin_view.dart';
import 'package:work_hive_mobile/view_model/signup_view_model.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/Frame 121(2).png',
                  height: 50, // Adjust the size as needed
                  width: 200, // Adjust the size as needed
                ),

                const SizedBox(height: 16), // Add some space after the image

                // Title and subtitle
                const Text(
                  'Create Your',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Fill in the details to sign up'),
                const SizedBox(height: 16),

                // Full Name TextField
                TextField(
                  controller: viewModel.fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                    errorText: viewModel.fullNameError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Email TextField
                TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    errorText: viewModel.emailError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Password TextField
                TextField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: viewModel.passwordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Confirm Password TextField
                TextField(
                  controller: viewModel.confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: viewModel.confirmPasswordError,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    viewModel
                        .signUp(context); // Wrap in a lambda to pass context
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(double.infinity, 50), // Full width button
                    backgroundColor: Colors.blue, // Blue background color
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Boxy, with slightly rounded corners
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 8),

                // Or text
                const Center(
                  child: Text(
                    'Or',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),

                // Google sign-up button
                ElevatedButton.icon(
                  onPressed: () {
                    // Add Google sign-up logic
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(255, 193, 227, 242),
                    foregroundColor: Colors.blue,
                  ),
                  icon: Image.asset(
                    'assets/icons/icons8-google-48.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text('Sign Up with Google',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans SemiBold',
                      )),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInPage(),
                              ),
                            );
                          },
                          child: const Text("Already have an account? Sign In"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
