import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:daif_owner/data/repository/booking_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/model/response/attachment_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/booking_model.dart';
import '../helper/api_checker.dart';

class BookingsController extends GetxController {
  BookingsController() {
    customerNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    customerIdentity = TextEditingController();
    bookingPriceController = TextEditingController();
    paidAmountController = TextEditingController();
    numberOfPersonsControllers = TextEditingController();
  }

  final calendarController = Get.find<CalendarController>();
  final BookingRepo bookingsRepo = BookingRepo.instance;

  late final TextEditingController customerNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController customerIdentity;
  late final TextEditingController bookingPriceController;
  late final TextEditingController paidAmountController;
  late final TextEditingController numberOfPersonsControllers;

  int selectedTabIndex = 0;
  int selectedChaletId = 1;
  bool isLoading = false;
  List<BookingModel> allBookings = [];
  List<AttachmentModel> currentBookingAttachments =
      []; // the attachments that fetched form server
  DateTime? bookingDate;
  BookingPeriod selectedBookingPeriod = BookingPeriod.morning;
  List<ChaletShortInfo>? chaletsInfo;

  List<XFile> chosenBookingAttachments =
      []; // the images that user upload it when creating a new booking

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => getAllBookings(0));
  }

  void changeSelectedChalet(int? chaletId) {
    selectedChaletId = chaletId ?? 1;
  }

  void changeSelectedStatus(int index) {
    selectedTabIndex = index;
    getAllBookings(index);
  }

  Future<bool> getChaletIdWithName() async {
    final controller = Get.find<MyPlacesController>();
    final List<ChaletShortInfo>? result = await controller.getAllChalets();
    if (result == null) return false;
    chaletsInfo = result;
    return true;
  }

  createNewBookingWithItsAttachments() async {
    final bookingId = await _createNewBooking();
    if (bookingId != null) {
      _addBookingAttachments(bookingId);
    }
  }

  Future<int?> _createNewBooking() async {
    ApiResponse apiResponse = await bookingsRepo.createNewBooking(
        BookingModel(
            id: 0,
            customerName: customerNameController.text,
            customerPhoneNumber: phoneNumberController.text,
            customerIdentity: customerIdentity.text,
            paidAmount: double.parse(paidAmountController.text),
            bookingPrice: double.parse(bookingPriceController.text),
            bookingDate: BookingDateModel.fromDateTime(bookingDate!),
            bookingPeriod: selectedBookingPeriod,
            numberOfPersons: int.parse(numberOfPersonsControllers.text),
            chaletName: "",
            status: "0"),
        selectedChaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return apiResponse.response!.data["data"]["id"];
    } else {
      ApiChecker.checkApi(apiResponse);
      return null;
    }
  }

  Future<bool> _addBookingAttachments(int bookingId) async {
    ApiResponse apiResponse = await bookingsRepo.addBookingAttachments(
        bookingId, chosenBookingAttachments!);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  getBookingAttachments(int bookingId) async {
    currentBookingAttachments = [];
    isLoading = true;
    update();
    ApiResponse apiResponse =
        await bookingsRepo.getBookingAttachments(bookingId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentBookingAttachments = (apiResponse.response!.data["data"] as List)
          .map((booking) => AttachmentModel.fromMap(booking))
          .toList();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    isLoading = false;
    update();
  }

  getAllBookings(int status) async {
    allBookings = [];
    isLoading = true;
    ApiResponse apiResponse = await bookingsRepo.getAllBookings(status);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      allBookings = (apiResponse.response!.data["data"] as List)
          .map((booking) => BookingModel.fromJson(booking))
          .toList();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    isLoading = false;
    update();
  }

  void removeImage(int index) {
    print("index : $index");
    chosenBookingAttachments?.removeAt(index);
    update();
  }

  void pickMultiImage(ImageSource? source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source != null && source == ImageSource.gallery) {
      List<XFile> images = await imagePicker.pickMultiImage();
      if (images.isNotEmpty) {
        chosenBookingAttachments?.insertAll(0, images);
        if (chosenBookingAttachments != null &&
            chosenBookingAttachments!.length > 2) {
          chosenBookingAttachments = chosenBookingAttachments!.sublist(0, 2);
        }
      }
    } else {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null &&
          chosenBookingAttachments != null &&
          chosenBookingAttachments!.length < 6) {
        chosenBookingAttachments!.insert(0, image);
      }
    }
    update();
  }

  pickdate(BuildContext context) async {
    final DateTime? result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime((DateTime.now().year - 1)),
        lastDate: DateTime((DateTime.now().year + 1)));
    if (result != null) {
      bookingDate = result;
      update();
    }
  }

  changeSelectedPeriod(BookingPeriod? period) {
    if (period != null) {
      selectedBookingPeriod = period;
      calendarController.getCalendarBookings();
    }
  }
}
