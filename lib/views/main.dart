import 'package:flutter/material.dart';
import 'package:master_plan/views/plan_screen.dart';


void main() => runApp(MasterPlanApp());

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      home: PlanScreen(),
    );
  }
}
