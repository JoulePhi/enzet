class StoreModel {
  final int id;
  final String name;
  final String documentId;
  final String code;
  final String? image;
  bool isSelected;

  StoreModel({
    required this.id,
    required this.name,
    required this.code,
    required this.isSelected,
    this.documentId = '',
    this.image,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      isSelected: json['isSelected'],
      image: json['image'],
      documentId: json['documentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'isSelected': isSelected,
      'image': image,
      'documentId': documentId,
    };
  }

  StoreModel copyWith({
    int? id,
    String? name,
    String? code,
    bool? isSelected,
    String? image,
    String? documentId,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      isSelected: isSelected ?? this.isSelected,
      image: image ?? this.image,
      documentId: documentId ?? this.documentId,
    );
  }
}
