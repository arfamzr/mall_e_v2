import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth.dart';
class CustAddData extends StatefulWidget {
  @override
  _CustAddDataState createState() => _CustAddDataState();
}

class _CustAddDataState extends State<CustAddData> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  void addData() async{
    var url ="http:// 172.20.10.3/mall_e/custadddata.php";
    Map<String,dynamic> user = await Auth.fetchAuth();
    print(user);
    var response = await http.post(url, body:{
      "name": controllerName.text,
      "email": controllerEmail.text,
      "phone": controllerPhone.text,
      "addres": controllerAddress.text,
      "password": controllerPass.text,
      'admin_id':user['admin_id']
    });

    if(response.statusCode ==200){
      print("Sucess");
    } else {
      print(jsonDecode(response.body));
    }


  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Add New Customer"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Name",
                      labelText: "Name"
                  ),
                ),
                new TextField(
                  controller: controllerEmail,
                  decoration: new InputDecoration(
                      hintText: "Email",
                      labelText: "Email"
                  ),
                ),
                new TextField(
                  controller: controllerPhone,
                  decoration: new InputDecoration(
                      hintText: "Phone No",
                      labelText: "Phone"
                  ),
                ),
                new TextField(
                  controller: controllerAddress,
                  decoration: new InputDecoration(
                      hintText: "Address",
                      labelText: "Address"
                  ),
                ),
                new TextField(
                  controller: controllerPass,
                  obscureText: true,
                  decoration: new InputDecoration(
                      hintText: "Password",
                      labelText: "Password"
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(15.0),),

                new RaisedButton(
                  child: new Text("Add Cusomer"),
                  color: Colors.deepPurpleAccent,
                  onPressed: (){
                    addData();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
