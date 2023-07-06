class AttachmentModel {
  int id;
  String path;

  AttachmentModel({
    required this.id,
    required this.path,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }

  factory AttachmentModel.fromMap(Map<String, dynamic> map) {
    return AttachmentModel(
      id: map['id'] ,
      path: map['path'],
    );
  }
}
