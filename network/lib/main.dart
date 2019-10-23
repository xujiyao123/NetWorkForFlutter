import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'NetWorkManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _responseText;

  @override
  void initState() {
    loadRequest();
    super.initState();
  }

  void loadRequest() {
//    NET.request(url: "url" ,
//        method: RequestMethod.get,
//        contentType: ContentType.json,
//        responseType: ResponseType.json,
//        success: (res){
//          print(res.data);
//          setState(() {
//            _responseText = res.data.toString();
//          });
//        } , error: (e) {
//          setState(() {
//            _responseText = e.message.toString();
//          });
//        });

    NET.request(url:"https://www.jianshu.com/shakespeare/notes/52159179/reward_section" ).then((res) {
      setState(() {
        _responseText = res.data.toString();
      });
    } , onError: (e) {
      setState(() {
        _responseText = e.message.toString();
      });
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Text(_responseText),

      ),
    );
  }
}
