import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.menuTrip),
      ),
      body: Center(
        child: Text(R.strings.menuTrip),
      ),
    );
  }
}
