import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/chalet_model.dart';
import '../data/repository/my_places_repo.dart';
import '../helper/api_checker.dart';
import '../utill/assets_manager.dart';

class MyPlacesController extends GetxController {
  final MyPlacesRepo myPlacesRepo = MyPlacesRepo.instance;
  @override
  onInit()async{
    super.onInit();
    await getAllChalets();
  }
  MyPlacesController() {
    services = Map<String, bool>.fromIterables(
        placeServices, List.generate(placeServices.length, (index) => false));
  }

  List<XFile> pickedImages = [];
  Governorate _selectedGovernorate = Governorate.gaza;
  XFile? licenceImage;

  Governorate get selectedGovernorate => _selectedGovernorate;
  Map<String, bool> services = {};
  List<ChaletShortInfo>? myChalets;
  ChaletModel? currentChalet;
  List<AttachmentModel>? currentChaletAttachments;
  bool isLoading = false;

  Future<void> getChaletAttachments(String chaletId) async {
    currentChaletAttachments = null;
    ApiResponse apiResponse = await myPlacesRepo.getChalet(chaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentChaletAttachments = (apiResponse.response!.data["data"] as List)
          .map((attachment) => AttachmentModel.fromMap(attachment))
          .toList();
      isLoading = false;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
    }
  }

  Future<void> getChalet(String chaletId) async {
    currentChalet = null;
    ApiResponse apiResponse = await myPlacesRepo.getChalet(chaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentChalet = ChaletModel.fromMap(apiResponse.response!.data["data"]);
      isLoading = false;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
    }
  }

  Future<void> createChalet(ChaletModel chaletModel) async {
    ApiResponse apiResponse = await myPlacesRepo.createChalet(chaletModel);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      isLoading = false;
      // Navigate to another screen
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
    }
  }

  Future<void> getAllChalets() async {
    print("----------------- getting all chalets");
    myChalets = null;
    isLoading = true;
    update();
    ApiResponse apiResponse = await myPlacesRepo.getAllChalets();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      print(apiResponse.response!.data);
      myChalets = (apiResponse.response!.data["data"] as List)
          .map((chaletInfo) => ChaletShortInfo.fromMap(chaletInfo))
          .toList();
      isLoading = false;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
    }
  }

  void changeServiceValue(String key, bool? value) {
    services[key] = value ?? false;
    update();
  }

  void removeImage(int index) {
    print("index : $index");
    pickedImages.removeAt(index);
    update();
  }

  void setGovernorate(Governorate? governorate) {
    if (governorate == null) return;
    _selectedGovernorate = governorate;
    update();
  }

  void pickLicenceImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null) {
      licenceImage = image;
      update();
    }
  }

  void pickMultiImage() async {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile> images = await imagePicker.pickMultiImage();
    if (images.isNotEmpty) {
      pickedImages.insertAll(0, images);
      if (pickedImages.length > 6) {
        pickedImages = pickedImages.sublist(0, 6);
      }
      update();
    }
  }

  int _selectedDetailsTabIndex = 0;

  int get getSelectedDetailsTabIndex => _selectedDetailsTabIndex;

  void setSelectedDetailsTabIndex(int index) {
    _selectedDetailsTabIndex = index;
    update();
  }

  final List<String> placeServices = [
    "restaurant",
    "free_wifi",
    "swimming_bool",
    "parking",
    "restaurant"
  ];
  final String dummyDetails =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum is simplydummy text of the printing.";
  final List<String> placeImages = [
    "https://img.freepik.com/free-vector/gradient-football-field-background_23-2149013355.jpg?w=996&t=st=1675283497~exp=1675284097~hmac=c32ccdd7f14980294b12546347203f9b4b504917eebad05c49c1d6393d31e736",
    "https://img.freepik.com/premium-photo/soccer-field-spotlight-background-stadium_46250-1363.jpg?w=1060"
  ];
  final List<String> myPlacesCategoriesImages = [
    // ImageAssets.apartmentsCategory,
    //ImageAssets.hotelsCategory,
    //ImageAssets.stadiumCategory,
    ImageAssets.chaletsCategory,
    //ImageAssets.officesCategory,
  ];
}
