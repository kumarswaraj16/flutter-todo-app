import 'package:flutter/material.dart';
import 'package:flutter_app_todo/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String id;
  String title;
  String description;
  bool isDone;

  Todo({
      @required this.createdTime,
      @required this.title,
      this.description = "",
      this.id,
      this.isDone = false,
  });

  static Todo fromJson(Map<String, dynamic> json){
    return Todo(
      createdTime: Utils.toDateTime(json['createdTime']),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdTime' : Utils.fromDateTimeToJson(createdTime),
      'title' : title,
      'description' : description,
      'id' : id,
      'isDone' : isDone,
    };
  }

}