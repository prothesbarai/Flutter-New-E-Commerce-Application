class CategoryModel {
  final String name;
  final String tableName;

  CategoryModel({required this.name, required this.tableName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      tableName: json['table_name'],
    );
  }
}