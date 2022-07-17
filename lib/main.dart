import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testdate/listofmonth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

extension MyDateExtension on DateTime {
  DateTime getDateOnly(){
    return DateTime(this.year, this.month, this.day);
  }
}

class _MyAppState extends State<MyApp> {



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:MyHome()//AllData() //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  DateTime startDate = DateTime.now().getDateOnly();
  DateTime endDate = DateTime.now().add(Duration(days: 1)).getDateOnly();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Date"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllData(dateTimes: (startDate , endDate ) {
                  this.startDate=startDate;
                  this.endDate=endDate;
                  setState(() {

                  });
                }, startDate: startDate,endDate: endDate,)));
              }, child: Text("Select Date")),

              Text("${DateFormat('dd-MM-yyyy').format(startDate)} - ${DateFormat('dd-MM-yyyy').format(endDate)}")
            ],
          ),
        ),
      ),
    );
  }
}

