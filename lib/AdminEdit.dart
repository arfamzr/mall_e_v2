import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './AdminList.dart';

class AdminEdit extends StatefulWidget {

  final List list;
  final int index;

  AdminEdit({this.list,this.index});

  @override
  _AdminEditState createState() => _AdminEditState();
}

class _AdminEditState extends State<AdminEdit> {

  TextEditingController controllerName;
  TextEditingController controllerPhone;
  TextEditingController controllerEmail;
  TextEditingController controllerAddress;

  void editData(){
    var url="http:// 172.20.10.3/mall_e/editdata.php";
    http.post(url,body: {
      "admin_id": widget.list[widget.index]['admin_id'],
      "name": controllerName.text,
      "email": controllerEmail.text,
      "phone": controllerPhone.text,
      "address": controllerAddress.text,

    });
  }

  @override
  void initState(){
    controllerName= new TextEditingController(text: widget.list[widget.index]['name']);
    controllerPhone= new TextEditingController(text: widget.list[widget.index]['phone']);
    controllerEmail= new TextEditingController(text: widget.list[widget.index]['email']);
    controllerAddress= new TextEditingController(text: widget.list[widget.index]['address']);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Edit Admin Info"),),
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
                  controller: controllerPhone,
                  decoration: new InputDecoration(
                      hintText: "Phone No",
                      labelText: "Phone"
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
                  controller: controllerAddress,
                  decoration: new InputDecoration(
                      hintText: "Address",
                      labelText: "Address"
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(15.0),),

                new RaisedButton(
                  child: new Text("Confirm"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new AdminList()
                        )
                    );
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
