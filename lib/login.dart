import 'dart:convert';
import './auth.dart';
import './register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController admin_email=new TextEditingController();
  TextEditingController admin_pass=new TextEditingController();

  String msg='';

  Future<List> _login() async{
    final response = await http.post("http://10.0.2.2/mall_e/login.php", body: {
      "admin_email": admin_email.text,
      "admin_pass": admin_pass.text,
    });
    
    var datauser = json.decode(response.body);

    if(datauser.length==0){
      setState(() {
        msg = "Login Fail";
      });
      }else{
      await Auth.setAuth(datauser[0]);
        if(datauser[0]['user_id']=='1'){
          Navigator.pushReplacementNamed(context, '/AdminPage');
      }else if(datauser[0]['user_id']=='2'){
          Navigator.pushReplacementNamed(context, '/MemberPage');
      }else if(datauser[0]['user_id']=='3'){
          Navigator.pushReplacementNamed(context, '/MemberPage');
        }

        setState(() {
          admin_email.text= datauser[0]['admin_email'];
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
              controller: admin_email,
              decoration: InputDecoration(
                hintText: 'email'
              ),
            ),
            TextField(
              controller: admin_pass,
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
                    builder: (BuildContext context)=> new register(),
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
