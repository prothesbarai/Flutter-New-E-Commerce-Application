class ProductModel {
  final String imageUrl;
  final String title;
  final double regularPrice;
  final double memberPrice;
  final int discount;

  ProductModel({
    required this.imageUrl,
    required this.title,
    required this.regularPrice,
    required this.memberPrice,
    required this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json['imageUrl'],
      title: json['title'],
      regularPrice: json['regularPrice'].toDouble(),
      memberPrice: json['memberPrice'].toDouble(),
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'regularPrice': regularPrice,
      'memberPrice': memberPrice,
      'discount': discount,
    };
  }
}
