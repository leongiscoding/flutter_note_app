import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_database.dart';
import 'package:flutter_note_app/pages/note_page.dart';
import 'package:provider/provider.dart';

void main() async{
  // functions for provider to notify after each changes
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
      ChangeNotifierProvider(create: (context)=> NoteDatabase(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        home: NotePage(),
      ),
    );
  }
}

