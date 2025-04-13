import 'package:hive/hive.dart';

class CartHelper {
  static final _cartBox = Hive.box('localStorage');

  static void addOrUpdateCartItem({
    required int id,
    required String name,
    required String image,
    required double price,
    required int quantity,
  }) {
    if (_cartBox.containsKey(id)) {
      final item = _cartBox.get(id);
      item['quantity'] = quantity;
      item['price'] = price; // 🔧 auto price sync
      _cartBox.put(id, item);
    } else {
      _cartBox.put(id, {
        'name': name,
        'image': image,
        'price': price,
        'quantity': quantity,
      });
    }

    //remove if qty = 0
    if (quantity == 0) {
      _cartBox.delete(id);
    }
  }
}
