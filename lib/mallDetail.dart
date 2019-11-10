import 'package:flutter/material.dart';
import './mallEdit.dart';
import 'package:http/http.dart' as http;
import './AdminPage.dart';

class MallDetail extends StatefulWidget {
  List list;
  int index;
  MallDetail({this.index,this.list});

  @override
  _MallDetailState createState() => _MallDetailState();
}

class _MallDetailState extends State<MallDetail> {

  void deleteData(){
    var url="http://172.20.10.3/mall_e/malldeleteData.php";
    http.post(url, body: {
      'mall_id': widget.list[widget.index]['mall_id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.list[widget.index]['name']}"),
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
        appBar: new AppBar(title: new Text("${widget.list[widget.index]['name']}")),
        body: new Container(
          height: 340.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[

                  new Padding(padding: const EdgeInsets.only(top: 25.0),),
                  new Text(widget.list[widget.index]['name'], style: new TextStyle(fontSize: 20.0),),
                  new Padding(padding: const EdgeInsets.only(top: 25.0),),
                  new Text("ID : ${widget.list[widget.index]['mall_id']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("No.Phone  : ${widget.list[widget.index]['phone']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Email  : ${widget.list[widget.index]['email']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Address  : ${widget.list[widget.index]['address']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Longitude  : ${widget.list[widget.index]['longitude']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Latitude : ${widget.list[widget.index]['latitude']}", style: new TextStyle(fontSize: 18.0),),
                  new Padding(padding: const EdgeInsets.only(top: 25.0),),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                          child: new Text("EDIT"),
                          color: Colors.greenAccent,
                          onPressed: ()=> Navigator.of(context).push(
                              new MaterialPageRoute(
                                builder: (BuildContext context)=> new MallEdit(list: widget.list, index: widget.index),
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
