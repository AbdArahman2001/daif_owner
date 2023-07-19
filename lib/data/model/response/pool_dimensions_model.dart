class PoolDimensionsModel {
  final num length;
  final num width;
  final num minDepth;
  final num maxDepth;

  PoolDimensionsModel(
      {required this.length,
      required this.width,
      required this.minDepth,
      required this.maxDepth});

  factory PoolDimensionsModel.fromJson(Map<String, dynamic> json) {
    return PoolDimensionsModel(
        length: json["length"]??0,
        width: json["width"]??0,
        minDepth: json["minDepth"]??0,
        maxDepth: json["maxDepth"]??0);

  }

  Map<String,dynamic> toJson(){
    return {
      "length":length,
      "width":width,
      "minDepth":minDepth,
      "maxDepth":maxDepth,
    };
  }
}
