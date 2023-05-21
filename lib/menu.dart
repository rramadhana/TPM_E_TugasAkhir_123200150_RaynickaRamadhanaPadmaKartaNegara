import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'country_data.dart';
class Menu extends StatelessWidget {
  const Menu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            color: Colors.red,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "WORLD COUNTRIES",
              style: TextStyle(fontSize: 50.0),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Card(
              child: SizedBox(
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/waktu');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Center(
                        child: Text(
                          "Konversi waktu",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Card(
              child: SizedBox(
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/konversimatauang');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Center(
                        child: Text(
                          "Konversi Mata Uang",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Card(
              child: SizedBox(
                height: 60.0,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/country_data');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        width: 10.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Center(
                        child: Text(
                          "Data Negara",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: SizedBox(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width / 2 - 40.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                    height: 60.0,
                    width: MediaQuery.of(context).size.width / 2 - 40.0,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/saran');
                      },
                      child: Center(
                        child: Icon(
                          Icons.comment,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
