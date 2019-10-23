import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth.dart';
class MallRegForm extends StatefulWidget {
  @override
  _MallRegFormState createState() => _MallRegFormState();
}

class _MallRegFormState extends State<MallRegForm> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPhone = new TextEditingController();
  TextEditingController controllerAddress = new TextEditingController();
  TextEditingController controllerLongitude = new TextEditingController();
  TextEditingController controllerLatitude = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  void addData() async{
    var url ="http://10.0.2.2/mall_e/malladddata.php";
    Map<String,dynamic> user = await Auth.fetchAuth();
    print(user);
    var response = await http.post(url, body:{
      "mall_name": controllerName.text,
      "mall_email": controllerEmail.text,
      "mall_pho": controllerPhone.text,
      "mall_add": controllerAddress.text,
      "longitude": controllerLongitude.text,
      "latitude": controllerLatitude.text,
      "mall_pass": controllerPass.text,
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
      appBar: new AppBar(title: new Text("Register New Mall"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Mall Name",
                      labelText: "Mall Name"
                  ),
                ),
                new TextField(
                  controller: controllerEmail,
                  decoration: new InputDecoration(
                      hintText: "Email",
                      labelText: "Mall Email"
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
                      labelText: "Mall Address"
                  ),
                ),
                new TextField(
                  controller: controllerLongitude,
                  decoration: new InputDecoration(
                      hintText: "Longitude",
                      labelText: "Mall Longitude"
                  ),
                ),
                new TextField(
                  controller: controllerLatitude,
                  decoration: new InputDecoration(
                      hintText: "Latitude",
                      labelText: "Mall Latitude"
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
                  child: new Text("Register"),
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
