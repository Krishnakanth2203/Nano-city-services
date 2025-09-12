import 'package:flutter/material.dart';

class ProviderBookingsScreen extends StatelessWidget {
  const ProviderBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy bookings data
    List<Map<String, String>> bookings = [
      {
        "name": "Janavi",
        "service": "AC Repair",
        "time": "10:30 AM",
        "status": "Confirmed",
        "date": "July 15, 2025",
      },
      {
        "name": "Varun",
        "service": "Fan Fix",
        "time": "12:00 PM",
        "status": "Pending",
        "date": "July 16, 2025",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Bookings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No bookings yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final booking = bookings[index];
                final name = booking['name'] ?? 'Unknown';
                final service = booking['service'] ?? 'Service';
                final time = booking['time'] ?? 'Time';
                final date = booking['date'] ?? 'Date';
                final status = booking['status'] ?? 'Pending';

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.home_repair_service, color: Colors.blue),
                    title: Text(
                      "$service - $name",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date: $date"),
                        Text("Time: $time"),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(status),
                      backgroundColor: status == "Confirmed"
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                    ),
                  ),
                );
              },
            ),
    );
  }
}