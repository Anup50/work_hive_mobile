import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hive_mobile/view/signup_view.dart';
import 'package:work_hive_mobile/view_model/signin_view_model.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignInViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
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

                const SizedBox(height: 16), // Add some space after the image

                // Title and subtitle
                const Text(
                  'Sign in to your',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Account',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Enter your email and password to log in'),
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
                    errorText: viewModel.passwordError,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: const Icon(Icons.visibility),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Forgot password button
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 8),

                // Log in button
                ElevatedButton(
                  onPressed: () {
                    viewModel.logIn(context);
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
                    'Log In',
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

                // Google sign-in button
                ElevatedButton.icon(
                  onPressed: () {
                    // Add Google sign-in logic
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), 
                    ),
                  ),
                  icon: Image.asset(
                    'assets/icons/icons8-google-48.png',
                    height: 24, 
                    width: 24, 
                  ),
                  label: const Text('Continue with Google'),
                ),

                // Sign Up navigation
                const SizedBox(height: 120),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SignUpPage(), 
                        ),
                      );
                    },
                    child: const Text("Don't have an account? Sign Up"),
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
