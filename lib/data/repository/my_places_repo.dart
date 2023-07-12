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

  updateChalet(int chaletId,ChaletModel chalet) async {
    try {
      Response response = await dioClient.put(
        "/owner/chalet/$chaletId/update",
        data:chalet.toUpdatedChalet()
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

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

  addChaletAttachment(
      List<XFile> images, XFile? licenseImage, int chaletId) async {
    try {
      List<Map<String, dynamic>> files = [];
      for (int i = 0; i < images.length; i++) {
        String fileName = images[i].path.split('/').last;
        files.add({
          "image": await MultipartFile.fromFile(
            images[i].path,
            filename: fileName,
          ),
          "tag": i == 0 ? "chalet_main_image" : "place_image",
        });
      }
      // license image
      if(licenseImage!=null) {
        files.add(({
          "image": await MultipartFile.fromFile(
            licenseImage.path,
            filename: licenseImage.path
                .split('/')
                .last,
          ),
          "tag": "license",
        }));
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
