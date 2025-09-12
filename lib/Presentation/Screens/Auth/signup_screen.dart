import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/AccountSetUp/im_looking_for_screen.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/google_or_facebook_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/signup_checkbox_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/textfromfield_box_widget.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final double lineSize = MediaQuery.of(context).size.width * 0.38;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(
            AppImages.logoncsImg,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                AppStrings.enterEmailOr,
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldBoxUserWidget(
                controller: nameController,
                hintText: AppStrings.fullName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.pleaseEnterName;
                  }
                  return null;
                },
                prefixIcon: Icons.person,
              ),
              const SizedBox(
                height: 16,
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
                height: 8,
              ),
              const SignupCheckBoxWidget(),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(credential.user!.uid)
                          .set({
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'createdAt': DateTime.now(),
                      });

                      if (!mounted) return;

                      // Show success dialog
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Success"),
                          content:
                              const Text("Sign up completed successfully!"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(); // close dialog
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ImLookingForScreen(),
                                  ),
                                );
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      String errorMsg = "Something went wrong";
                      if (e.code == 'email-already-in-use') {
                        errorMsg = 'Email already in use';
                      } else if (e.code == 'weak-password') {
                        errorMsg = 'Password is too weak';
                      }

                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMsg),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const ButtonStyleWidget(
                  title: AppStrings.signUp,
                  colors: AppColors.blueColors,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    text: AppStrings.alreadyAccount,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                        text: AppStrings.signInNow,
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
                title: AppStrings.signUpWith,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
