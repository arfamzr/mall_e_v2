import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'auth.dart';
class EventAddData extends StatefulWidget {
  @override
  _EventAddDataState createState() => _EventAddDataState();
}

class _EventAddDataState extends State<EventAddData> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerDate = new TextEditingController();
  TextEditingController controllerTime = new TextEditingController();

  void addData() async{
    var url ="http://172.20.10.3/mall_e/eventadddata.php";
    Map<String,dynamic> user = await Auth.fetchAuth();
    print(user);
    var response = await http.post(url, body:{
      "name": controllerName.text,
      "date": controllerDate.text,
      "time": controllerTime.text,
      "shop_id": _myValue,
      "mall_id": _mySelection,
      'admin_id':user['admin_id']
    });

    if(response.statusCode ==200){
      print("Sucess");
    } else {
      print(jsonDecode(response.body));
    }
  }

  final format = DateFormat("yyyy-MM-dd");
  final dateFormat = DateFormat("HH:mm");

  String _mySelection;
  String _myValue;
  @override
  void initState(){
    super.initState();
  }
    fetchData() async{
    List data = [];
    final response = await http.get('http://172.20.10.3/mall_e/eventlistmall.php');
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      data = data.map((item){
        print(item);
        return new DropdownMenuItem<String>(
          value: item["mall_id"].toString(),
          child: new Text(
            item["name"].toString(),
          ),
        );
      }).toList();
    }
    print(data);
    return data;
  }
  shopData() async{
    List data = [];
    final response = await http.get('http://172.20.10.3/mall_e/eventlistshop.php');
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      data = data.map((item){
        print(item);
        return new DropdownMenuItem<String>(
          value: item["shop_id"].toString(),
          child: new Text(
            item["name"].toString(),
          ),
        );
      }).toList();
    }
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Add New Event"),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[

                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Name",
                      labelText: "Name"
                  ),
                ),
                Text('Basic date field (${format.pattern})'),
                DateTimeField(controller: controllerDate,
                  format: format,
                  onShowPicker: (context, currentValue)async{
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  }
                ),
                Text('Basic time field (${dateFormat.pattern})'),
                DateTimeField(
                  controller: controllerTime,
                  format: dateFormat,
                  onShowPicker: (context, currentValue)async{
                    final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now())
                    );
                    return DateTimeField.convert(time);
                  },
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0),),
                new FutureBuilder(
                  future: shopData(),
                  builder: (context,snapshot){
                    if(snapshot.hasError){
                      return Text("error");
                    } else {
                      return DropdownButton<String>(
                          isDense: true,
                          hint: new Text("Shop Name"),
                          value: _myValue,
                          onChanged: (String newValue){
                            print(newValue);
                            setState(() {
                              _myValue = newValue;
                            });
                            print(_myValue);
                          },
                          items: snapshot.data
                      );
                    }
                  },
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0),),
                new FutureBuilder(
                    future: fetchData(),
                    builder: (context,snapshot){
                      if(snapshot.hasError){
                        return Text("error");
                      } else {
                        return DropdownButton<String>(
                          isDense: true,
                          hint: new Text("Mall Name"),
                          value: _mySelection,
                          onChanged: (String newValue){
                            print(newValue);
                            setState(() {
                              _mySelection = newValue;
                            });
                            print(_mySelection);
                          },
                          items: snapshot.data
                        );
                      }
                    },
                ),
                new Padding(padding: const EdgeInsets.only(top: 28.0),),
                new RaisedButton(
                  child: new Text("Add Event"),
                  color: Colors.deepPurpleAccent,
                  onPressed: (){
                    addData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}