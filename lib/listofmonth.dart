import 'package:flutter/material.dart';
import 'package:testdate/listofdates.dart';
import 'package:testdate/month_heading.dart';

class AllData extends StatefulWidget {
  const AllData({Key? key,required this.dateTimes,required this.startDate,required this.endDate}) : super(key: key);
  final Function(DateTime,DateTime) dateTimes;
  final DateTime startDate;
  final DateTime endDate;


  @override
  State<AllData> createState() => _AllDataState();
}

class MonthAndYear{
  int month;
  int year;

  MonthAndYear(this.month,this.year);
}

class _AllDataState extends State<AllData> {

  DateTime start= DateTime.now();
  DateTime end = DateTime(DateTime.now().year+1,DateTime.now().month+1);

  DateTime? startDate= DateTime.now();
  DateTime? endDate = DateTime.now().add(Duration(days: 1));


  List<MonthAndYear> months =[];
  List<DateTime> date=[];
  List<String> weekdays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];

  Future<void> countMonth() async{
    if(start.year<end.year){

        months.add(MonthAndYear(start.month,start.year));

        start = DateTime(start.year,start.month+1);
        setState(() {

        });
        countMonth();
        print("start${start.month} end ${end.month}");


    }else{
      if(start.month<end.month){
        months.add(MonthAndYear(start.month,start.year));

        start = DateTime(start.year,start.month+1);
        setState(() {

        });
        countMonth();
        print("start${start.month} end ${end.month}");
      }
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      startDate = widget.startDate;
      endDate =widget.endDate;
      print("${start.millisecondsSinceEpoch} ${end.millisecondsSinceEpoch}");
      await countMonth();
      print("month:$months");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Date"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                height: 20,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width/7,
                    child: Center(child: Text("${weekdays[index]}",style: TextStyle(color: DateTime.now().weekday==index?Colors.blue:Colors.black),)),);
                },itemCount: weekdays.length,),
              )),

            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        print("${months[index]}    ${DateTime(months[index].year,months[index].month)}");
                      return Container(child: Column(
                        children: [
                          Heading(monthAndYear: months[index],),
                          DateList(dateTime: DateTime(months[index].year,months[index].month), startDate: startDate,endDate: endDate, selectedDate: (selectedDate ) {
                            print("selectedDate:$selectedDate");
                            if(endDate!=null){
                              startDate = selectedDate;
                              endDate=null;
                              setState(() {

                              });
                              print("StartDate: $startDate  endDate: $endDate   caldate: $selectedDate");
                            }
                            else{
                              endDate =selectedDate;
                              setState(() {

                              });
                              print("StartDate: $startDate  endDate: $endDate   caldate: $selectedDate");
                            }

                            setState(() {

                            });
                          },)
                        ],
                      ));
                    },itemCount: months.length,),
                  ),
                ),
              ),
            ),

            Visibility(
              visible:  startDate!=null && endDate!=null,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){
                    print("${startDate!.difference(endDate!).inDays.abs()}");
                    if(startDate!.difference(endDate!).inDays.abs()>=30){
                      const snackBar = SnackBar(
                        duration: Duration(milliseconds: 100),
                        content: Text('You have selected more than 30 days'),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      widget.dateTimes(startDate!,endDate!);
                      Navigator.pop(context);
                    }


                  }, child: Text("Done"))),
            ),
          ],
        ),
      ));
  }
}

