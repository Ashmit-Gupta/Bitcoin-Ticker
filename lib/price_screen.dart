import 'dart:convert';

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'data.dart';

const API = '67F2B24D-1833-4801-A74D-F44FA96C4312';
const url = 'https://rest.coinapi.io/v1/exchangerate';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  late String price = 'Loading...';
  String selectedCurrency = 'USD';

  @override
  void initState() {
    super.initState();
    setRate();
  }

  void setRate() async {
    var newPrice = await Data().getData(selectedCurrency);
    setState(() {
      price = newPrice;
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
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC =  $price $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: CoinData().getDropdownItem(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                  setRate();
                  print(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
