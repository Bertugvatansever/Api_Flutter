import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:http/http.dart';

import 'classlar/Jsondosyam.dart';
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
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Jsondosyam> _jsonList = [];
  String _gelenCevap = "asfasfas";

  Future<void> _incrementCounter() async {
    String adres = "https://jsonplaceholder.typicode.com/posts";
    Response cevap = await get(Uri.parse(adres));
    if (cevap.statusCode == 200) {
      dynamic cevapBody = jsonDecode(cevap.body);
      List<dynamic> gelenCevap = List<dynamic>.from(cevapBody);
      _jsonList = gelenCevap.map((item) => Jsondosyam.fromJson(item)).toList();
    } else {
      _gelenCevap = "Bağlantıda sorun oluştu";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _jsonList.length,
        itemBuilder: (context, index) {
          return ListTile(
      title: Text(
      'User ID: ${_jsonList[index].userId.toString() ?? ""}',
                  ),
    subtitle: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ID: ${_jsonList[index].id.toString() ?? ""}',
      ),
      SizedBox(height: 8),
      Text(
        _jsonList[index].title ?? "",
      ),
      SizedBox(height: 8,),
      Text(
        _jsonList[index].body ?? ""
      ),
    ],
  ),
);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}