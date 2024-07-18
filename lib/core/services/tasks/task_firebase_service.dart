// ignore_for_file: annotate_overrides, prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/task.dart';
import 'task_service.dart';

class TaskFirebaseService implements TaskService {
  Stream<List<Task>> tasksStream() {
    return Stream<List<Task>>.empty();
  }

  // removeTask(String id) {
  //   _tasks.removeWhere((task) => task.id == id);
  //   _controller?.add(_tasks);
  // }

  Future<Task?> save(String title, DateTime deliveryDate) async {
    final store = FirebaseFirestore.instance;

    final task = Task(
      id: Random().nextDouble().toString(),
      title: title,
      deliveryDate: deliveryDate,
    );

    final docRef = await store
        .collection('tasks')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(task);

    final doc = await docRef.get();
    return doc.data();
  }

  // Task => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    Task task,
    SetOptions? options,
  ) {
    return {
      'id': task.id,
      'title': task.title,
      'deliveryDate': task.deliveryDate.toIso8601String(),
    };
  }

  // Map<String, dynamic> => Task
  Task _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return Task(
      id: doc.id,
      title: doc['title'],
      deliveryDate: DateTime.parse(doc['deliveryDate']),
    );
  }
}
