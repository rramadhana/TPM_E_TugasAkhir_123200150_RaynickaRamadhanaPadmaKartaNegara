import 'package:flutter/material.dart';

class konversimatauang extends StatefulWidget {
  const konversimatauang({Key? key}) : super(key: key);
  @override
  _konversimatauangState createState() => _konversimatauangState();
}

class _konversimatauangState extends State<konversimatauang> {
  double jumlah = 0;
  double nilaitukar = 0;
  String darimatauang = 'USD';
  String kematauang = 'IDR';
  double hasil = 0;

  Map<String, double> exchangeRates = {
    'USD': 1.0,
    'IDR': 14100.0,
    'EUR': 0.83,
  };

  void convertCurrency() {
    setState(() {
      nilaitukar = exchangeRates[kematauang]! / exchangeRates[darimatauang]!;
      hasil = jumlah * nilaitukar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator konversi mata uang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  jumlah = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Jumlah',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: darimatauang,
              onChanged: (value) {
                setState(() {
                  darimatauang = value!;
                });
              },
              items: exchangeRates.keys.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'dari',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: kematauang,
              onChanged: (value) {
                setState(() {
                  kematauang = value!;
                });
              },
              items: exchangeRates.keys.map((currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Ke',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hasil: $hasil',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: konversimatauang(),
  ));
}
