import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/City/city_screens.dart';
import 'package:nano_city_services/Presentation/Screens/Home/home_page_screen.dart';
import 'package:nano_city_services/Presentation/Screens/Order/order_screens.dart';
import 'package:nano_city_services/Presentation/Screens/ServiceSeekerProfile/service_seeker_profile.dart';

/*
Title:BottomNavigationBarWidget
Purpose:BottomNavigationBarWidget
Created On:12/06/2024
Edited On:12/06/2024
*/


class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;
  List<Widget> iconList = [
    const HomePageScreen(),
    const CityScreens(),
    const OrderScreens(),
    const ServiceSeekerProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: iconList[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: AppStrings.city,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: AppStrings.order,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile,
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
