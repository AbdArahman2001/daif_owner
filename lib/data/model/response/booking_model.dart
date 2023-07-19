import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/helper/data_converter.dart';

class BookingModel {
  final int id;
  final String customerName;
  final String customerPhoneNumber;
  final String customerIdentity;
  final double paidAmount;
  final double bookingPrice;
  final BookingDateModel bookingDate;
  final BookingPeriod bookingPeriod;
  final int? numberOfPersons;
  final String chaletName;
  final String status; // 0: await, 1: done, 2: canceled

  BookingModel({
    required this.id,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.customerIdentity,
    required this.paidAmount,
    required this.bookingPrice,
    required this.bookingDate,
    required this.bookingPeriod,
    required this.numberOfPersons,
    required this.chaletName,
    required this.status,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      customerName: json['customer_name'] ,
      customerPhoneNumber: json['customer_phone_number'] ,
      customerIdentity: json['customer_identity'],
      paidAmount: double.parse(json['paid_amount']?.toString()??"0.0"),
      bookingPrice: double.parse(json['booking_price']?.toString()??"0.0"),
      bookingDate: BookingDateModel.fromStringInfo(json["booking_date"]),
      bookingPeriod:DataConverter.fromStringToBookingPeriod(json['booking_period'])  ,
      numberOfPersons: json['number_of_persons'],
      chaletName: json['chalet_name'] ,
      status: json['status'] ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_name': customerName,
      'customer_phone_number': customerPhoneNumber,
      'customer_identity': customerIdentity,
      'paid_amount': paidAmount,
      'booking_price': bookingPrice,
      'booking_date': bookingDate.toStringInfo(),
      'booking_period': bookingPeriod.name,
      'number_of_persons': numberOfPersons,
    };
  }



}