import 'package:daif_owner/data/repository/booking_repo.dart';
import 'package:get/get.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/booking_model.dart';
import '../helper/api_checker.dart';

class BookingsController extends GetxController{
  final BookingRepo myPlacesRepo = BookingRepo.instance;

  int selectedTabIndex = 0;
  bool isLoading = false;
  List<BookingModel> allBookings =[];

  void changeSelectedStatus(int index){
    selectedTabIndex = index;
    update();
  }

  getAllBookings(int status)async{
    allBookings = [];
    isLoading = true;
    update();
    ApiResponse apiResponse = await myPlacesRepo.getAllBookings(status);
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
}