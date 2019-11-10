import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './AdminDetail.dart';
import './AdminAddData.dart';


class AdminList extends StatefulWidget {
  @override
  _AdminListState createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  Future<List> getData() async {
    final response= await http.get("http://172.20.10.3/mall_e/getdata.php"); //if using real phone device, chg to your computer ip.
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Admin List"),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new AdminAddData(),
              )
          ),
        ),
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ListAdmin(list: snapshot.data,)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )
      
    );
  }
}

class ListAdmin extends StatelessWidget{

  final List list;
  ListAdmin({this.list});

  @override
  Widget build(BuildContext context){
    return new ListView.builder(
      itemCount: list==null ? 0 : list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(4.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context)=> new AdminDetail(list:list , index: i,)
                )
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['name']),
                leading: new Icon(Icons.person),
                subtitle: new Text("ID : ${list[i]['admin_id']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}