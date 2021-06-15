//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:gudang_kopi/page/home_page.dart';
import 'package:gudang_kopi/page/login_page.dart';

//package letak folder Anda
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gudang Kopi',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
