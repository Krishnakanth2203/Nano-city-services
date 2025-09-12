import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/AccountSetUp/im_looking_for_screen.dart';
import 'package:nano_city_services/Presentation/Screens/Auth/signup_screen.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/google_or_facebook_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/textfromfield_box_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            AppImages.logoncsImg,
          ),
        ),
      ),
      // The body of the Scaffold should directly contain the SingleChildScrollView,
      // which allows it to take up all available space.
      body: SingleChildScrollView( // <-- Moved SingleChildScrollView here
        padding: EdgeInsets.only(
          top: 36, // Apply top padding here
          left: 24,
          right: 24,
          bottom: keyboardHeight + 20, // Added extra padding for comfort above keyboard
        ),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.min ensures the column takes only the space its children need
            // This is crucial when inside a SingleChildScrollView if you want it to scroll correctly.
            mainAxisSize: MainAxisSize.min, // <-- Added mainAxisSize.min
            children: [
              const Text(
                AppStrings.enterEmailOr,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldBoxUserWidget(
                controller: emailController,
                hintText: AppStrings.enterEmail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterEmail;
                  }
                  return null;
                },
                prefixIcon: Icons.mail_rounded,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFromFieldBoxPassword(
                controller: passwordController,
                hintText: AppStrings.enterPass,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterPass;
                  }
                  return null;
                },
                prefixIcon: Icons.lock,
              ),
              const SizedBox(
                height: 24, // Adjusted height
              ),
              InkWell(
                onTap: _isLoading ? null : () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImLookingForScreen()),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      String message = 'Login failed';
                      if (e.code == 'user-not-found') {
                        message = 'No user found for that email.';
                      } else if (e.code == 'wrong-password') {
                        message = 'Wrong password provided.';
                      }
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      }
                    } finally {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  }
                },
                child: ButtonStyleWidget(
                  title: _isLoading ? 'Logging In...' : AppStrings.signIn,
                  colors: AppColors.blueColors,
                ),
              ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.blueColors),
                  ),
                ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: AppStrings.newTo,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: AppStrings.signUpNow,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const GoogleOrFacebookWidget(
                title: AppStrings.signInWith,
              ),
              // The SizedBox at the end helps ensure there's enough scrollable space
              // even without the keyboard.
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}