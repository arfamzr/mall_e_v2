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
  List data=[];
  @override
  void initState(){
    fetchData();
    super.initState();
  }
  void fetchData() async{
    final response = await http.get('http://172.20.10.3/mall_e/eventlistmall.php');
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
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
                new DropdownButton<String>(
                  isDense: true,
                  hint: new Text("Mall Name"),
                  value: _mySelection,
                  onChanged: (String newValue){
                    setState(() {
                      _mySelection = newValue;
                    });
                    print(_mySelection);
                  },
                  items: data.map((item){
                    return new DropdownMenuItem<String>(
                      value: item["id"].toString(),
                      child: new Text(
                        item["name"].toString(),
                      ),
                    );
                  }).toList(),
                ),

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