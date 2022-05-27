import 'package:flutter/material.dart';
import 'package:master_plan/controllers/plan_controller.dart';

import 'models/data_layer.dart';


class PlanProvider extends InheritedWidget {
  final _controller = PlanController();

  PlanProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
  static PlanController of(BuildContext context){
    PlanProvider? provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!._controller;

  }
}

