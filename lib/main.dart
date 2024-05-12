import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/note_database.dart';
import 'package:flutter_note_app/pages/note_page.dart';
import 'package:flutter_note_app/pages/settings_page.dart';
import 'package:flutter_note_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  // functions for provider to notify after each changes
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    // since we have two state to manage which are theme and NoteDatabase, hence we use MultiProvider to get them
      MultiProvider(
        providers: [
          //Note Provider
          ChangeNotifierProvider(create: (context)=> NoteDatabase()),

          //Theme Provider
          ChangeNotifierProvider<ThemeProvider>(create: (context)=> ThemeProvider()),

        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        // A flexible theme mode when we toggle
        theme: Provider.of<ThemeProvider>(context).themeData,
       debugShowCheckedModeBanner: false,
        home: const NotePage(),

        // add routes for navigation, simple to use
        routes: {
          "/notePage" : (context)=> const NotePage(),
          "/settingsPage" :(context)=> const SettingsPage(),
        },
      ),
    );
  }
}

