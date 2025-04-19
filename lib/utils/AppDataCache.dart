import '../models/product_model.dart';
import '../models/catagory_models.dart';

class AppDataCache {
  static final AppDataCache _instance = AppDataCache._internal();
  factory AppDataCache() => _instance;
  AppDataCache._internal();

  List<CategoryModel> categories = [];
  Map<String, List<ProductModel>> productsByCategory = {};
}
