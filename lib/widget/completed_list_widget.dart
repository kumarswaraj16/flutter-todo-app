import 'package:flutter/material.dart';
import 'package:flutter_app_todo/model/todo.dart';
import 'package:flutter_app_todo/provider/todos.dart';
import 'package:flutter_app_todo/widget/todo_widget.dart';
import 'package:provider/provider.dart';

class CompletedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final List<Todo> todos = provider.todosCompleted;
    return (todos.isEmpty) ?
    Center(
      child: Text("Yet, No Completed Task.",style: TextStyle(
        fontSize: 20.0,
      ),),
    )
        :
    ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      itemCount: todos.length,
      itemBuilder: (context,index){
        final todo = todos[index];
        return TodoWidget(
          todo: todo,
        );
      },
      separatorBuilder: (context,index){
        return Container(
          height: 8.0,
        );
      },
    );
  }
}
