class StoreModel {
  final int id;
  final String name;
  final String code;
  final String? image;
  bool isSelected;

  StoreModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isSelected,
    this.image,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      isSelected: json['isSelected'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isSelected': isSelected,
      'image': image,
    };
  }
}
