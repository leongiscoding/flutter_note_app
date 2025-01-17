import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      padding: const EdgeInsets.all(10.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 60), // Add finite constraints
        child: Stack(
          children: [
            // Text content aligned to the top-left
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                text,
                maxLines: null,
                style: GoogleFonts.dmSerifText(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            // More_vert icon aligned to the top-right
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => showPopover(
                  direction: PopoverDirection.bottom,
                  height: 100,
                  width: 100,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  context: context,
                  bodyBuilder: (context) => NoteSettings(
                    onEditTap: onEditPressed,
                    onDeleteTap: onDeletePressed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
