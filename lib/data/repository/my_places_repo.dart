import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../utill/app_constants.dart';
import '../local/my_shared_pref.dart';
import '../model/response/attachment_model.dart';
import '../model/response/base/api_response.dart';
import '../remote/dio/dio_client.dart';

class MyPlacesRepo {
  MyPlacesRepo._();

  static final instance = MyPlacesRepo._();
  final DioClient dioClient = DioClient.dioClient;
  final sharedPreferences = MySharedPref.instance;

  getAllChalets() async {
    try {
      Response response = await dioClient.get(
        AppConstants.getAllChalets,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  createChalet(ChaletModel chaletModel) async {
    try {
      Response response = await dioClient.post(
        AppConstants.createChalet,
        data: chaletModel.toMap(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getChalet(int chaletId) async {
    try {
      Response response = await dioClient.get(
        "/owner/chalet/$chaletId",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  addChaletAttachment(List<XFile> images, int chaletId) async {
    try {
      List<MultipartFile> files = [];
      for (final image in images) {
        String fileName = image.path.split('/').last;
        files.add(
          await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        );
      }
      FormData data = FormData.fromMap({"images": files});

      Response response = await dioClient
          .post("/owner/chalet/$chaletId/attachment", data: data);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getChaletAttachments(int chaletId) async {
    try {
      Response response =
          await dioClient.get("/owner/chalet/$chaletId/attachment");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getAllAvailableServices() async {
    try {
      Response response = await dioClient.get(AppConstants.services);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}
