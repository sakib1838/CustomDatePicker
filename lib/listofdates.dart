import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testdate/AppColors.dart';

class DateList extends StatefulWidget {
  const DateList({Key? key,required this.dateTime}) : super(key: key);
  final DateTime dateTime;

  @override
  State<DateList> createState() => _DateListState();
}



// this returns the last date of the month using DateTime
int daysInMonth(DateTime date){
  //var temp = DateTime(date.year,date.month,1);
  print("weekday:${date}  ${date.weekday}");
  var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}


class _DateListState extends State<DateList> {

  DateTime? now;
  List<int> dates=[];

  List<DateTime?> dateTimes=[];

  DateTime todayDate = DateTime.now();
  int? today;
  int? weekday;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      today = int.parse(DateFormat('dd').format(todayDate));
      print("todayDate:${todayDate.millisecondsSinceEpoch}");
      now = widget.dateTime;
      weekday = now!.weekday;
      var totalDays = daysInMonth(now!);

      List<DateTime?> listOfDates,listOfDates1;
      listOfDates = new List<DateTime?>.generate(weekday!, (index) => null);
        listOfDates1 = new List<DateTime>.generate(totalDays, (i) => DateTime(now!.year,now!.month,i + 1));

      // var listOfDates,listOfDates1;
      //  listOfDates = new List<int>.generate(weekday!, (index) => 0);
      //  listOfDates1 = new List<int>.generate(totalDays, (i) => i + 1);
      print(listOfDates);
      dateTimes=listOfDates+listOfDates1;
      //dates=listOfDates+listOfDates1;
      setState(() {

      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 400,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ), itemBuilder: (context,index){
         // print("small or not ${dateTimes[index]!=null?(dateTimes[index]!.difference(todayDate).inDays):""} ${dateTimes[index]!.millisecondsSinceEpoch} ${todayDate.millisecondsSinceEpoch} ${dateTimes[index]} ${todayDate} ");
        return Visibility(
          visible: dateTimes[index]!=null?true:false,
          child: Container(
            margin: EdgeInsets.all(2.0),
            color:dateTimes[index]!=null?(todayDate.difference(dateTimes[index]!).inDays>0?HexColor(AppColors.whiteColor).withOpacity(0.5):HexColor(AppColors.deshiTextColor2)):HexColor(AppColors.backgroundColor),
            child: Center(child: Text(dateTimes[index]!=null?"${DateFormat("dd").format(dateTimes[index]!)}":"")),
          ),
        );
      },itemCount: dateTimes.length,),
    );
  }
}
