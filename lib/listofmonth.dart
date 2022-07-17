import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testdate/AppColors.dart';
import 'package:testdate/listofdates.dart';
import 'package:testdate/month_heading.dart';

class AllData extends StatefulWidget {
  const AllData({Key? key,required this.dateTimes,required this.startDate,required this.endDate}) : super(key: key);
  final Function(DateTime,DateTime)? dateTimes;
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
  List<String> weekdays = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];

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
      startDate=widget.startDate;
      endDate=widget.endDate;
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
        color: HexColor(AppColors.whiteColor),
        child: Column(
          children: [
            Container(
                height: 20,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ///have to work here
                    print("weekDay:${DateTime.now().weekday}  ${weekdays[index]}${index+1}");
                  return Container(
                    width: MediaQuery.of(context).size.width/7,
                    child: Center(child: Text("${weekdays[index]}",style: TextStyle(color: DateTime.now().weekday==index+1?Colors.blue:Colors.black),)),);
                },itemCount: weekdays.length,),
              )),

            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        print("${months[index]}    ${DateTime(months[index].year,months[index].month)}");
                      return Container(child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Heading(monthAndYear: months[index],),
                          SizedBox(height: 10,),
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
                          },),

                          index==months.length-1? SizedBox(height: MediaQuery.of(context).size.height*0.3,):SizedBox()
                        ],

                      ));
                    },itemCount: months.length,),
                  ),
                ),
              ),
            ),

           // SizedBox(height: MediaQuery.of(context).size.height*0.1,),

            Visibility(
              visible:  endDate==null?false:startDate!=null && endDate!=null,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  color: HexColor(AppColors.backgroundColor),
                ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                              child: Text("${DateFormat('dd MMM').format(startDate!)} - ${endDate!=null?DateFormat('dd MMM').format(endDate!):""}",style: TextStyle(fontWeight: FontWeight.bold),)),
                          Text(endDate!=null?"(${startDate!.difference(endDate!).inDays.abs()} nights)":""),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 8),
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
                            widget.dateTimes!(startDate!,endDate!);
                            Navigator.pop(context);
                          }


                        }, child: Text("Select Dates")),
                      ),
                      SizedBox(height: 10,),
                    ],
                  )),
            ),
          ],
        ),
      ));
  }
}

