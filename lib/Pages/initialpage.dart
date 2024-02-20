import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'loginpage.dart';
import 'registerpage.dart';

class InitialPage extends StatefulWidget {
  const InitialPage();

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  Response<dynamic>? _response1;
  Response<dynamic>? _response2;

  @override
  void initState() {
    super.initState();
    postHttp();
  }

  void getHttp() async {
    final dio = Dio();
    _response1 = await dio.get('https://trans.rticonsulting.com.au/status');
    setState(() {});
  }

  void postHttp() async {
    final dio = Dio();
    _response2 = await dio.post('https://trans.rticonsulting.com.au/status');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
