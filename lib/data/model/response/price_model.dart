class PriceModel {
  String morning;
  String evening;

  PriceModel({
    required this.morning,
    required this.evening,
  });

  Map<String, dynamic> toMap() {
    return {
      'morning': morning,
      'evening': evening,
    };
  }

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    return PriceModel(
      morning: map['morning'] as String,
      evening: map['evening'] as String,
    );
  }
}
