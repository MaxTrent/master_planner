import 'package:flutter/material.dart';
import 'package:master_plan/models/data_layer.dart';
import 'package:master_plan/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan? plan;

  const PlanScreen({Key? key, this.plan}) : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan? get plan => widget.plan;
  late ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Master Planner'),
      )),
      body: Column(children: <Widget>[
        Expanded(child: _buildList()),
        SafeArea(child: Text(plan!.completenessMessage))
      ]),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        final controller = PlanProvider.of(context);
        controller.createNewTask(plan!);
        setState(() {});
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: plan!.tasks.length,
        itemBuilder: (context, index) => _buildTaskTile(
              plan!.tasks[index],
            ));
  }

  Widget _buildTaskTile(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanProvider.of(context);
        controller.deleteTask(plan!, task);
        setState(() {});
      },
      child: ListTile(
        leading: Checkbox(
            value: task.complete,
            onChanged: (selected) {
              setState(() {
                task.complete = selected!;
              });
            }),
        title: TextFormField(
          initialValue: task.description,
          onFieldSubmitted: (text) {
            setState(() {
              task.description = text;
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
