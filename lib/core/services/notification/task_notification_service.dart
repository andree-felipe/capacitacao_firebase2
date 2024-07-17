import 'package:flutter/material.dart';

import '../../models/task_notification.dart';

class TaskNotificationService with ChangeNotifier {
  final List<TaskNotification> _items = [];

  List<TaskNotification> get items {
    // Notação para retornar um clone
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(TaskNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }
}