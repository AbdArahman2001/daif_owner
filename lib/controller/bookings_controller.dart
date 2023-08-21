import 'dart:developer';

import 'package:daif_owner/controller/calendar_controller.dart';
import 'package:daif_owner/controller/my_places_controller.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:daif_owner/data/repository/booking_repo.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:daif_owner/localization/my_localizations.dart';
import 'package:daif_owner/utill/app_constants.dart';
import 'package:daif_owner/view/basewidget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/model/response/attachment_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/booking_model.dart';
import '../helper/api_checker.dart';
import '../view/screens/calendar/widget/calendar_booking_short_info_widget.dart';

class BookingsController extends GetxController {
  BookingsController() {
    customerNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    customerIdentity = TextEditingController();
    bookingPriceController = TextEditingController();
    paidAmountController = TextEditingController();
    numberOfPersonsControllers = TextEditingController();
  }

  // final PagingController<int, BookingModel> pagingController =
  //     PagingController(firstPageKey: 1);
  final bookingFormKey = GlobalKey<FormState>(debugLabel: "booking_form_key");
  final status0refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(debugLabel: "state_0");
  final status1refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(debugLabel: "state_1");
  final status2refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>(debugLabel: "state_2");
  Map<int, List<BookingModel>?> cachedBookings = {};
  bool isDataEdited = false;
  final BookingRepo bookingsRepo = BookingRepo.instance;
  final pageViewController = PageController(initialPage: 0,keepPage: false);
  late final TextEditingController customerNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController customerIdentity;
  late final TextEditingController bookingPriceController;
  late final TextEditingController paidAmountController;
  late final TextEditingController numberOfPersonsControllers;

  int selectedTabIndex = 0;
  int? selectedChaletId;

