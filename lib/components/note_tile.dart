import 'package:flutter/material.dart';

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
        title: Text(text),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit_rounded,color: Colors.green,),
            ),
            IconButton(
                onPressed: onDeletePressed,
                icon: const Icon(Icons.delete,color: Colors.red,),
            ),
          ],
        ),
      ),
    );
  }
}

//note tile to design list of notes