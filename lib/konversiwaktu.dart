import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class waktu extends StatefulWidget {
  const waktu({Key? key}) : super(key: key);

  @override
  State<waktu> createState() => _waktuState();
}

class _waktuState extends State<waktu> {
  late DateTime datetime;
  late String hari;
  String _zonaWaktu = 'WIB'; // zona waktu default adalah WIB

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    var jakarta = tz.getLocation('Asia/Jakarta');
    datetime = tz.TZDateTime.now(jakarta);
    hari = _getHari(datetime.weekday);
  }

  String _getHari(int day) {
    switch (day) {
      case DateTime.monday:
        return 'Senin';
      case DateTime.tuesday:
        return 'Selasa';
      case DateTime.wednesday:
        return 'Rabu';
      case DateTime.thursday:
        return 'Kamis';
      case DateTime.friday:
        return 'Jumat';
      case DateTime.saturday:
        return 'Sabtu';
      case DateTime.sunday:
        return 'Minggu';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("konversi zona waktu"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: SizedBox(
                height: 100.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hari,
                        style: const TextStyle(fontSize: 30.0),
                      ),
                      Text(
                        '${datetime.day.toString().padLeft(2, '0')} / ${datetime.month.toString().padLeft(2, '0')} / ${datetime.year.toString()} : ${datetime.hour.toString().padLeft(2, '0')}:${datetime.minute.toString().padLeft(2, '0')}:${datetime.second.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Zona Waktu: '),
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'WIB',
                      groupValue: _zonaWaktu,
                      onChanged: (value) {
                        setState(() {
                          _zonaWaktu = value!;
                          var jakarta = tz.getLocation('Asia/Jakarta');
                          datetime = tz.TZDateTime.now(jakarta);
                          hari = _getHari(datetime.weekday);
                        });
                      },
                    ),
                    Text('WIB'),
                    SizedBox(
                      width: 10,
                    ),
                    Radio<String>(
                      value: 'WIT',
                      groupValue: _zonaWaktu,
                      onChanged: (value) {
                        setState(() {
                          _zonaWaktu = value!;
                          var makassar = tz.getLocation('Asia/Makassar');
                          datetime = tz.TZDateTime.now(makassar);
                          hari = _getHari(datetime.weekday);
                        });
                      },
                    ),
                    Text('WITA'),
                    SizedBox(
                      width: 10,
                    ),
                    Radio<String>(
                      value: 'WITA',
                      groupValue: _zonaWaktu,
                      onChanged: (value) {
                        setState(() {
                          _zonaWaktu = value!;
                          var jayapura = tz.getLocation('Asia/Jayapura');
                          datetime = tz.TZDateTime.now(jayapura);
                          hari = _getHari(datetime.weekday);
                        });
                      },
                    ),
                    Text('WIT'),
                    SizedBox(
                      width: 10,
                    ),
                    Radio<String>(
                      value: 'GMT',
                      groupValue: _zonaWaktu,
                      onChanged: (value) {
                        setState(() {
                          _zonaWaktu = value!;
                          var london = tz.getLocation('Europe/London');
                          datetime = tz.TZDateTime.now(london);
                          hari = _getHari(datetime.weekday);
                        });
                      },
                    ),
                    Text('London'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
