import 'package:bitcoin/services/networking.dart';
import 'package:flutter/material.dart';
NetworkModel netModel = NetworkModel();
class Padding2 extends StatefulWidget {
  const Padding2(
      {Key? key, required this.selectedCurrency, required this.mainCurrency})
      : super(key: key);

  final String selectedCurrency;
  final String mainCurrency;

  @override
  State<Padding2> createState() => _Padding2State();
}

class _Padding2State extends State<Padding2> {
  double rate = 0.0;
  void getRate(){
    netModel.getExchangeRate(widget.selectedCurrency, widget.mainCurrency);
    print(widget.mainCurrency);
    setState(() {
      rate = netModel.exRate;
    });
    print(rate);
  }

  @override
  Widget build(BuildContext context) {
    getRate();
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.mainCurrency} = ${rate.toStringAsFixed(1)} ${widget.selectedCurrency}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ); ;
  }
}

