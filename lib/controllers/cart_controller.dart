import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = [].obs;

  //add to cart

  void addOrRemovefromCart(var product) {
    
    if (cartItems.contains(product)) {
      cartItems.remove(product);
    } else {
      cartItems.add(product);
    }
    update();
  }

}
