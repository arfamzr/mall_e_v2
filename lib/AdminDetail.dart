import 'package:flutter/material.dart';
import './AdminEdit.dart';
import 'package:http/http.dart' as http;
import './AdminPage.dart';

class AdminDetail extends StatefulWidget {
  List list;
  int index;
  AdminDetail({this.index,this.list});
  
  @override
  _AdminDetailState createState() => _AdminDetailState();
}

class _AdminDetailState extends State<AdminDetail> {

  void deleteData(){
    var url="http://10.0.2.2/mall_e/deleteData.php";
    http.post(url, body: {
      'admin_id': widget.list[widget.index]['admin_id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.list[widget.index]['admin_name']}"),
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
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(title: new Text("${widget.list[widget.index]['admin_name']}")),
        body: new Container(
          height: 280.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[

                  new Padding(padding: const EdgeInsets.only(top: 25.0),),
                  new Text(widget.list[widget.index]['admin_name'], style: new TextStyle(fontSize: 20.0),),
                  new Text("ID: ${widget.list[widget.index]['admin_id']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Phone: ${widget.list[widget.index]['admin_pho']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Email: ${widget.list[widget.index]['admin_email']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Address: ${widget.list[widget.index]['admin_add']}", style: new TextStyle(fontSize: 18.0),),
                  new Padding(padding: const EdgeInsets.only(top: 25.0),),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text("EDIT"),
                          color: Colors.greenAccent,
                          onPressed: ()=> Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context)=> new AdminEdit(list: widget.list, index: widget.index),
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
