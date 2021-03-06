import 'package:flutter/material.dart';
import 'package:gudang_kopi/page/kategori1.dart';
import 'package:gudang_kopi/page/keluar1.dart';
import 'package:gudang_kopi/page/login_page.dart';
import 'package:gudang_kopi/page/masuk1.dart';
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Gudang Kopi"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: Icon(
                    Icons.logout,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: Carousel(
                        autoplay: true,
                        indicatorBgPadding: 8.0,
                        images: [
                          AssetImage('images/slider/arabica.png'),
                          AssetImage('images/slider/robusta.jpg'),
                          AssetImage('images/slider/excelsa.jpg'),
                          AssetImage('images/slider/liberca.jpg'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //button recomendation
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
                  child: Column(
                    children: [
                      Text("Kategori",
                          style: TextStyle(
                              fontSize: 27, color: Color.fromRGBO(0, 0, 0, 1))),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Kategori1()), //----------------------------------------------------------
                    );
                  },
                ),
              ),
              //button custome
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
                  child: Column(
                    children: [
                      Text("Kopi Masuk",
                          style: TextStyle(
                              fontSize: 27, color: Color.fromRGBO(0, 0, 0, 1))),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Masuk1()), //------------------------------------------------------------
                    );
                  },
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
                  child: Column(
                    children: [
                      Text("Kopi Keluar",
                          style: TextStyle(
                              fontSize: 27, color: Color.fromRGBO(0, 0, 0, 1))),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Keluar1()), //------------------------------------------------------------
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
