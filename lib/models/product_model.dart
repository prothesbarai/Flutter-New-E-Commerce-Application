class ProductModel {
  final int id;
  final String imageUrl;
  final String title;
  final double regularPrice;
  final double memberPrice;
  final int discount;
  final int total_quantity;
  int quantity;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.regularPrice,
    required this.memberPrice,
    required this.discount,
    required this.total_quantity,
    this.quantity = 0,
  });

  // Safe number parser
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    final cleaned = value.toString().replaceAll(RegExp(r'[^\d]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  // Map to Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: _parseInt(map['id']),
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      regularPrice: _parseDouble(map['regularPrice']),
      memberPrice: _parseDouble(map['memberPrice']),
      discount: _parseInt(map['discount']),
      total_quantity: _parseInt(map['total_quantity']),
    );
  }


/*// (Optional) Model to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'regularPrice': regularPrice,
      'memberPrice': memberPrice,
      'discount': discount,
    };
  }*/
}



