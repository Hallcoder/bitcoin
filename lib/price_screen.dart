import 'dart:io' show Platform;
import 'package:bitcoin/coin_data.dart';
import 'package:bitcoin/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  NetworkModel netModel = NetworkModel();
  String selectCurrency = 'USD';
  double rate = 0.0;
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < currenciesList.length; i++) {
      items.add(
        DropdownMenuItem(
          value: currenciesList[i],
          child: Text(currenciesList[i]),
        ),
      );
    }
    return DropdownButton<String>(
        value: selectCurrency,
        items: items,
        onChanged: (value) {
          setCurrencyAndRate(value);
        });
  }
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlueAccent,
        itemExtent: 32.0,
        onSelectedItemChanged: (value) {
         setCurrencyAndRate(currenciesList[value]);
        },
        children: pickerItems);
  }
  Widget getPicker(){
    if(Platform.isIOS){
      return iOSPicker();
    }else{
      return androidDropdown();
    }
  }
void setCurrencyAndRate(currency){
    setState(() {
      selectCurrency = currency;
      netModel.getBTCPrice(selectCurrency);
      rate = netModel.btcPrice;
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding:const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${rate.toStringAsFixed(1)} $selectCurrency',
                  textAlign: TextAlign.center,
                  style:const  TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
