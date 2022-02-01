import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final plan = Plan();
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text('MasterPlanner'),)),
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          plan.tasks.add(Task());
        });
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: plan.tasks.length,
        itemBuilder: (context, index) => _buildTaskTile(
              plan.tasks[index],
            ));
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
            setState(() {
              task.complete = selected!;
            });
          }),
      title: TextField(
        onChanged: (text) {
          setState(() {
            task.description = text;
          });
        },
      ),
    );


    }


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    addListener(() {
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }
}
