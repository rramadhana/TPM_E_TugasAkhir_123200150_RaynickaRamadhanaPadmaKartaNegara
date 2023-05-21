import 'package:flutter/material.dart';

class saran extends StatelessWidget {
  const saran({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saran dan kesan'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Saran'),
            subtitle: Text('Saran dari saya, bapak bagus dapat menambah deadline terhadap tugas yang diberikan'),
          ),
          ListTile(
            title: Text('Kesan'),
            subtitle: Text('Kuliah TPM dalam 1 semester ini sangat menantang'),
          ),
        ],
      ),
    );
  }
}
