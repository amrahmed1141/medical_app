import 'package:flutter/material.dart';
import 'package:medical_app/bottom_navigation.dart';
import 'package:medical_app/controller/auth/auth_controller.dart'; // Add this import
import 'package:medical_app/view/auth/sign_up_screen.dart';
import 'package:medical_app/view/auth/widgets/auth_textfield.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),
              AuthTextField(
                labelText: 'Email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AuthTextField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to forgot password screen
                  },
                  child: Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 16),
              if (authController.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    authController.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: authController.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await authController.signIn(
                              _emailController.text,
                              _passwordController.text,
                              context, // Pass context here
                            );

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Sign in successful!')),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MainScreen()),
                              );
                            }
                          }
                        },
                  child: authController.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('SIGN IN'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
