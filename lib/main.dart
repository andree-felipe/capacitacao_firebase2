import 'package:capacitacao_firebase2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capacitacao_firebase2/core/services/notification/task_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/auth_or_app_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeData tema = ThemeData();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskNotificationService(),
        ),
      ],
      child: MaterialApp(
        home: const AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
