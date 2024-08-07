import 'package:http/http.dart' as http;
import 'dart:convert';

const API = '67F2B24D-1833-4801-A74D-F44FA96C4312';
const url = 'https://rest.coinapi.io/v1/exchangerate';

class Data {
  Future<dynamic> getData(String currency, String crypto) async {
    try {
      http.Response response =
          await http.get(Uri.parse('$url/$crypto/$currency?apikey=$API'));
      if (response.statusCode == 200) {
        var decodeResponse = jsonDecode(response.body);
        var rate = decodeResponse['rate'];
        return rate.toStringAsFixed(2);
      } else {
        print('error');
        print(response.statusCode);
        return 'Error';
      }
    } catch (e) {
      print('log $e');
      return 'Error';
    }
  }
}
