import 'package:flutter/material.dart';





class IconsRow extends StatefulWidget {
  @override
  _IconsRowState createState() => _IconsRowState();
}

class _IconsRowState extends State<IconsRow> {
   DateTime selectedDate = DateTime.now();
   double width, height;
   _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(1970),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
}

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     buildLock(),
     buildClockAdd()
      ],
    );
  }

  Widget buildLock(){
    return IconButton(
      onPressed: (){},
      icon: Icon(Icons.lock)
    );
  }

  Widget buildClockAdd(){
    return IconButton(
      
       onPressed: () => _selectDate(context),
     
      icon: Icon(Icons.calendar_today)
    );
  }
}