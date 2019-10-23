import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './CustDetail.dart';
import './CustAddData.dart';

class CustList extends StatefulWidget {
  @override
  _CustListState createState() => _CustListState();
}

class _CustListState extends State<CustList> {

  Future<List> getData() async {
    final response= await http.get("http://10.0.2.2/mall_e/custgetdata.php"); //if using real phone device, chg to your computer ip.
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Customer List"),
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new CustAddData(),
              )
          ),
        ),
        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ListCust(list: snapshot.data,)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )

    );
  }
}

class ListCust extends StatelessWidget{

  final List list;
  ListCust({this.list});

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
                    builder: (BuildContext context)=> new CustDetail(list:list , index: i,)
                )
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['cust_name']),
                leading: new Icon(Icons.person),
                subtitle: new Text("ID : ${list[i]['cust_id']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
