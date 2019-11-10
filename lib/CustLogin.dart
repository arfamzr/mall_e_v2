import 'dart:convert';
import './auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './CustRegForm.dart';




class CustLogin extends StatefulWidget {
  @override
  _CustLoginState createState() => _CustLoginState();
}

class _CustLoginState extends State<CustLogin> {

  TextEditingController email=new TextEditingController();
  TextEditingController password=new TextEditingController();

  String msg='';

  Future<List> _login() async{
    final response = await http.post("http://172.20.10.3/mall_e/custlogin.php", body: {
      "email": email.text,
      "password": password.text,
    });

    var datauser = json.decode(response.body);

    if(datauser.length==0){
      setState(() {
        msg = "Login Fail";
      });
    }else{
      await Auth.setAuth(datauser[0]);
      Navigator.pushReplacementNamed(context, '/MemberPage');

      setState(() {
        email.text= datauser[0]['email'];
      });
    }
    return datauser;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        height: 880.0,
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: const EdgeInsets.only(top: 20.0)),
            TextField(
              controller: email,
              decoration: InputDecoration(
                  hintText: 'email'
              ),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password'
              ),
            ),
            new Padding(padding: const EdgeInsets.all(8.0),),

            RaisedButton(
              child: Text("Login"),
              onPressed: (){
                _login();
              },
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: ()=>Navigator.of(context).push(
                  new MaterialPageRoute(
                    builder: (BuildContext context)=> new CustRegForm(),
                  )
              ),
              textColor: Colors.deepPurpleAccent,
            ),



            Text(msg,style: TextStyle(fontSize: 20.0, color: Colors.red),)

          ],
        ),
      ),
    );
  }
}
