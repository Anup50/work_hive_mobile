import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hive_mobile/view_model/signin_view_model.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Make the entire body scrollable
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

                SizedBox(height: 16), // Add some space after the image

                // Title and subtitle
                const Text(
                  'Sign in to your',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                const Text('Enter your email and password to log in'),
                SizedBox(height: 8),

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

                SizedBox(height: 8),

                // Password TextField
                TextField(
                  controller: viewModel.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: viewModel.passwordError,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: Icon(Icons.visibility),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // Forgot password button
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: 8),

                // Log in button
                ElevatedButton(
                  onPressed: viewModel.logIn,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full width button
                    backgroundColor: Colors.blue, // Blue background color
                    foregroundColor: Colors.white, // White text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Boxy, with slightly rounded corners
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 8),

                // Or text
                const Center(
                  child: Text('Or'),
                ),
                const SizedBox(height: 8),

                // Google sign-in button
                ElevatedButton.icon(
                  onPressed: () {
                    // Add Google sign-in logic
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Boxy, with slightly rounded corners
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icons/icons8-google-48.png',
                    height: 24, // Adjust the height as needed
                    width: 24, // Adjust the width as needed
                  ),
                  label: const Text('Continue with Google'),
                ),

                // Sign Up navigation
                SizedBox(height: 120),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Add sign-up navigation
                    },
                    child: Text("Don't have an account? Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
