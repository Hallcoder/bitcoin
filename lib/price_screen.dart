import 'dart:io' show Platform;
import 'package:bitcoin/coin_data.dart';
import 'package:bitcoin/components/Padding.dart';
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
  // List<Widget> getCurrencyBlocks() {
  //   List<Padding2> currencyBlocks = [];
  //   for (String crypto in cryptoList) {
  //     currencyBlocks.add(
  //       Padding2(selectedCurrency: selectCurrency, mainCurrency: crypto),
  //     );
  //   }
  //   return currencyBlocks;
  // }

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
          setCurrency(value);
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
        setCurrency(currenciesList[value]);
      },
      children: pickerItems,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropdown();
    }
  }

  void setCurrency(currency) {
    setState(() {
      selectCurrency = currency;
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
         Padding2(selectedCurrency: selectCurrency, mainCurrency: 'ETH'),
         Padding2(selectedCurrency: selectCurrency, mainCurrency: 'LTC'),
         Padding2(selectedCurrency: selectCurrency, mainCurrency: 'BTC'),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}
