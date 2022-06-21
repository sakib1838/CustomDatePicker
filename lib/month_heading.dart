import 'package:flutter/material.dart';
import 'package:testdate/listofmonth.dart';

class Heading extends StatefulWidget {
  const Heading({Key? key,required this.monthAndYear}) : super(key: key);
  final MonthAndYear monthAndYear;

  @override
  State<Heading> createState() => _HeadingState();
}
String getMonthName(int number){
  String m="";
  if(number==1){
    m= "Jan";
  }else if(number==2){
    m=  "Feb";
  }else if(number==3){
    m=  "Mar";
  }else if(number==4){
    m=  "Apr";
  }else if(number==5){
    m=  "May";
  }
  else if(number==6){
    m=  "Jun";
  }else if(number==7){
    m=  "Jul";
  }else if(number==8){
    m=  "Aug";
  }else if(number==9){
    m=  "Sep";
  }else if(number==10){
    m=  "Oct";
  }else if(number==11){
    m=  "Nov";
  }else if(number==12){
    m=  "Dec";
  }
  return m;
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Row(

      children: [
        Container(
            width: 30,
            child: Text("${getMonthName(widget.monthAndYear.month)}" )),
        Container(
            width: 40,
            child: Text("${widget.monthAndYear.year}"))
      ],
    ),
      // Text("${months[index].month<=9?"0${months[index].month}": "${months[index].month}"}     "  "${months[index].year}")
    );
  }
}
