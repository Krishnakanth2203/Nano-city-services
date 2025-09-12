import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_colors.dart';
import 'package:nano_city_services/AppUtils/app_constants.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Widgets/service_provider_layout_widget.dart';

class ServiceProviderScreens extends StatefulWidget {
  const ServiceProviderScreens({super.key});

  @override
  State<ServiceProviderScreens> createState() => _ServiceProviderScreensState();
}

class _ServiceProviderScreensState extends State<ServiceProviderScreens> {
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
                color: AppColors.blueColors,
              )),
        ),
        title: const Text(
          AppStrings.servicesprovider,
          style: TextStyle(
            color: AppColors.blueColors,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ServiceProviderLayoutWidget(
                title: AppStrings.electricianprovider,
                icon: AppImages.electricianiconImg,
                listofdata: AppConstants.electricianProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.plumberprovider,
                icon: AppImages.plumbericonImg,
                listofdata: AppConstants.plumberProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.carpenterprovider,
                icon: AppImages.carpentericonImg,
                listofdata: AppConstants.carpenterProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.painterprovider,
                icon: AppImages.paintericonImg,
                listofdata: AppConstants.painterProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.cleanerprovider,
                icon: AppImages.cleanericonImg,
                listofdata: AppConstants.cleanerProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.locksmithProvider,
                icon: AppImages.locksmithiconImg,
                listofdata: AppConstants.locksmithProvider,
              ),
              ServiceProviderLayoutWidget(
                title: AppStrings.moverProvider,
                icon: AppImages.movericonImg,
                listofdata: AppConstants.moverProvider,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
