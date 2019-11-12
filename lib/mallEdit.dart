import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './AdminHome.dart';

class MallEdit extends StatefulWidget {

  final List list;
  final int index;

  MallEdit({this.list,this.index});

  @override
  _MallEditState createState() => _MallEditState();
}

class _MallEditState extends State<MallEdit> {

  TextEditingController controllerName;
  TextEditingController controllerPhone;
  TextEditingController controllerEmail;
  TextEditingController controllerAddress;
  TextEditingController controllerLongitude;
  TextEditingController controllerLatitude;

  void editData(){
    var url="http://172.20.10.3/mall_e/editdata.php";
    http.post(url,body: {
      "mall_id": widget.list[widget.index]['mall_id'],
      "name": controllerName.text,
      "email": controllerEmail.text,
      "phone": controllerPhone.text,
      "address": controllerAddress.text,
      "longitude": controllerLongitude.text,
      "latitude": controllerLatitude.text,

    });
  }

  @override
  void initState(){
    controllerName= new TextEditingController(text: widget.list[widget.index]['mall_id']);
    controllerName= new TextEditingController(text: widget.list[widget.index]['name']);
    controllerPhone= new TextEditingController(text: widget.list[widget.index]['phone']);
    controllerEmail= new TextEditingController(text: widget.list[widget.index]['email']);
    controllerAddress= new TextEditingController(text: widget.list[widget.index]['address']);
    controllerLongitude= new TextEditingController(text: widget.list[widget.index]['longitude']);
    controllerLatitude= new TextEditingController(text: widget.list[widget.index]['latitude']);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Edit Mall Info"),),
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
                      labelText: "Name"
                  ),
                ),
                new TextField(
                  controller: controllerPhone,
                  decoration: new InputDecoration(
                      hintText: "Mall Phone No",
                      labelText: "Phone"
                  ),
                ),
                new TextField(
                  controller: controllerEmail,
                  decoration: new InputDecoration(
                      hintText: "Mall Email",
                      labelText: "Email"
                  ),
                ),
                new TextField(
                  controller: controllerAddress,
                  decoration: new InputDecoration(
                      hintText: "Mall Address",
                      labelText: "Address"
                  ),
                ),
                new TextField(
                  controller: controllerLongitude,
                  decoration: new InputDecoration(
                      hintText: "Longitude",
                      labelText: "Longitude"
                  ),
                ),
                new TextField(
                  controller: controllerLatitude,
                  decoration: new InputDecoration(
                      hintText: "Latitude",
                      labelText: "Latitude"
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
                            builder: (BuildContext context)=>new AdminHome()
                        )
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
