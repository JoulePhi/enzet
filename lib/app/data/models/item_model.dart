class ItemModel {
  final String id;
  final String storeId; // Reference to store
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
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isActive': isActive,
    };
  }
}
