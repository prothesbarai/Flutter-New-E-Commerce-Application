class ProductModel {
  final int id;
  final String imageUrl;
  final String title;
  final double regularPrice;
  final double memberPrice;
  final int discount;
  int quantity;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.regularPrice,
    required this.memberPrice,
    required this.discount,
    this.quantity = 0
  });

  // Map to Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: int.parse(map['id'].toString()),
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      regularPrice: double.parse(map['regularPrice'].toString()),
      memberPrice: double.parse(map['memberPrice'].toString()),
      discount: int.parse(map['discount'].toString()),
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



