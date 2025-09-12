import 'package:nano_city_services/Presentation/Widgets/paid_box_style_widget.dart';

class DummyOrder {
  final String title;
  final String icon;
  final double amount;
  final String date;
  final String name;
  final String time;
  

  DummyOrder({
    required this.title,
    required this.icon,
    required this.amount,
    required this.date,
    required this.name,
    required this.time,
   
  });
}

List<DummyOrder> dummyUnpaidOrders = [];
