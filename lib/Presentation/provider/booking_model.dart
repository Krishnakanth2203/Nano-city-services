class BookingModel {
  final String serviceTitle;
  final String customerName;
  final String providerName;
  final String date;
  final String time;
  final double amount;
  final String iconPath;

  BookingModel({
    required this.serviceTitle,
    required this.customerName,
    required this.providerName,
    required this.date,
    required this.time,
    required this.amount,
    required this.iconPath,
  });
}
