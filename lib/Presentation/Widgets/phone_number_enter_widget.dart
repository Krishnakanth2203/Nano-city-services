import 'package:flutter/material.dart';
import 'package:nano_city_services/Presentation/Screens/AccountSetUp/phone_number_screen.dart';

class PhoneNumberEnterWidget extends StatefulWidget {
  final List<MenuItem> items;
  final TextEditingController numberController;
  final Function(int) onCountryCodeSelected; // ✅ NEW: Callback to send code to parent

  const PhoneNumberEnterWidget({
    super.key,
    required this.items,
    required this.numberController,
    required this.onCountryCodeSelected,
  });
  
  @override
  State<PhoneNumberEnterWidget> createState() => _PhoneNumberEnterState();
}

class _PhoneNumberEnterState extends State<PhoneNumberEnterWidget> {
  late String selectedImagePath;
  late int selectedNumber;

  @override
  void initState() {
    super.initState();
    selectedImagePath = widget.items.isNotEmpty ? widget.items.last.imagePath : '';
    selectedNumber = widget.items.isNotEmpty ? widget.items.last.number : 91;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(selectedImagePath),
            ),
            PopupMenuButton<MenuItem>(
              itemBuilder: (BuildContext context) {
                return widget.items.map((MenuItem item) {
                  return PopupMenuItem<MenuItem>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(item.imagePath),
                              radius: 12,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "+${item.number}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
              onSelected: (MenuItem selectedItem) {
                setState(() {
                  selectedImagePath = selectedItem.imagePath;
                  selectedNumber = selectedItem.number;
                });
                widget.onCountryCodeSelected(selectedItem.number); // ✅ Notify parent
              },
              child: const Icon(Icons.keyboard_arrow_down),
            ),
            const VerticalDivider(thickness: 1, color: Colors.black),
            const SizedBox(width: 5),
            Text(
              "+$selectedNumber",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: widget.numberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "9000088888",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
