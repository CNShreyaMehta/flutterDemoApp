import 'package:demo_app/presentation/screens/product_tile.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Product>?> fetchProducts() async {
    var response = await client.get(Uri.parse(
        'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      // ignore: avoid_print
      //print('jsonString: $jsonString');
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}