import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key key,
    this.title = "",
    this.description = "",
    @required this.onChangedTitle,
    @required this.onChangedDescription,
    @required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildTitle(),
          SizedBox(
            height: 8,
          ),
          buildDescription(),
          SizedBox(
            height: 16,
          ),
          buildSaveButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      initialValue: title,
      onChanged: onChangedTitle,
      maxLines: 1,
      validator: (title) {
        if (title.isEmpty) {
          return "The title can't be Empty!";
        }
        return null;
      },
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Title: ",labelStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      ),
    );
  }

  Widget buildDescription() {
    return TextFormField(
      initialValue: description,
      onChanged: onChangedDescription,
      maxLines: 3,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Description: ",labelStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      ),
    );
  }

  Widget buildSaveButton() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        splashColor: Colors.green,
        color: Colors.black,
        onPressed: onSavedTodo,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            24.0,
          ),
        ),
        child: Text(
          "Save",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
