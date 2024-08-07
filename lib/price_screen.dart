import 'package:bitcoin_ticker/cardLayout.dart';
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
  late String btcPrice = 'Loading...';
  late String ethPrice = 'Loading...';
  late String ltcPrice = 'Loading...';
  String selectedCurrency = 'USD';
  String crypto = 'BTC';
  @override
  void initState() {
    super.initState();
    setRate();
  }

  //TODO getting error to many requests
  void setRate() async {
    try {
      var newPriceBTC = await Data().getData(selectedCurrency, cryptoList[0]);
      var newPriceETH = await Data().getData(selectedCurrency, cryptoList[1]);
      var newPriceLTC = await Data().getData(selectedCurrency, cryptoList[2]);
      setState(() {
        btcPrice = newPriceBTC;
        ethPrice = newPriceETH;
        ltcPrice = newPriceLTC;
      });
    } catch (e) {
      print(e);
    }
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
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardLayout(
                    crypto: 'BTC',
                    selectedCurrency: selectedCurrency,
                    price: btcPrice),
                CardLayout(
                    crypto: 'ETH',
                    selectedCurrency: selectedCurrency,
                    price: ethPrice),
                CardLayout(
                    crypto: 'LTC',
                    selectedCurrency: selectedCurrency,
                    price: ltcPrice),
              ]),
          Column(
            children: [
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
        ],
      ),
    );
  }
}
