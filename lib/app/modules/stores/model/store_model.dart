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
}
