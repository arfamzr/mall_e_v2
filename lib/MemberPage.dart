import 'package:flutter/material.dart';
import './AdminList.dart';
import './CustList.dart';
import './mallList.dart';

class CustPage extends StatefulWidget {
  @override
  _CustPageState createState() => _CustPageState();
}

class _CustPageState extends State<CustPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context)=> new AdminList(),
                    )
                ),
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/min.png'),
                      Text("Admin List", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context)=> new CustList(),
                    )
                ),
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/customer.png'),
                      Text("Customer List", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context)=> new MallList(),
                    )
                ),
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/mall2.png'),
                      Text("Mall List", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){},
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/event.png'),
                      Text("Event List", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){},
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/item.png'),
                      Text("Soon", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(10.0),
              child: InkWell(
                onTap: (){},
                splashColor: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset('assets/images/shop.png'),
                      Text("Soon", style: new TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
