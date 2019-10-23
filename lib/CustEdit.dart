import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './CustList.dart';

class CustEdit extends StatefulWidget {

  final List list;
  final int index;

  CustEdit({this.list,this.index});

  @override
  _CustEditState createState() => _CustEditState();
}

class _CustEditState extends State<CustEdit> {

  TextEditingController controllerName;
  TextEditingController controllerPhone;
  TextEditingController controllerEmail;
  TextEditingController controllerAddress;

  void editData(){
    var url="http://10.0.2.2/mall_e/custeditdata.php";
    http.post(url,body: {
      "cust_id": widget.list[widget.index]['cust_id'],
      "cust_name": controllerName.text,
      "cust_email": controllerEmail.text,
      "cust_pho": controllerPhone.text,
      "cust_add": controllerAddress.text,

    });
  }

  @override
  void initState(){
    controllerName= new TextEditingController(text: widget.list[widget.index]['cust_id']);
    controllerName= new TextEditingController(text: widget.list[widget.index]['cust_name']);
    controllerPhone= new TextEditingController(text: widget.list[widget.index]['cust_pho']);
    controllerEmail= new TextEditingController(text: widget.list[widget.index]['cust_email']);
    controllerAddress= new TextEditingController(text: widget.list[widget.index]['cust_add']);
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
                            builder: (BuildContext context)=>new CustList()
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
