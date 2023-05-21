import 'package:flutter/material.dart';
import 'package:projecttpmuas/country_data.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const routeName = '/country_detail';

  @override
  Widget build(BuildContext context) {
    final Country country = ModalRoute.of(context)!.settings.arguments as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text('Country Detail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.network(
                country.flag,
                height: 200,
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text(
                  '${country.name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Ibu Kota Negara: ${country.capital}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.people),
                title: Text(
                  'Populasi: ${country.population}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.public),
                title: Text(
                  'Region: ${country.region}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.subtitles),
                title: Text(
                  'Subregion: ${country.subregion}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.area_chart),
                title: Text(
                  'Area: ${country.area.toString()} KM',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
