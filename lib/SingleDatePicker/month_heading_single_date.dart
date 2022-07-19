import 'package:flutter/material.dart';
import 'package:testdate/SingleDatePicker/listofmonth_singledate.dart';


class MonthHeadingSingleDate extends StatefulWidget {
  const MonthHeadingSingleDate({Key? key,required this.monthAndYear}) : super(key: key);
  final MonthAndYearSingleDate monthAndYear;

  @override
  State<MonthHeadingSingleDate> createState() => _MonthHeadingSingleDateState();
}
String getMonthName(int number){
  String m="";
  if(number==1){
    m= "January";
  }else if(number==2){
    m=  "February";
  }else if(number==3){
    m=  "March";
  }else if(number==4){
    m=  "April";
  }else if(number==5){
    m=  "May";
  }
  else if(number==6){
    m=  "June";
  }else if(number==7){
    m=  "July";
  }else if(number==8){
    m=  "August";
  }else if(number==9){
    m=  "September";
  }else if(number==10){
    m=  "October";
  }else if(number==11){
    m=  "November";
  }else if(number==12){
    m=  "December";
  }
  return m;
}

class _MonthHeadingSingleDateState extends State<MonthHeadingSingleDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.centerRight,
            width: MediaQuery.of(context).size.width*0.5,
            child: Text("${getMonthName(widget.monthAndYear.month)} ${widget.monthAndYear.year}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
        // Container(
        //     width: 40,
        //     child: Text("${widget.monthAndYear.year}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))
      ],
    ),
      // Text("${months[index].month<=9?"0${months[index].month}": "${months[index].month}"}     "  "${months[index].year}")
    );
  }
}
