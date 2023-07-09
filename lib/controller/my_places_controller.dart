import 'package:daif_owner/data/model/response/address_model.dart';
import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/price_model.dart';
import 'package:daif_owner/data/model/response/service_model.dart';
import 'package:daif_owner/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/chalet_model.dart';
import '../data/repository/my_places_repo.dart';
import '../helper/api_checker.dart';
import '../utill/assets_manager.dart';

class MyPlacesController extends GetxController {
  final MyPlacesRepo myPlacesRepo = MyPlacesRepo.instance;
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController eveningPriceController = TextEditingController();
  final TextEditingController morningPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pollLengthController = TextEditingController();
  final TextEditingController pollWidthController = TextEditingController();
  final TextEditingController pollMinHeightController = TextEditingController();
  final TextEditingController pollMinWidthController = TextEditingController();
  final TextEditingController videoLinkController = TextEditingController();

  List<XFile> pickedImages = [];
  Governorate _selectedGovernorate = Governorate.gaza;
  XFile? licenceImage;

  Governorate get selectedGovernorate => _selectedGovernorate;
  List<ChaletShortInfo>? myChalets;
  ChaletModel? currentChalet;
  List<AttachmentModel>? currentChaletAttachments;
  bool isLoading = false;
  List<int> selectedServicesIds = [];
  List<ServiceModel> allAvailableServices = [];

  getAllAvailableServices() async {
    allAvailableServices = [];
    isLoading = true;
    update();
    ApiResponse apiResponse = await myPlacesRepo.getAllAvailableServices();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      allAvailableServices =
          (apiResponse.response!.data["data"]["services"] as List)
              .map((service) => ServiceModel.fromMap(service))
              .toList();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
    isLoading = false;
    update();
  }

  Future<void> _getChaletAttachments(int chaletId) async {
    currentChaletAttachments = null;
    ApiResponse apiResponse = await myPlacesRepo.getChaletAttachments(chaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentChaletAttachments = (apiResponse.response!.data["data"] as List)
          .map((attachment) => AttachmentModel.fromMap(attachment))
          .toList();
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  getChaletInfoAndAttachments(int chaletId) async {
    if (currentChalet != null && currentChalet!.id == chaletId) return;
    isLoading = true;
    await _getChalet(chaletId);
    await _getChaletAttachments(chaletId);
    isLoading = false;
    update();
  }

  Future<void> _getChalet(int chaletId) async {
    currentChalet = null;
    ApiResponse apiResponse = await myPlacesRepo.getChalet(chaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      currentChalet = ChaletModel.fromMap(apiResponse.response!.data["data"]);
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  createChaletWithAttachments() async {
    final result = await _createChalet();
    if (result) {
      _addChaletAttachment();
      Get.back();
      getAllChalets();
    }
  }

  Future<void> _addChaletAttachment() async {
    ApiResponse apiResponse =
        await myPlacesRepo.addChaletAttachment(pickedImages, currentChalet!.id);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  Future<bool> _createChalet() async {
    final ChaletModel chalet = ChaletModel(
      id: 0,
      videoLink: videoLinkController.text,
      name: placeNameController.text,
      address:
          AddressModel(lat: "12.2", long: "32.3", name: addressController.text),
      price: PriceModel(
          morning: double.parse(morningPriceController.text),
          evening: double.parse(eveningPriceController.text)),
      description: descriptionController.text,
      status: "null",
      governorateId: (selectedGovernorate.index + 1),
      services: selectedServicesIds
          .map((id) => ServiceModel(id: id, name: "", icon: ""))
          .toList(),
    );
    ApiResponse apiResponse = await myPlacesRepo.createChalet(chalet);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return true;
    } else {
      ApiChecker.checkApi(apiResponse);
      return false;
    }
  }

  Future<List<ChaletShortInfo>?> getAllChalets() async {
    myChalets = null;
    isLoading = true;
    update();
    ApiResponse apiResponse = await myPlacesRepo.getAllChalets();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      myChalets = (apiResponse.response!.data["data"] as List)
          .map((chaletInfo) => ChaletShortInfo.fromMap(chaletInfo))
          .toList();
      isLoading = false;
      update();
      return myChalets;
    } else {
      isLoading = false;
      update();
      ApiChecker.checkApi(apiResponse);
      return null;
    }
  }

  // select/unselect
  changeServiceStatus(int serviceId) {
    if (selectedServicesIds.contains(serviceId)) {
      selectedServicesIds.remove(serviceId);
    } else {
      selectedServicesIds.add(serviceId);
    }
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

  void pickMultiImage(ImageSource? source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source != null && source == ImageSource.gallery) {
      List<XFile> images = await imagePicker.pickMultiImage();
      if (images.isNotEmpty) {
        pickedImages.insertAll(0, images);
        if (pickedImages.length > 6) {
          pickedImages = pickedImages.sublist(0, 6);
        }
      }
    } else {
      final image = await imagePicker.pickImage(source: ImageSource.camera);
      if (image != null && pickedImages.length < 6) {
        pickedImages.insert(0, image);
      }
    }
    update();
  }

  int _selectedDetailsTabIndex = 0;

  int get getSelectedDetailsTabIndex => _selectedDetailsTabIndex;

  void setSelectedDetailsTabIndex(int index) {
    _selectedDetailsTabIndex = index;
    update();
  }

  final List<String> myPlacesCategoriesImages = [
    // ImageAssets.apartmentsCategory,
    //ImageAssets.hotelsCategory,
    //ImageAssets.stadiumCategory,
    ImageAssets.chaletsCategory,
    //ImageAssets.officesCategory,
  ];
}
