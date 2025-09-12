import 'package:flutter/material.dart';
import 'package:nano_city_services/AppUtils/app_images.dart';
import 'package:nano_city_services/AppUtils/app_strings.dart';
import 'package:nano_city_services/Presentation/Screens/Auth/login_screen.dart';

class ProviderProfileScreen extends StatelessWidget {
  const ProviderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.myProfile)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(AppImages.plumberMaskotkotaImg),
            ),
            const SizedBox(height: 12),
            const Text(
              "Ravi Kumar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Plumber"),
            const Divider(height: 30),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: Text("+91 98765 43210"),
            ),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text("ravi.kumar@example.com"),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
