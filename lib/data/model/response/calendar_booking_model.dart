class CalendarBookingModel {
  final int id;
  final int day;
  final String customerName;
  final String customerPhoneNumber;
  final num paidAmount;
  final num bookingPrice;
  final String status;

  CalendarBookingModel({
    required this.id,
    required this.day,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.paidAmount,
    required this.bookingPrice,
    required this.status,
  });

  factory CalendarBookingModel.fromJson(Map<String, dynamic> json) {
    return CalendarBookingModel(
      id: json['id'],
      day: json['day'],
      customerName: json['customer_name'],
      customerPhoneNumber: json['customer_phone_number'],
      paidAmount: json['paid_amount'],
      bookingPrice: json['booking_price'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'paid_amount': paidAmount,
      'booking_price': bookingPrice,
      'status': status,
    };
  }
}
