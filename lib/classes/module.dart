import 'package:flutter/material.dart';

class Module {
  Module(
      {this.id,
      @required this.name,
      @required this.grade,
      @required this.credits,
      this.done = 0});

  int id = 0;
  final String name;
  final double grade;
  final int credits;
  int done;

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'grade': this.grade,
      'credits': this.credits,
      'done': this.done
    };
  }

  bool isDone() {
    return this.done == 1;
  }

  Module toggleDone(){
    if(this.done == 1){
      return new Module(id: this.id, name:this.name, grade:this.grade, credits: this.credits, done: 0);
    }
    else{
      return new Module(id: this.id, name:this.name, grade:this.grade, credits: this.credits, done: 1);
    }
  }

  @override
  String toString() {
    return 'Module{id: $id, name: $name, grade: $grade, credits: $credits, done: $done}';
  }
}
