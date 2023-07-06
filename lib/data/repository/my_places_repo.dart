import 'package:daif_owner/data/model/response/chalet_model.dart';
import 'package:dio/dio.dart';

import '../../utill/app_constants.dart';
import '../local/my_shared_pref.dart';
import '../model/response/base/api_response.dart';
import '../remote/dio/dio_client.dart';

class MyPlacesRepo{
  MyPlacesRepo._();
  static final instance = MyPlacesRepo._();
  final DioClient dioClient = DioClient.dioClient;
  final sharedPreferences = MySharedPref.instance;

  getAllChalets()async{
    print("--------------- get all chalets");
    try {
      Response response = await dioClient.get(
        AppConstants.getAllChalets,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("-----------------error : ${e}");
      return ApiResponse.withError(e);
    }
  }

  createChalet(ChaletModel chaletModel)async{
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

  getChalet(String chaletId)async{
    try {
      Response response = await dioClient.get(
        "${AppConstants.getChalet}/$chaletId",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }

  getChaletAttachments(String chaletId)async{
    try {
      Response response = await dioClient.get(
        AppConstants.getChaletAttachments
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(e);
    }
  }
}