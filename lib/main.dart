import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Pages/loginpage.dart'; //
import 'Pages/registerpage.dart'; //

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const MyHomePage(title: 'InitialPage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title}) : super();

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    String message1 = _response1?.data.toString() ?? 'Failed to load message';

    String message2 =
        _response2?.data.toString() ?? 'Failed to load message123';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            SizedBox(height: 10), //
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
