import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/AccountSetUp/phone_number_code_screen.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/phone_number_enter_widget.dart';

class PhoneNumberScreen extends StatefulWidget {
  final String userType;

  const PhoneNumberScreen({super.key, required this.userType});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController numberController = TextEditingController();
  int selectedNumber = 91; // Default country code (India)

  void goToOTPVerification() {
    String phone = '+$selectedNumber${numberController.text.trim()}';

    if (numberController.text.isEmpty || numberController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid 10-digit phone number")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhoneNumberCodeScreen(
          userType: widget.userType,
          verificationId: 'manual-verification', // dummy
          phone: phone,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> items = [
      MenuItem(
        name: AppStrings.india,
        imagePath: AppImages.indiaImg,
        number: AppStrings.rating91,
      ),
      MenuItem(
        name: AppStrings.uS,
        imagePath: AppImages.usImg,
        number: AppStrings.rating1,
      ),
      // Add more countries if needed
    ];

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Image.asset(AppImages.logoncsImg),
        ),
        actions: [
          Image.asset(AppImages.frame2Img),
          const SizedBox(width: 24),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome ${widget.userType == 'service_provider' ? 'Service Provider' : 'Customer'}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.enteryourPhone,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 75),
            PhoneNumberEnterWidget(
              items: items,
              numberController: numberController,
              onCountryCodeSelected: (code) {
                setState(() {
                  selectedNumber = code;
                });
              },
            ),
            const SizedBox(height: 84),
            InkWell(
              onTap: goToOTPVerification,
              child: const ButtonStyleWidget(
                title: AppStrings.sendCode,
                colors: AppColors.blueColors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final String imagePath;
  final int number;

  MenuItem({
    required this.name,
    required this.imagePath,
    required this.number,
  });
}
