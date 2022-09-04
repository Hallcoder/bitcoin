import 'dart:convert';
import 'package:http/http.dart' as http;
const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey=  '9F015F95-6F19-4B06-AC6D-4DC8AEA56C6E';
class NetworkModel{
  late double exRate = 0.0;

 void getExchangeRate(String currency,String mainCurrency) async{
   print(mainCurrency);
  try{
    http.Response data = await http.get(Uri.parse('$apiUrl/$mainCurrency/$currency'),headers: {
      "X-CoinAPI-Key":apiKey
    });
    print(data.body);
    exRate = (jsonDecode(data.body))['rate'];
  }catch(e){
    print(e);
  }
  }
}