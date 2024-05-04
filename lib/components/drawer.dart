import 'package:flutter/material.dart';
import 'package:flutter_note_app/components/drawer_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
              child: Icon(Icons.edit,size: 48,),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0,bottom: 10.0),
            child: Text(
              "Easy Life, Easy Go...",
              style: GoogleFonts.dmSerifText(color: Theme.of(context).colorScheme.inversePrimary,fontSize: 20,)
            ),
          ),

          //notes tile
          DrawerTile(
              title: "Notes",
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context),
          ),

          //settings tile
          DrawerTile(
            title: "Settings",
            leading: const Icon(Icons.settings),
            onTap: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/settingsPage");
            },
          ),

        ],
      ),
    );
  }
}
