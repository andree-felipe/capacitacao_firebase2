import 'package:flutter/material.dart';
import '../core/models/app_user.dart';
import '../core/services/auth/auth_service.dart';
import 'auth_page.dart';
import 'loading_page.dart';
import 'tasks_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: StreamBuilder<AppUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            // ignore: prefer_const_constructors
            return LoadingPage();
          }
          else {
            // ignore: prefer_const_constructors
            return snapshot.hasData ? TasksPage() : AuthPage();
          }
        }
      ),
    );
  }
}