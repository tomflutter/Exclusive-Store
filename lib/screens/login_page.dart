import 'package:flutter/material.dart';
import '../api_service.dart';
import 'product_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();

  void doLogin() async {
    final token = await ApiService.login(user.text, pass.text);

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProductPage()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: user,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: doLogin,
              child: Text("Login"),
            ),
            Text('username: "mor_2314"'),
            Text('password: "83r5^_"'),
          ],
        ),
      ),
    );
  }
}