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
    this.quantity = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      regularPrice: json['regularPrice'].toDouble(),
      memberPrice: json['memberPrice'].toDouble(),
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'imageUrl': imageUrl,
      'title': title,
      'regularPrice': regularPrice,
      'memberPrice': memberPrice,
      'discount': discount,
    };
  }
}
