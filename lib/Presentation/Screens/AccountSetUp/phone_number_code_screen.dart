import 'package:flutter/material.dart';
//import 'package:nano_city_services/Presentation/Screens/Home/home_page_screen.dart';
//import 'package:nano_city_services/Presentation/Screens/AccountSetUp/upload_documents_screen.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Widgets/bottom_navigation_bar_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/enter_phone_code_widget.dart';
import 'package:nano_city_services/Presentation/provider/provider_bottom_navigation.dart';

class PhoneNumberCodeScreen extends StatefulWidget {
  final String userType;
  final String verificationId;
  final String phone;

  const PhoneNumberCodeScreen({
    super.key,
    required this.userType,
    required this.verificationId,
    required this.phone,
  });

  @override
  State<PhoneNumberCodeScreen> createState() => _PhoneNumberCodeScreenState();
}

class _PhoneNumberCodeScreenState extends State<PhoneNumberCodeScreen> {
  String otpCode = '';

  void verifyManualOtp(String otpCode) {
    if (otpCode == "123456") {
      if (widget.userType == "service_provider") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const ProviderBottomNavigationBar(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationBarWidget(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP entered.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(AppImages.logoncsImg),
        ),
        actions: [
          Image.asset(AppImages.frame3Img),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.enterFiveDigit,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            CodeInputWidget(
              onOtpComplete: (code) {
                otpCode = code;
              },
            ),
            const SizedBox(height: 57),
            InkWell(
              onTap: () {
                if (otpCode.length == 6) {
                  verifyManualOtp(otpCode); // ✅ Pass the actual code
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
                  );
                }
              },
              child: const ButtonStyleWidget(
                title: AppStrings.verify,
                colors: AppColors.blueColors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
