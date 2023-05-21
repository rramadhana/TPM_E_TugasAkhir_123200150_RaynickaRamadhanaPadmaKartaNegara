import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _storage = FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Generate Key
    final key = encrypt.Key.fromSecureRandom(32);
    final base64Key = base64Url.encode(key.bytes);
    print('Generated Key: $base64Key');

    final iv = encrypt.IV.fromLength(16); // Inisialisasi IV dengan panjang 16 byte
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encryptedPassword = encrypter.encrypt(password, iv: iv);

    if (username == 'admin' && password == 'admin') {
      // Simpan username dan password terenkripsi ke Flutter Secure Storage
      await _storage.write(key: 'username', value: username);
      await _storage.write(key: 'password', value: encryptedPassword.base64);

      Navigator.pushNamed(context, '/menu');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Gagal'),
            content: const Text('Password atau username yang anda masukkan salah'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.public, size: 40.0),
                  SizedBox(width: 10.0),
                  Text(
                    'WORLD COUNTRIES',
                    style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                controller: _usernameController,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: _obscureText ? Colors.grey : Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
