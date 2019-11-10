import 'package:flutter/material.dart';
import 'login.dart';
import 'CustLogin.dart';
import 'MallLogin.dart';





class LoginSelect extends StatefulWidget {
  @override
  _LoginSelectState createState() => _LoginSelectState();
}

class _LoginSelectState extends State<LoginSelect> {

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Choose Your Role"),),
      body:  WillPopScope(
        onWillPop: _onBackPressed,
        child:Container(
        height: 580.0,
        padding: const EdgeInsets.all(130.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: const EdgeInsets.only(left: 180.0)),
            new Padding(padding: const EdgeInsets.all(15.0),),

            RaisedButton(
              child: Text("Customer"),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new CustLogin(),
                  )
              ),
            ),

            RaisedButton(
              child: Text("Mall"),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new MallLogin(),
                  )
              ),
            ),

            RaisedButton(
              child: Text("Admin"),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new LoginPage(),
                  )
               ),
             ),
            ],
          ),
       ),
      ),
    );
  }
}
