import 'package:get/get.dart';

class BookingsController extends GetxController{
  int selectedTabIndex = 0;
  void changeSelectedStatus(int index){
    selectedTabIndex = index;
    update();
  }
}