import 'package:flutter/material.dart';
import 'package:flutter_app_todo/api/firebase_api.dart';
import 'package:flutter_app_todo/main.dart';
import 'package:flutter_app_todo/model/todo.dart';
import 'package:flutter_app_todo/provider/todos.dart';
import 'package:flutter_app_todo/widget/add_todo_dialog.dart';
import 'package:flutter_app_todo/widget/completed_list_widget.dart';
import 'package:flutter_app_todo/widget/todo_list_widget.dart';
import 'package:flutter_app_todo/widget/todo_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            title: Text("Todos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            title: Text("Completed"),
          ),
        ],
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if(snapshot.hasError){
                return buildText('Something went wrong try later!');
              }else{
                final todos = snapshot.data;
                final provider = Provider.of<TodosProvider>(context);
                provider.setTodos(todos);
                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        onPressed: () {
          showDialog(context: context,
            barrierDismissible: false,
            child: AddTodoDialogWidget(),);
        },
      ),
    );
  }

  Widget buildText(String s) {
    return Text(s);
  }
}
