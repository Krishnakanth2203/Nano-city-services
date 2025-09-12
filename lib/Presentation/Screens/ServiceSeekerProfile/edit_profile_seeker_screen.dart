import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/AccountSetUp/phone_number_screen.dart';
import 'package:nano_city_services/Presentation/Widgets/button_style_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/phone_number_enter_widget.dart';
import 'package:nano_city_services/Presentation/Widgets/textfromfield_widget.dart';

class EditProfileSeekerScreen extends StatefulWidget {
  const EditProfileSeekerScreen({super.key});

  @override
  State<EditProfileSeekerScreen> createState() => _EditeProfileSeekerState();
}

class _EditeProfileSeekerState extends State<EditProfileSeekerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfbirthdayController = TextEditingController();
  TextEditingController contryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final List<MenuItem> items = [
    MenuItem(
      name: AppStrings.afghanistan,
      imagePath: AppImages.afghanistanImg,
      number: AppStrings.rating93,
    ),
    MenuItem(
      name: AppStrings.australia,
      imagePath: AppImages.australiaImg,
      number: AppStrings.rating93,
    ),
    MenuItem(
      name: AppStrings.bahrain,
      imagePath: AppImages.bahrainImg,
      number: AppStrings.rating973,
    ),
    MenuItem(
      name: AppStrings.bangladesh,
      imagePath: AppImages.bangladeshImg,
      number: AppStrings.rating880,
    ),
    MenuItem(
      name: AppStrings.brazil,
      imagePath: AppImages.brazilImg,
      number: AppStrings.rating55,
    ),
    MenuItem(
      name: AppStrings.canada,
      imagePath: AppImages.canadaImg,
      number: AppStrings.rating1,
    ),
    MenuItem(
      name: AppStrings.china,
      imagePath: AppImages.chinaImg,
      number: AppStrings.rating86,
    ),
    MenuItem(
      name: AppStrings.cuba,
      imagePath: AppImages.cubaImg,
      number: AppStrings.rating53,
    ),
    MenuItem(
      name: AppStrings.india,
      imagePath: AppImages.indiaImg,
      number: AppStrings.rating91,
    ),
    MenuItem(
      name: AppStrings.indonesia,
      imagePath: AppImages.indonesiaImg,
      number: AppStrings.rating62,
    ),
    MenuItem(
      name: AppStrings.iran,
      imagePath: AppImages.iranImg,
      number: AppStrings.rating98,
    ),
    MenuItem(
      name: AppStrings.japan,
      imagePath: AppImages.japanImg,
      number: AppStrings.rating81,
    ),
    MenuItem(
      name: AppStrings.myanmar,
      imagePath: AppImages.myanmarImg,
      number: AppStrings.rating95,
    ),
    MenuItem(
      name: AppStrings.newZealand,
      imagePath: AppImages.newzealandImg,
      number: AppStrings.rating64,
    ),
    MenuItem(
      name: AppStrings.russia,
      imagePath: AppImages.russiaImg,
      number: AppStrings.rating7,
    ),
    MenuItem(
      name: AppStrings.sriLanka,
      imagePath: AppImages.srilankaImg,
      number: AppStrings.rating94,
    ),
    MenuItem(
      name: AppStrings.uK,
      imagePath: AppImages.ukImg,
      number: AppStrings.rating44,
    ),
    MenuItem(
      name: AppStrings.uS,
      imagePath: AppImages.usImg,
      number: AppStrings.rating1,
    ),
    MenuItem(
      name: AppStrings.zimbabwe,
      imagePath: AppImages.zimbabweImg,
      number: AppStrings.rating263,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              )),
        ),
        title: const Text(
          AppStrings.editProifle,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 96,
                width: 96,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppImages.kalpeshImg,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              AppStrings.name,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            TextFromFieldWidget(
              controller: nameController,
              hintText: AppStrings.enterName,
              colors: Colors.blue,
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              AppStrings.email,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            TextFromFieldWidget(
              controller: emailController,
              hintText: AppStrings.enterEmail,
              colors: Colors.blue,
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              AppStrings.dob,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            TextFromFieldWidget(
              controller: dateOfbirthdayController,
              hintText: AppStrings.dateFormat,
              colors: Colors.blue,
            ),
            const SizedBox(
              height: 7,
            ),
            const Text(
              AppStrings.phoneNumber,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            PhoneNumberEnterWidget(
              items: items,
              numberController: numberController, onCountryCodeSelected: (int ) {  },
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ButtonStyleWidget(
                title: AppStrings.save,
                colors: AppColors.blueColors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
