import 'dart:convert';
import 'package:http/http.dart' as http;
const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey=  '9F015F95-6F19-4B06-AC6D-4DC8AEA56C6E';
class NetworkModel{
  late double btcPrice = 0.0;

 void getBTCPrice() async{
  try{
    http.Response data = await http.get(Uri.parse('$apiUrl/BTC/USD'),headers: {
      "X-CoinAPI-Key":apiKey
    });
    print((jsonDecode(data.body))['rate']);
    btcPrice = (jsonDecode(data.body))['rate'];
  }catch(e){
    print(e);

  }
  }
}