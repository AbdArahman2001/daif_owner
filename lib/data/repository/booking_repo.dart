import 'package:dio/dio.dart';

import '../model/response/base/api_response.dart';
import '../remote/dio/dio_client.dart';

class BookingRepo{
  BookingRepo._();

  static final instance = BookingRepo._();
  final DioClient dioClient = DioClient.dioClient;
  getAllBookings(int status) async {
    try {
      Response response = await dioClient.get(
          "/owner/booking?status=$status"
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

}