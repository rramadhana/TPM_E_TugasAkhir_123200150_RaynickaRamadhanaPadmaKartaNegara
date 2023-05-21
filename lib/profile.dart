import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class profile extends StatelessWidget {
  const profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Center(
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('images/ray.jpeg'),
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              "Nama : Raynicka Ramadhana Padma Karta Negara\n"
                  "NIM : 123200150\n"
                  "Kelas : Teknologi dan Pemrograman Mobile IF-E\n"
                  "Tempat,Tanggal Lahir : Klaten, 9 Desember 2001\n"
                  "Harapan dan Cita-cita : Lulus dengan predikat cumlaude dan bekerja di BUMN",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
