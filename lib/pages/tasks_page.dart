// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../components/new_task.dart';
import '../components/tasks_list.dart';
import '../core/services/auth/auth_service.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          //   onPressed: () => _openTaskFormModal(context),
          // ),
          DropdownButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  width: 3,
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') {
                AuthService().logout();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TasksList(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: NewTaks(),
          ),
        ],
      ),
    );
  }
}