  List<BookingModel>? allBookings = [];
  List<AttachmentModel> currentBookingAttachments =
      []; // the attachments that fetched form server
  List<XFile> chosenBookingAttachments =
      []; // the images that user upload it when creating a new booking
  DateTime? bookingDate;
  BookingPeriod selectedBookingPeriod = BookingPeriod.morning;
  List<ChaletShortInfo>? chaletsInfo;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(microseconds: 1))
        .then((value) => getAllBookings(0));
  }

  raiseEditingFlag(String? input) {
    isDataEdited = true;
  }

  List<BookingModel>? getCachedBookings(int status) {
    final List<BookingModel>? result = cachedBookings[status];
    return result;
  }

  setCachedBookings(int status, List<BookingModel> bookings) {
    cachedBookings[status] = bookings;
  }

  refreshBookings({int? status}){
   cachedBookings[status??selectedTabIndex] = null;
    getAllBookings(status??selectedTabIndex);
  }

  setFieldsWithData(BookingModel bookingModel) async {
    isDataEdited = false;
    // text fields
    customerNameController.text = bookingModel.customerName;
    phoneNumberController.text = bookingModel.customerPhoneNumber;
    customerIdentity.text = bookingModel.customerIdentity;
    bookingPriceController.text = bookingModel.bookingPrice.toString();
    paidAmountController.text = bookingModel.paidAmount.toString();
    numberOfPersonsControllers.text = bookingModel.numberOfPersons.toString();

    bookingDate = bookingModel.bookingDate.toDateTime();
    selectedBookingPeriod = bookingModel.bookingPeriod;
    // images clearing
    chosenBookingAttachments = [];

    final tempImages = currentBookingAttachments.map((attachment) {
      return Helper.getImageXFileByUrl(attachment.path);
    }).toList();

    for (final Future<XFile> img in tempImages) {
      chosenBookingAttachments.add(await img);
    }

    update();
  }

  updateBookingWithItsAttachments(int bookingId, BuildContext context) async {
    if (!(bookingFormKey.currentState!.validate())) return;
    if (bookingDate == null) {
      final locale = MyLocalizations.translate(context);
      CustomSnackBar.instance
          .showCustomErrorToast(message: locale.enter_booking_date);
      return;
    }
    final result = await _updateBookingInfo(bookingId);
    if (result) {
      _addBookingAttachments(bookingId);
    }
    clearData();
    Get.back<bool>();
    Get.back<bool>();
  }

  Future<bool> cancelBooking(int bookingId)async{
    ApiResponse apiResponse = await bookingsRepo.cancelBooking(
      bookingId,
    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      refreshBookings(status: 0);
      cachedBookings[2] = null;// clear the canceled from cache
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  Future<bool> completeBookingPayment(int bookingId, BookingModel bookingModel)async{
    ApiResponse apiResponse = await bookingsRepo.updateBookingInfo(
      bookingId,
      BookingModel(
          id: bookingId,
          customerName: bookingModel.customerName,
          customerPhoneNumber: bookingModel.customerPhoneNumber,
          customerIdentity:bookingModel.customerIdentity,
          paidAmount: bookingModel.bookingPrice,
          bookingPrice: bookingModel.bookingPrice,
          bookingDate: bookingModel.bookingDate,
          bookingPeriod:bookingModel.bookingPeriod,
          numberOfPersons: bookingModel.numberOfPersons,
          chaletName: "",
          status: "0"),
    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  Future<bool> _updateBookingInfo(int bookingId) async {
    ApiResponse apiResponse = await bookingsRepo.updateBookingInfo(
      bookingId,
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
    );
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  void changeSelectedChalet(int? chaletId) {
    selectedChaletId = chaletId;
    update();
  }

  void changeSelectedStatus(int index) {
    log(index.toString());
    if (index > 2) return;
    selectedTabIndex = index;
    getAllBookings(index);

  }

  Future<bool> getChaletIdWithName() async {
    final controller = Get.find<MyPlacesController>();
    final List<ChaletShortInfo>? result = await controller.getAllChalets();
    if (result == null || result.isEmpty) return false;
    chaletsInfo = result;
    selectedChaletId = result.first.id;
    return true;
  }

  createNewBookingWithItsAttachments(BuildContext context) async {
    if (!(bookingFormKey.currentState!.validate())) return;
    if (bookingDate == null) {
      final locale = MyLocalizations.translate(context);
      CustomSnackBar.instance
          .showCustomErrorToast(message: locale.enter_booking_date);
      return;
    }
    final bookingId = await _createNewBooking();
    if (bookingId != null) {
      await _addBookingAttachments(bookingId);
      refreshBookings();
    }
    clearData();
    Get.back<bool>();
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
        selectedChaletId!);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return apiResponse.response!.data["data"]["id"];
    } else {
      ApiChecker.checkApi(apiResponse);
      return null;
    }
  }

  Future<void> _addBookingAttachments(int bookingId) async {
    if (chosenBookingAttachments.isEmpty) {
      return;
    }
    ApiResponse apiResponse = await bookingsRepo.addBookingAttachments(
        bookingId, chosenBookingAttachments);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  getBookingAttachments(int bookingId) async {
    currentBookingAttachments = [];
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
    update();
  }

  getAllBookings(int status) async {
    final result = getCachedBookings(status);
    if (result != null) {
      allBookings = result;
      update();
      return;
    }
    allBookings = null;
    ApiResponse apiResponse = await bookingsRepo.getAllBookings(status: status);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      allBookings = (apiResponse.response!.data["data"] as List)
          .map((booking) => BookingModel.fromJson(booking))
          .toList();
      update();
      if (allBookings != null) {
        setCachedBookings(status, allBookings!);
      }

    } else {
      ApiChecker.checkApi(apiResponse);
    }
    return;
  }

  void removeImage(int index) {
    raiseEditingFlag(null);
    chosenBookingAttachments.removeAt(index);
    update();
  }

  void pickMultiImage(ImageSource? source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source != null && source == ImageSource.gallery) {
      List<XFile> images = await imagePicker.pickMultiImage(
          imageQuality: Helper.getImageQuality(source));
      if (images.isNotEmpty) {
        raiseEditingFlag(null);
        chosenBookingAttachments?.insertAll(0, images);
        if (chosenBookingAttachments != null &&
            chosenBookingAttachments!.length > 2) {
          chosenBookingAttachments = chosenBookingAttachments!.sublist(0, 2);
        }
      }
    } else {
      final image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: Helper.getImageQuality(ImageSource.camera));
      if (image != null &&
          chosenBookingAttachments != null &&
          chosenBookingAttachments!.length < 6) {
        raiseEditingFlag(null);
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
      raiseEditingFlag(null);
      bookingDate = result;
      update();
    }
  }

  changeSelectedPeriod(BookingPeriod? period) {
    final calendarController = Get.find<CalendarController>();
    if (period != null) {
      selectedBookingPeriod = period;
      calendarController.getCalendarBookings();
    }
  }

  changeSelectedPeriodWithoutGetDate(BookingPeriod? period) {
    if (period != null) {
      raiseEditingFlag(null);
      selectedBookingPeriod = period;
      update();
    }
  }

  setBookingDate(BookingDateModel bookingDateModel) {
    bookingDate = bookingDateModel.toDateTime();
  }

  clearData() {
    chosenBookingAttachments.clear();
    customerNameController.clear();
    phoneNumberController.clear();
    customerIdentity.clear();
    bookingPriceController.clear();
    paidAmountController.clear();
    numberOfPersonsControllers.clear();
    bookingDate = null;
    isDataEdited = false;
  }
}
