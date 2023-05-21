import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as pathUtils;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Negara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchPage(),
      routes: {
        CountryDetailPage.routeName: (context) => CountryDetailPage(),
      },
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Country> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  late Database? _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    if (directory == null) {
      print('Failed to get application documents directory');
      return;
    }

    final dbPath = pathUtils.join(directory.path, 'countries.db');
    print('Database path: $dbPath');

    try {
      _database = await openDatabase(dbPath, version: 1,
          onCreate: (Database db, int version) async {
            await db.execute(
              'CREATE TABLE IF NOT EXISTS countries ('
                  'name TEXT, '
                  'flag TEXT, '
                  'population INTEGER, '
                  'capital TEXT, '
                  'region TEXT, '
                  'subregion TEXT, '
                  'area REAL'
                  ')',
            );
          });
    } catch (e) {
      print('Failed to open database: $e');
    }
  }
  @override
  void dispose() {
    _searchController.dispose();
    _database?.close();
    super.dispose();
  }

  Future<void> searchCountries(String keyword) async {
    final String apiUrl = 'https://restcountries.com/v3.1/name/$keyword';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _searchResults = (jsonData as List)
            .map((countryJson) => Country.fromJson(countryJson))
            .toList();
      });

      await saveSearchResultsToDatabase(_searchResults);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  Future<void> saveSearchResultsToDatabase(List<Country> countries) async {
    for (final country in countries) {
      await _database?.insert(
        'countries',
        country.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  void navigateToCountryDetail(Country country) {
    Navigator.pushNamed(
      context,
      CountryDetailPage.routeName,
      arguments: country,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negara'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    searchCountries(_searchController.text);
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final country = _searchResults[index];
                return ListTile(
                  leading: Image.network(country.flag),
                  title: Text(country.name),
                  onTap: () {
                    navigateToCountryDetail(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Country {
  final String name;
  final String flag;
  final int population;
  final String capital;
  final String region;
  final String subregion;
  final double area;

  Country({
    required this.name,
    required this.flag,
    required this.population,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.area,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name']['official'];
    final flag = json['flags']['png'];
    final population = json['population'];
    final capital = json['capital'].cast<String>().first;
    final region = json['region'];
    final subregion = json['subregion'];
    final area = json['area'];

    return Country(
      name: name,
      flag: flag,
      population: population,
      capital: capital,
      region: region,
      subregion: subregion,
      area: area.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'flag': flag,
      'population': population,
      'capital': capital,
      'region': region,
      'subregion': subregion,
      'area': area,
    };
  }
}

class CountryDetailPage extends StatelessWidget {
  static const routeName = '/country_detail';

  @override
  Widget build(BuildContext context) {
    final country = ModalRoute.of(context)?.settings.arguments as Country;

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flag),
            const SizedBox(height: 16.0),
            Text('Population: ${country.population}'),
            Text('Capital: ${country.capital}'),
            Text('Region: ${country.region}'),
            Text('Subregion: ${country.subregion}'),
            Text('Area: ${country.area}'),
          ],
        ),
      ),
    );
  }
}
