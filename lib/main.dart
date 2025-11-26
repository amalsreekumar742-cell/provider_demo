import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/features/to_do/presentation/provider/todo_provider.dart';
import 'package:to_do/features/to_do/presentation/view/todoadd.dart';
import 'package:to_do/features/to_do/presentation/view/todohome.dart';
import 'package:to_do/features/to_do/repo/repo_todo.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/todo1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final repo=RepoTodo();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create:(context) => TodoProvider(repo),)
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: ProductHome(),debugShowCheckedModeBanner: false,
    );
  }
}

