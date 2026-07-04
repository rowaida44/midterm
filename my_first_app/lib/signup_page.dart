import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> signUpUser() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      setState(() {
        isLoading = false;
        errorMessage = 'Passwords do not match.';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await FirebaseAuth.instance.currentUser?.updateDisplayName(
        nameController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainAppPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'This email is already registered.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Password is too weak.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email format.';
        } else {
          errorMessage = 'Sign up failed. Please try again.';
        }
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  InputDecoration inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(Icons.menu_book, size: 60, color: Colors.blue),
                    Positioned(
                      top: -20,
                      left: -20,
                      child: Icon(Icons.edit, size: 30, color: Colors.blue[400]),
                    ),
                    Positioned(
                      top: -20,
                      right: -20,
                      child: Icon(Icons.laptop, size: 30, color: Colors.blue[400]),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: Icon(Icons.school, size: 30, color: Colors.blue[400]),
                    ),
                    Positioned(
                      bottom: -20,
                      right: -20,
                      child: Icon(
                        Icons.cast_for_education,
                        size: 30,
                        color: Colors.blue[400],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Sign up to start your study journey",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: nameController,
                  decoration: inputStyle("Full Name", Icons.person),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputStyle("Email", Icons.email),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: inputStyle("Password", Icons.lock),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: inputStyle("Confirm Password", Icons.lock_outline),
                ),

                const SizedBox(height: 15),

                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: isLoading ? null : signUpUser,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.blue),
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