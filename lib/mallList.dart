import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'mallAddData.dart';
import 'mallDetail.dart';

class MallList extends StatefulWidget {
  @override
  _MallListState createState() => _MallListState();
}

class _MallListState extends State<MallList> {
  Future<List> getData() async {
    final response = await http.get("http://10.0.2.2/mall_e/mallgetdata.php");
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    return [];
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Mall List"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (BuildContext context)=>new mallAddData(),
          )
        ),
      ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
             ? new ListMall(list: snapshot.data,)
                : new Center(child: new CircularProgressIndicator(),);
            },
      )
    );
  }

}

class ListMall extends StatelessWidget{
  final List list;
  ListMall({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(4.0),
          child: new GestureDetector(
            onTap: () =>
                Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new MallDetail(list: list, index: i,)
                    )
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['mall_name']),
                leading: new Icon(Icons.local_mall),
                subtitle: new Text("ID : ${list[i]['mall_id']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}