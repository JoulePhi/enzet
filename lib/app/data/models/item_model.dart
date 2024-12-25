class ItemModel {
  final String id;
  final String documentId;
  final String storeId;
  final String supplier;
  final String type;
  final String name;
  final String code;
  final String material;
  final String color;
  final double price;
  final List<String> imageUrls;
  final String? printing;
  final String? article;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  ItemModel({
    required this.id,
    required this.documentId,
    required this.storeId,
    required this.supplier,
    required this.type,
    required this.name,
    required this.code,
    required this.material,
    required this.color,
    required this.price,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.printing,
    this.article,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      documentId: json['documentId'],
      storeId: json['storeId'],
      supplier: json['supplier'],
      type: json['type'],
      name: json['name'],
      code: json['code'],
      material: json['material'],
      color: json['color'],
      price: json['price'],
      imageUrls: List<String>.from(json['imageUrls']),
      printing: json['printing'],
      article: json['article'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentId': documentId,
      'storeId': storeId,
      'supplier': supplier,
      'type': type,
      'name': name,
      'code': code,
      'material': material,
      'color': color,
      'price': price,
      'imageUrls': imageUrls,
      'printing': printing,
      'article': article,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  // create copyWith method
  ItemModel copyWith({
    String? id,
    String? documentId,
    String? storeId,
    String? supplier,
    String? type,
    String? name,
    String? code,
    String? material,
    String? color,
    double? price,
    List<String>? imageUrls,
    String? printing,
    String? article,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return ItemModel(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      storeId: storeId ?? this.storeId,
      supplier: supplier ?? this.supplier,
      type: type ?? this.type,
      name: name ?? this.name,
      code: code ?? this.code,
      material: material ?? this.material,
      color: color ?? this.color,
      price: price ?? this.price,
      imageUrls: imageUrls ?? this.imageUrls,
      printing: printing ?? this.printing,
      article: article ?? this.article,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
