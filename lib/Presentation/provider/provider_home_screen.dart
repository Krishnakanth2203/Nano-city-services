import 'package:flutter/material.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({super.key});

  @override
  State<ProviderHomeScreen> createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provider Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Today's Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOnline = !isOnline;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isOnline ? "You are Online" : "You are Offline"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: _infoCard("Status", isOnline ? "Online" : "Offline", Icons.wifi,
                      isOnline ? Colors.green : Colors.red),
                ),
                _infoCard("Earnings", "₹1,200", Icons.currency_rupee, Colors.blue),
                _infoCard("Timings", "9AM - 6PM", Icons.access_time_filled, Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.check_circle_outline, color: Colors.green),
              title: Text("Completed AC Repair"),
              subtitle: Text("10:30 AM - ₹500"),
            ),
            const ListTile(
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text("Cancelled Plumbing"),
              subtitle: Text("12:00 PM - ₹0"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
