import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  dynamic state, temp, humidity, time, icon;
  dynamic new_date;
  String apiKey = '5448c53f82d401be76751d0f5f638323';

  var url = Uri.parse(
      'http://api.airvisual.com/v2/nearest_city?key=51338a49-96f8-471d-ace4-d312985e76d5');

  Future<void> readJson() async {
    http.get(url).then((response) async {
      final data = await json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        state = data['data']['state'];
        temp = data['data']['current']['weather']['tp'];
        humidity = data['data']['current']['weather']['hu'];
        time = data['data']['current']['weather']['ts'];
        icon = data['data']['current']['weather']['ic'];
      });
      DateTime date = DateTime.parse(time);
      new_date = DateFormat('yyyy-MM-dd – kk:mm').format(date);
      print(new_date);
      print("State : $state");
      print("Temp : $temp");
      print("Humidity : $humidity");
      print("Time : $time");
      print("Icon : $icon");
    });
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              readJson();
            },
            icon: Icon(
              Icons.refresh,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("State : $state"),
            Text("Temp : $temp"),
            Text("Humidity : $humidity"),
            Text("DateTime : $new_date"),
            icon == '01d'
                ? Image.asset('assets/images/01d.png')
                : icon == '01n'
                    ? Image.asset('assets/images/01n.png')
                    : icon == '02d'
                        ? Image.asset('assets/images/02d.png')
                        : icon == '02n'
                            ? Image.asset('assets/images/02n.png')
                            : icon == '03d'
                                ? Image.asset('assets/images/03d.png')
                                : icon == '04d'
                                    ? Image.asset('assets/images/04d.png')
                                    : icon == '09d'
                                        ? Image.asset('assets/images/09d.png')
                                        : icon == '10d'
                                            ? Image.asset(
                                                'assets/images/10d.png')
                                            : icon == '10n'
                                                ? Image.asset(
                                                    'assets/images/10n.png')
                                                : icon == '11d'
                                                    ? Image.asset(
                                                        'assets/images/11d.png')
                                                    : icon == '13d'
                                                        ? Image.asset(
                                                            'assets/images/13d.png')
                                                        : icon == '50d'
                                                            ? Image.asset(
                                                                'assets/images/50d.png')
                                                            : Text(
                                                                "Icon : $icon"),
            icon == '01d'
                ? Text("Clear Sky (day)")
                : icon == '01n'
                    ? Text("Clear Sky (night)")
                    : icon == '02d'
                        ? Text("Few Clouds (day)")
                        : icon == '02n'
                            ? Text("Few Clouds (night)")
                            : icon == '03d'
                                ? Text("Scattered Clouds")
                                : icon == '04d'
                                    ? Text("Broken Clouds")
                                    : icon == '09d'
                                        ? Text("Shower Rain")
                                        : icon == '10d'
                                            ? Text("Rain (day time)")
                                            : icon == '10n'
                                                ? Text("Rain (night time)")
                                                : icon == '11d'
                                                    ? Text("Thunderstorm")
                                                    : icon == '13d'
                                                        ? Text("Snow")
                                                        : icon == '50d'
                                                            ? Text("Mist")
                                                            : Text(
                                                                "Icon : $icon"),
          ],
        ),
      ),
    );
  }
}
