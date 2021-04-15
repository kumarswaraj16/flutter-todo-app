import 'package:flutter/material.dart';
import 'package:flutter_app_todo/model/todo.dart';
import 'package:flutter_app_todo/page/edit_todo_page.dart';
import 'package:flutter_app_todo/provider/todos.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({
    @required this.todo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        key: Key(todo.id),
        actions: <Widget>[
          IconSlideAction(
            color: Colors.green,
            icon: Icons.edit,
            caption: "Edit",
            onTap: () => editTodo(context, todo),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Colors.red,
            icon: Icons.delete,
            caption: "Delete",
            onTap: () => deleteTodo(context, todo),
          )
        ],
        child: buildTodo(context),
      ),
    );
  }

  Widget buildTodo(BuildContext context) {
    return GestureDetector(
      onTap: (){
        editTodo(context, todo);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: <Widget>[
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);
                Utils.showSnackBar(context,
                    isDone ? "Task Completed" : "Task Marked Incomplete");
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Text(
                        todo.description,
                        style: TextStyle(
                          fontSize: 24.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);
    Utils.showSnackBar(context, 'Deleted the task!');
  }

  void editTodo(BuildContext context, Todo todo) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditTodoPage(todo: todo)));
  }
}
