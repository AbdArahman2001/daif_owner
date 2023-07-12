class AttachmentModel {
 final int id;
 final  String path;
 final  String tag; // for chalet: "place_image", "license", "chalet_main_image",
                    // for booking: "booking_attachment"


  AttachmentModel({
    required this.id,
    required this.path,
    required this.tag,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'tag': tag,
    };
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id']??0 ,
      path: map['path']??"",
      tag: map['tag']??"",
    );
  }
}
