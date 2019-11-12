import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './AdminHome.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EventEdit extends StatefulWidget {

  final List list;
  final int index;

  EventEdit({this.list,this.index});

  @override
  _EventEditState createState() => _EventEditState();
}

class _EventEditState extends State<EventEdit> {

  TextEditingController controllerName;
  TextEditingController controllerDate;
  TextEditingController controllerTime;

  void editData(){
    var url="http://172.20.10.3/mall_e/custeditdata.php";
    http.post(url,body: {
      "event_id": widget.list[widget.index]['event_id'],
      "name": controllerName.text,
      "time": controllerDate.text,
      "date": controllerTime.text,

    });
  }

  @override
  void initState(){
    controllerName= new TextEditingController(text: widget.list[widget.index]['name']);
    controllerDate= new TextEditingController(text: widget.list[widget.index]['time']);
    controllerTime= new TextEditingController(text: widget.list[widget.index]['date']);
    super.initState();
  }

  final format = DateFormat("yyyy-MM-dd");
  final dateFormat = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Edit Event Info"),),
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
                new Padding(padding: const EdgeInsets.all(15.0),),

                new RaisedButton(
                  child: new Text("Confirm"),
                  color: Colors.greenAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context)=>new AdminHome()
                        )
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
