import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './CustRegForm.dart';
import './MallRegForm.dart';





class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Register Account"),),
      body: Container(
        height: 580.0,
        padding: const EdgeInsets.all(130.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: const EdgeInsets.only(top: 80.0)),
            new Padding(padding: const EdgeInsets.all(15.0),),

            RaisedButton(
              child: Text("New User register"),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new CustRegForm(),
                  )
              ),
            ),

            RaisedButton(
              child: Text("New Mall register"),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new MallRegForm(),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
