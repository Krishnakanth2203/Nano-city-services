import 'package:flutter/material.dart';
import 'provider_home_screen.dart';
import 'provider_bookings_screen.dart';
import 'provider_profile_screen.dart';

class ProviderBottomNavigationBar extends StatefulWidget {
  const ProviderBottomNavigationBar({super.key});

  @override
  State<ProviderBottomNavigationBar> createState() =>
      _ProviderBottomNavigationBarState();
}

class _ProviderBottomNavigationBarState extends State<ProviderBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    ProviderHomeScreen(),
    ProviderBookingsScreen(),
    ProviderProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
