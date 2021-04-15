import 'package:flutter/material.dart';
import 'package:flutter_app_todo/model/todo.dart';
import 'package:flutter_app_todo/provider/todos.dart';
import 'package:flutter_app_todo/widget/todo_form_widget.dart';
import 'package:provider/provider.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add Todo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 8,),
            TodoFormWidget(
              onChangedTitle: (title){
                setState(() {
                  this.title = title;
                });
              },
              onChangedDescription: (description){
                setState(() {
                  this.description = description;
                });
              },
              onSavedTodo: addTodo,
            ),
          ],
        ),
      ),
    );
  }

  void addTodo(){
    final isValid = _formKey.currentState.validate();
    if(!isValid){
      return;
    }else{
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<TodosProvider>(context,listen: false);
      provider.addTodo(todo);
      Navigator.of(context).pop();
    }
  }
}
