import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainAppPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Login failed. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithPopup(googleProvider);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainAppPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'Google Sign-In failed.';
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Google Sign-In failed. Please try again.';
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 60),
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
                    top: 20,
                    left: 20,
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
              const SizedBox(height: 40),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Login to continue your study journey",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputStyle("Email", Icons.email),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: inputStyle("Password", Icons.lock),
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
                  onPressed: isLoading ? null : loginUser,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Login",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: isLoading ? null : signInWithGoogle,
                  icon: const Icon(Icons.g_mobiledata, size: 32),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}