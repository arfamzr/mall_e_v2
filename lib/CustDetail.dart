import 'package:flutter/material.dart';
import './CustEdit.dart';
import 'package:http/http.dart' as http;
import './AdminPage.dart';

class CustDetail extends StatefulWidget {
  List list;
  int index;
  CustDetail({this.index,this.list});

  @override
  _CustDetailState createState() => _CustDetailState();
}

class _CustDetailState extends State<CustDetail> {

  void deleteData(){
    var url="http://172.20.10.3/mall_e/custdeleteData.php";
    http.post(url, body: {
      'cust_id': widget.list[widget.index]['cust_id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete'${widget.list[widget.index]['name']}"
          "? This action cannot be undo"),
      actions: <Widget>[
        new RaisedButton(
          child: new Text("DELETE", style: new TextStyle(color: Colors.white70),),
          color: Colors.white12,
          onPressed: (){
            deleteData();
            Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (BuildContext context)=> new AdminPage(),
                )
            );
          },
        ),
        new RaisedButton(
          child: new Text("CANCEL", style: new TextStyle(color: Colors.white70),),
          color: Colors.white12,
          onPressed: ()=>Navigator.pop(context),
        )

      ],
    );

    // ignore: deprecated_member_use
    showDialog(context: context, child: alertDialog);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("${widget.list[widget.index]['name']}")),
        body: new Container(
          height: 280.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[

                  new Padding(padding: const EdgeInsets.only(top: 25.0),),
                  new Text(widget.list[widget.index]['name'], style: new TextStyle(fontSize: 20.0),),
                  new Text("ID: ${widget.list[widget.index]['cust_id']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Phone: ${widget.list[widget.index]['phone']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Email: ${widget.list[widget.index]['email']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Address: ${widget.list[widget.index]['address']}", style: new TextStyle(fontSize: 18.0),),
                  new Padding(padding: const EdgeInsets.only(top: 25.0),),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text("EDIT"),
                          color: Colors.greenAccent,
                          onPressed: ()=> Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context)=> new CustEdit(list: widget.list, index: widget.index),
                              )
                          )
                      ),
                      new RaisedButton(
                        child: new Text("DELETE"),
                        color: Colors.redAccent,
                        onPressed: ()=>confirm(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
