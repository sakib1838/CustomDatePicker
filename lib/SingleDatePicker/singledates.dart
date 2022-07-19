import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testdate/AppColors.dart';

class SingleDateList extends StatefulWidget {
  const SingleDateList({Key? key,required this.dateTime,required this.startDate,required this.endDate,required this.selectedDate}) : super(key: key);
  final DateTime dateTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime)? selectedDate;

  @override
  State<SingleDateList> createState() => _SingleDateListState();
}



// this returns the last date of the month using DateTime
int daysInMonth(DateTime date){
  //var temp = DateTime(date.year,date.month,1);
  print("weekday:${date}  ${date.weekday}");
  var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = new DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}


class _SingleDateListState extends State<SingleDateList> {

  DateTime? now;
  List<int> dates=[];
  List<DateTime?> dateTimes=[];

  DateTime todayDate = DateTime.now();
  int? today;
  int? weekday;

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async{
      startDate=widget.startDate;
      endDate=widget.endDate;
      today = int.parse(DateFormat('dd').format(todayDate));
      print("todayDate:${todayDate.millisecondsSinceEpoch}");
      now = widget.dateTime;
      weekday = now!.weekday;
      var totalDays = daysInMonth(now!);
      print("listOFDates:weekDay-> ${weekday}");

      List<DateTime?> listOfDates,listOfDates1;
      listOfDates = new List<DateTime?>.generate(weekday!-1, (index) => null);
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
    startDate = widget.startDate;
    endDate= widget.endDate;
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
          child: InkWell(
            onTap: (){

              widget.selectedDate!(dateTimes[index]!);

              // if(endDate!=null){
              //   startDate = dateTimes[index];
              //   endDate=null;
              //   setState(() {
              //
              //   });
              //   print("StartDate: $startDate  endDate: $endDate   caldate: ${dateTimes[index]}");
              // }
              // else{
              //   endDate =dateTimes[index];
              //   setState(() {
              //
              //   });
              //   print("StartDate: $startDate  endDate: $endDate   caldate: ${dateTimes[index]}");
              // }
            },
            child: Container(
              margin: EdgeInsets.all(2.0),
              color:dateTimes[index]!=null?(todayDate.difference(dateTimes[index]!).inDays>0?null:
              startDate!.getDateOnly()== dateTimes[index]!.getDateOnly()?HexColor(AppColors.primaryColor) :endDate!=null?endDate!.getDateOnly()==dateTimes[index]!.getDateOnly()?HexColor(AppColors.primaryColor):
              (getIntDate(dateTimes[index]!)>getIntDate(startDate!) && getIntDate(dateTimes[index]!)<getIntDate(endDate!))?HexColor(AppColors.deshiTextColorGrey):HexColor(AppColors.deshiTextColorCalDate)
                  :HexColor(AppColors.deshiTextColorCalDate)
              ) :HexColor(AppColors.backgroundColor),
              child: Center(child: Text(dateTimes[index]!=null?"${DateFormat("dd").format(dateTimes[index]!)}":"",style: TextStyle(
               color:dateTimes[index]!=null?(todayDate.difference(dateTimes[index]!).inDays>0?Colors.grey:
              startDate!.getDateOnly()== dateTimes[index]!.getDateOnly()?Colors.white :endDate!=null?endDate!.getDateOnly()==dateTimes[index]!.getDateOnly()?Colors.white:dateTimes[index]!.weekday==6 || dateTimes[index]!.weekday==7?HexColor(AppColors.primaryColor):null:null
              ) :null,
              ),)),
            ),
          ),
        );
      },itemCount: dateTimes.length,),
    );
  }




}

extension MyDateExtension on DateTime {
  DateTime getDateOnly(){
    return DateTime(this.year, this.month, this.day);
  }
}

int getIntDate(DateTime current_date){
  return current_date.year*10000000000 +
      current_date.month * 100000000 +
      current_date.day * 1000000 +
      current_date.hour*10000 +
      current_date.minute*100 +
      current_date.second;
}
