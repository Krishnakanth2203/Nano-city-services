import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_constants.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Models/service_provider.dart';
import 'package:nano_city_services/Presentation/Screens/ServiceProvider/selected_service_provider.dart';
import 'package:nano_city_services/Presentation/Widgets/service_provider_card_widget.dart';
import 'package:nano_city_services/Presentation/Screens/Home/service_provider_detail_screen.dart';

class ServiceProviderLayoutWidget extends StatelessWidget {
  final String title;
  final String icon;
  final List<ServiceProvider> listofdata;
  const ServiceProviderLayoutWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.listofdata,
  });

  navigateToAnotherScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectedServiceProviderScreen(
          title: title,
          listofdata: listofdata,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(icon),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                navigateToAnotherScreen(context);
              },
              child: const Text(
                AppStrings.viewAll,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listofdata.length,
            itemBuilder: (context, index) {
              // Replace this section in your HomePageScreen
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceProviderDetailScreen(
                        name:
                            AppConstants.serviceProvider[index].name.toString(),
                        profession: AppConstants
                            .serviceProvider[index].profession
                            .toString(),
                        rating: AppConstants.serviceProvider[index].rating
                            .toString(),
                        imageUrl: AppConstants.serviceProvider[index].imageUrl
                            .toString(),
                      ),
                    ),
                  );
                },
                child: ServiceProviderCardWidget(
                  name: AppConstants.serviceProvider[index].name.toString(),
                  profession:
                      AppConstants.serviceProvider[index].profession.toString(),
                  rating: AppConstants.serviceProvider[index].rating.toString(),
                  imageUrl:
                      AppConstants.serviceProvider[index].imageUrl.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
