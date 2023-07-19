import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../model/response/attachment_model.dart';
import '../model/response/base/api_response.dart';
import '../remote/dio/dio_client.dart';

class BookingRepo {
  BookingRepo._();

  static final instance = BookingRepo._();
  final DioClient dioClient = DioClient.dioClient;



  updateBookingInfo(int bookingId,BookingModel bookingModel) async {
    try {
      Response response = await dioClient.put(
          "/owner/booking/$bookingId/update",data:bookingModel.toJson() );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getBookingInfo(int bookingId) async {
    try {
      Response response = await dioClient.get(
          "/owner/booking/$bookingId");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getCalendarBookings(
      {required int chaletId,
        required int year,
        required int month,
        required String period}) async {
    try {
      Response response = await dioClient.get(
          "/owner/chalet/$chaletId/booking/get-calendar?year=$year&month=$month&period=$period");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  addBookingAttachments(int bookingId, List<XFile> images) async {
    try {
      List<Map<String, dynamic>> files = [];
      for (final image in images) {
        String fileName = image.path.split('/').last;
        files.add({
          "image": await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
          "tag": "booking_attachment",
        });
      }
      FormData data = FormData.fromMap({"images": files});

      Response response = await dioClient
          .post("/owner/booking/$bookingId/attachment", data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getBookingAttachments(int bookingId) async {
    try {
      Response response =
          await dioClient.get("/owner/booking/$bookingId/attachment");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getAllBookings(int status) async {
    try {
      Response response = await dioClient.get("/owner/booking?status=$status");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  createNewBooking(BookingModel bookingModel, int chaletId) async {
    try {
      Response response = await dioClient.post(
          "/owner/chalet/$chaletId/booking/create",
          data: bookingModel.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
