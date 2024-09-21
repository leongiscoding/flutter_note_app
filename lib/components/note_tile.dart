import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'note_settings.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NoteTile({
    super.key,
    required this.text,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
      ),
      margin: const EdgeInsets.only(top: 10, left: 18, right: 18),
      child: ListTile(
        title: Text(text,maxLines: null,),
        trailing: Builder(
          builder: (context) {
            return IconButton(
                  icon: const Icon(Icons.more_vert),
                onPressed: () => showPopover(
                  height: 100,
                  width: 100,
                  backgroundColor: Theme.of(context).colorScheme.background,
                    context: context,
                    bodyBuilder: (context)=>  NoteSettings(
                      onEditTap: onEditPressed,
                      onDeleteTap: onDeletePressed,
                    ),
                ),
            );
          }
        ),
      ),
    );
  }
}

//note tile to design list of notes