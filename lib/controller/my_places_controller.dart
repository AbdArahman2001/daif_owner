import 'package:daif_owner/data/model/response/address_model.dart';
import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/booking_model.dart';
import 'package:daif_owner/data/model/response/booking_time_model.dart';
import 'package:daif_owner/data/model/response/pool_dimensions_model.dart';
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
  MyPlacesController() {
    // getAllChalets();
  }

  final MyPlacesRepo myPlacesRepo = MyPlacesRepo.instance;
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController eveningPriceController = TextEditingController();
  final TextEditingController morningPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pollLengthController = TextEditingController();
  final TextEditingController pollWidthController = TextEditingController();
  final TextEditingController pollMinDepthController = TextEditingController();
  final TextEditingController pollMaxDepthController = TextEditingController();
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

  setFieldsWithData() async {
    getAllAvailableServices();
    selectedServicesIds =
        currentChalet?.services.map((service) => service.id).toList() ?? [];
    // text fields
    placeNameController.text = currentChalet?.name ?? "";
    addressController.text = currentChalet?.address.name ?? "";
    eveningPriceController.text = currentChalet?.price.evening.toString() ?? "";
    morningPriceController.text = currentChalet?.price.morning.toString() ?? "";
    descriptionController.text = currentChalet?.description ?? "";
    pollLengthController.text =
        currentChalet?.poolDimensions.length.toString() ?? "";
    pollWidthController.text =
        currentChalet?.poolDimensions.width.toString() ?? "";
    pollMinDepthController.text =
        currentChalet?.poolDimensions.minDepth.toString() ?? "";
    pollMaxDepthController.text =
        currentChalet?.poolDimensions.maxDepth.toString() ?? "";
    videoLinkController.text = currentChalet?.videoLink ?? "";

    _selectedGovernorate =
        Helper.getGovernorateFromId(currentChalet?.governorateId ?? 0);

    // images clearing
    pickedImages = [];

    // for "place_image" tag
    final List<AttachmentModel> chaletImagesTag =
        getChaletImages(currentChaletAttachments ?? []);

    final tempImages = chaletImagesTag.map((attachment) {
      return Helper.getImageXFileByUrl(attachment.path);
    }).toList();

    for (final Future<XFile> img in tempImages) {
      pickedImages.add(await img);
    }

    // for "chalet_main_image" tag
    final String? mainPlaceImgPath =
        getChaletMainImage(currentChaletAttachments ?? [])?.path;
    if (mainPlaceImgPath != null) {
      pickedImages.add(await Helper.getImageXFileByUrl(mainPlaceImgPath));
    }

    // for "license" tag
    final String? licensePath =
        getChaletLicenseImage(currentChaletAttachments ?? [])?.path;
    if (licensePath != null) {
      licenceImage = await Helper.getImageXFileByUrl(licensePath);
    }

    update();
  }

  List<AttachmentModel> getChaletImages(List<AttachmentModel> attachments) {
    final List<AttachmentModel> _images =   _getMultiImagesWithTag(attachments, "place_image");
    final AttachmentModel? _mainImage = getChaletMainImage(attachments);
    if(_mainImage !=null){
      _images.add(_mainImage);
    }
   return _images;
  }

  getChaletLicenseImage(List<AttachmentModel> attachments) {
    return _getSingleImageWithTag(attachments, "license");
  }

   AttachmentModel? getChaletMainImage(List<AttachmentModel> attachments) {
    return _getSingleImageWithTag(attachments, "chalet_main_image");
  }

  AttachmentModel? _getSingleImageWithTag(List<AttachmentModel> attachments, String tag) {
    final AttachmentModel? result =
        attachments.firstWhereOrNull((element) => element.tag == tag);
    return result;
  }

  List<AttachmentModel> _getMultiImagesWithTag(
      List<AttachmentModel> attachments, String tag) {
    final List<AttachmentModel> result =
        attachments.where((element) => element.tag == tag).toList();
    return result;
  }

  updateChaletAndAttachments() async {
    final chaletId = await _updateChalet();
    if (chaletId != null) {
      _addChaletAttachment(chaletId);
      Get.back();
      Get.back();
      getAllChalets();
      currentChalet = null;
    }
  }

  Future<int?> _updateChalet() async {
    final ChaletModel chalet = ChaletModel(
      id: currentChalet!.id,
      videoLink: videoLinkController.text,
      name: placeNameController.text,
      address:
          AddressModel(lat: "12.2", long: "32.3", name: addressController.text),
      price: PriceModel(
          morning: double.parse(morningPriceController.text),
          evening: double.parse(eveningPriceController.text)),
      description: descriptionController.text,
      status: "null",
      governorateId: 0,
      services: selectedServicesIds
          .map((id) => ServiceModel(id: id, name: "", icon: ""))
          .toList(),
      poolDimensions: PoolDimensionsModel(
          length: num.parse(pollLengthController.text),
          width: num.parse(pollWidthController.text),
          minDepth: num.parse(pollMinDepthController.text),
          maxDepth: num.parse(pollMaxDepthController.text)),
    );
    ApiResponse apiResponse = await myPlacesRepo.updateChalet(chalet);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return apiResponse.response!.data["data"]?["chalet_id"] ?? null;
    } else {
      ApiChecker.checkApi(apiResponse);
      return null;
    }
  }

  Future<void> getAllAvailableServices() async {
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
    final chaletId = await _createChalet();
    if (chaletId != null) {
      _addChaletAttachment(chaletId);
      Get.back();
      getAllChalets();
    }
  }

  Future<void> _addChaletAttachment(int chaletId) async {
    ApiResponse apiResponse = await myPlacesRepo.addChaletAttachment(
        pickedImages, licenceImage, chaletId);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
    } else {
      ApiChecker.checkApi(apiResponse);
    }
  }

  // if success: return the chalet id, otherwise null
  Future<int?> _createChalet() async {
    final ChaletModel chalet = ChaletModel(
        id: 0,
        videoLink: videoLinkController.text,
        name: placeNameController.text,
        address: AddressModel(
            lat: "12.2", long: "32.3", name: addressController.text),
        price: PriceModel(
            morning: double.parse(morningPriceController.text),
            evening: double.parse(eveningPriceController.text)),
        description: descriptionController.text,
        status: "null",
        governorateId: (selectedGovernorate.index + 1),
        services: selectedServicesIds
            .map((id) => ServiceModel(id: id, name: "", icon: ""))
            .toList(),
        poolDimensions: PoolDimensionsModel(
            length: num.parse(pollLengthController.text),
            width: num.parse(pollWidthController.text),
            minDepth: num.parse(pollMinDepthController.text),
            maxDepth: num.parse(pollMaxDepthController.text)));
    ApiResponse apiResponse = await myPlacesRepo.createChalet(chalet);
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200 &&
        apiResponse.response!.data["error"] == false) {
      return apiResponse.response!.data["data"]?["chalet_id"] ?? null;
    } else {
      ApiChecker.checkApi(apiResponse);
      return null;
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
    XFile? image = await imagePicker.pickImage(
        source: source, imageQuality: Helper.getImageQuality(source));
    if (image != null) {
      licenceImage = image;
      update();
    }
  }

  void pickMultiImage(ImageSource? source) async {
    final ImagePicker imagePicker = ImagePicker();
    if (source != null && source == ImageSource.gallery) {
      List<XFile> images = await imagePicker.pickMultiImage(
          imageQuality: Helper.getImageQuality(source));
      if (images.isNotEmpty) {
        pickedImages.insertAll(0, images);
        if (pickedImages.length > 6) {
          pickedImages = pickedImages.sublist(0, 6);
        }
      }
    } else {
      final image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: Helper.getImageQuality(ImageSource.camera));
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
