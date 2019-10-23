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
    var url="http://10.0.2.2/mall_e/malldeleteData.php";
    http.post(url, body: {
      'mall_id': widget.list[widget.index]['mall_id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Are you sure want to delete '${widget.list[widget.index]['mall_name']}"),
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
        appBar: new AppBar(title: new Text("${widget.list[widget.index]['mall_name']}")),
        body: new Container(
          height: 280.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[

                  new Padding(padding: const EdgeInsets.only(top: 25.0),),
                  new Text(widget.list[widget.index]['mall_name'], style: new TextStyle(fontSize: 20.0),),
                  new Text("Mall ID: ${widget.list[widget.index]['mall_id']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Mall Phone: ${widget.list[widget.index]['mall_pho']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Mall Email: ${widget.list[widget.index]['mall_email']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Mall Address: ${widget.list[widget.index]['mall_add']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Mall Longitude: ${widget.list[widget.index]['longitude']}", style: new TextStyle(fontSize: 18.0),),
                  new Text("Mall Latitude: ${widget.list[widget.index]['latitude']}", style: new TextStyle(fontSize: 18.0),),
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
