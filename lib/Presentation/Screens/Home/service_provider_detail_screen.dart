import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nano_city_services/AppUtils/D_order.dart';
//import 'package:nano_city_services/AppUtils/app_images.dart';
//import 'package:nano_city_services/AppUtils/app_strings.dart';
//import 'package:nano_city_services/AppUtils/D_order.dart';

class ServiceProviderDetailScreen extends StatefulWidget {
  final String name;
  final String profession;
  final String rating;
  final String imageUrl;

  const ServiceProviderDetailScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.rating,
    required this.imageUrl,
  });

  @override
  State<ServiceProviderDetailScreen> createState() =>
      _ServiceProviderDetailScreenState();
}

class _ServiceProviderDetailScreenState
    extends State<ServiceProviderDetailScreen> {
  String? selectedTimeSlot;

  final List<String> timeSlots = [
    "10:00 AM",
    "12:00 PM",
    "2:00 PM",
    "4:00 PM",
    "6:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('MMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.profession,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("⭐ ${widget.rating}",
                style: const TextStyle(color: Colors.orange)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Time Slot for $currentDate:",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: timeSlots.map((slot) {
                return ChoiceChip(
                  label: Text(slot),
                  selected: selectedTimeSlot == slot,
                  onSelected: (_) {
                    setState(() {
                      selectedTimeSlot = slot;
                    });
                  },
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Add dummy order to provider's data
                  dummyUnpaidOrders.add(
                    DummyOrder(
                      title: widget.profession,
                      icon: widget.imageUrl,
                      amount: 250.0,
                      date: currentDate,
                      time: selectedTimeSlot ?? "",
                      name: widget.name,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking Confirmed!")),
                  );
                  Navigator.pop(context); // Go back to Home or List screen
                },
                child: const Text("Book Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
