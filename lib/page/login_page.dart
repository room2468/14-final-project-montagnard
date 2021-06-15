import 'package:flutter/material.dart';
import 'package:gudang_kopi/page/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String user = 'admin';
  String password = 'admin';

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _formBuilder(),
                ],
            ),
              ),
      ),
    );
  }

  Widget _formBuilder(){
    return Form(
      key: formKey,
      // autovalidate: true,
          child: Column(
        children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: userController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    validator: (value){
                      return value.isEmpty ? "User Tidak Boleh Kosong" : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 10)
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                      labelText: 'User',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    validator: (value){
                      return value.isEmpty ? "Password Tidak Boleh Kosong" : null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5),),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    if (formKey.currentState.validate() && (userController.text.toString() == user && passwordController.text.toString() == password)) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (Route<dynamic> route)=>false);
                    }
                  },
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: Text('Login', style: TextStyle(
                        fontSize: 24,
                        color: Colors.black
                      ),),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}