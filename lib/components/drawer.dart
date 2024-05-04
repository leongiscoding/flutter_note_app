import 'package:flutter/material.dart';
import 'package:flutter_note_app/components/drawer_tile.dart';

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
              Navigator.pushNamed(context, "/settingsPage");
            },
          ),

        ],
      ),
    );
  }
}
