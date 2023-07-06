import 'package:daif_owner/data/model/response/address_model.dart';
import 'package:daif_owner/data/model/response/attachment_model.dart';
import 'package:daif_owner/data/model/response/price_model.dart';
import 'package:daif_owner/data/model/response/service_model.dart';

class ChaletShortInfo{
  ChaletShortInfo({required this.id, required this.name,required this.image,required this.governorateId,required this.address,required this.price, });
  final int id;
  final String name;
  final AttachmentModel image;
  final int governorateId;
  final  AddressModel address;
  final PriceModel price;

  factory ChaletShortInfo.fromMap(Map<String, dynamic> map) {
    return ChaletShortInfo(
      id: map['id'] ,
      name: map['name'] ,
      image: AttachmentModel.fromMap(map['image']?? {}) ,
      governorateId: map['governorate_id'] ,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      price: PriceModel.fromMap(map['price'] as Map<String, dynamic>),
    );
  }
}

class ChaletModel {
  int id;
  String name;
  AddressModel address;
  PriceModel price;
  String description;
  String status;
  int governorateId;
  List<ServiceModel> services;
final String videoLink;
  ChaletModel( {
    required this.videoLink,
    required this.id,
    required this.name,
    required this.address,
    required this.price,
    required this.description,
    required this.status,
    required this.governorateId,
    required this.services,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address.toMap(),
      'price': price.toMap(),
      'description': description,
      'governorate_id': governorateId,
      'video_link': videoLink,
      'services_ids': services.map((service) => service.id).toList(),
    };
  }

  factory ChaletModel.fromMap(Map<String, dynamic> map) {
    return ChaletModel(
      id: map['id'] ,
      videoLink: map['video_link']??"" ,
      name: map['name'] as String,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      price: PriceModel.fromMap(map['price'] as Map<String, dynamic>),
      description: map['description'] ,
      status: map['status'] ,
      governorateId: map['governorate_id'] ,
      services: List<ServiceModel>.from((map['services'] as List<dynamic>)
          .map((service) => ServiceModel.fromMap(service as Map<String, dynamic>))),
    );
  }
}





