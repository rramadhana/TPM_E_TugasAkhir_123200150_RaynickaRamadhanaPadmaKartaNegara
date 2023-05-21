import 'package:flutter/material.dart';
import 'package:projecttpmuas/country_data.dart';
import 'package:projecttpmuas/konversimatauang.dart';
import 'package:projecttpmuas/saran.dart';
import 'login.dart';
import 'konversiwaktu.dart';
import 'menu.dart';
import 'profile.dart';
import 'country_detail_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/menu': (context) => const Menu(),
      '/login': (context) => const Login(),
      '/country_data': (context) => const SearchPage(),
      '/profile': (context) => const profile(),
      '/waktu': (context) => const waktu(),
      '/konversimatauang': (context) => const konversimatauang(),
      '/saran': (context) => const saran(),
      '/country_detail': (context) => const DetailPage(),

    },
    home: const Login(),
  ));
}
