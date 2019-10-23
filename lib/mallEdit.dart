import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './mallList.dart';

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

  void editData(){
    var url="http://10.0.2.2/mall_e/editdata.php";
    http.post(url,body: {
      "mall_id": widget.list[widget.index]['mall_id'],
      "mall_name": controllerName.text,
      "mall_email": controllerEmail.text,
      "mall_pho": controllerPhone.text,
      "mall_add": controllerAddress.text,

    });
  }

  @override
  void initState(){
    controllerName= new TextEditingController(text: widget.list[widget.index]['mall_id']);
    controllerName= new TextEditingController(text: widget.list[widget.index]['mall_name']);
    controllerPhone= new TextEditingController(text: widget.list[widget.index]['mall_pho']);
    controllerEmail= new TextEditingController(text: widget.list[widget.index]['mall_email']);
    controllerAddress= new TextEditingController(text: widget.list[widget.index]['mall_add']);
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
                new Padding(padding: const EdgeInsets.all(15.0),),

                new RaisedButton(
                  child: new Text("Confirm"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new MallList()
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
