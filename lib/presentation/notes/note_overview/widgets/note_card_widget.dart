import 'package:flutter/material.dart';
import 'package:kt_dart/src/collection/kt_iterable.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_flutter/application/notes/note_actor/note_actor_bloc.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/domain/notes/todo_item.dart';
import 'package:todo_flutter/presentation/notes/note_form/note_form_page.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.noteColor.getOrCrash(),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NoteFormPage(editedNote: note,)));
        },
        onLongPress: () {

          final noteActorBloc = context.read<NoteActorBloc>();
          _showDeletionDialog(context, noteActorBloc);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.noteBody.getOrCrash(),
                style: const TextStyle(fontSize: 18),
              ),
              if (note.maxListSize3.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: <Widget>[
                    ...note.maxListSize3.getOrCrash().map(
                          (todo) => TodoDisplay(todo: todo),
                        ).iter
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selected note:'),
          content: Text(
            note.noteBody.getOrCrash(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            MaterialButton(
              onPressed: () {
                noteActorBloc.add(NoteActorEvent.deleted(note));
                Navigator.pop(context);
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;

  const TodoDisplay({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (todo.done)
          const Icon(
            Icons.check_box,
            color: Colors.black,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.todoName.getOrCrash()),
      ],
    );
  }
}
