import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/application/notes/note_watcher/note_watcher_bloc.dart';

class UncompletedSwitch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UncompletedSwitchState();
}

class _UncompletedSwitchState extends State {
  bool switchState = false;
  Icon iconChoosed = const Icon(
    Icons.check,
    key: Key('outline'),
  );

  Icon checkBoxOutlined = const Icon(
    Icons.check_box_outlined,
    key: Key('outline'),
  );

  Icon checkBoxBlank = const Icon(
    Icons.check_box_outline_blank_outlined,
    key: Key('outline'),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkResponse(
        onTap: () {
          switchState = !switchState;
          context.read<NoteWatcherBloc>().add(switchState
              ? const NoteWatcherEvent.watchUncompletedStarted()
              : const NoteWatcherEvent.watchAllStarted());

          setState(() {
            if (switchState == true) {
              iconChoosed = checkBoxBlank;
            } else {
              iconChoosed = checkBoxOutlined;
            }
          });
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: switchState ? iconChoosed : iconChoosed,
        ),
      ),
    );
  }
}
