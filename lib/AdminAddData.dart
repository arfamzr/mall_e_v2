import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminAddData extends StatefulWidget {
  @override
  _AdminAddDataState createState() => _AdminAddDataState();
}

class _AdminAddDataState extends State<AdminAddData> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  void addData(){
    var url ="http:// 172.20.10.3/mall_e/adddata.php";

    http.post(url, body:{
      "name": controllerName.text,
      "email": controllerEmail.text,
      "phone": controllerPhone.text,
      "address": controllerAddress.text,
      "password": controllerPass.text
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Add New Admin"),),
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
                  child: new Text("Add Admin"),
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
