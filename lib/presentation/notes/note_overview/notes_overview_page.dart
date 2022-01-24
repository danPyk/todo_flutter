import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/application/auth/auth_bloc.dart';
import 'package:todo_flutter/application/notes/note_actor/note_actor_bloc.dart';
import 'package:todo_flutter/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:todo_flutter/domain/notes/note.dart';
import 'package:todo_flutter/injection.dart';
import 'package:todo_flutter/presentation/notes/note_form/note_form_page.dart';
import 'package:todo_flutter/presentation/notes/note_overview/widgets/notes_overview_body_widget.dart';
import 'package:todo_flutter/presentation/notes/note_overview/widgets/uncompleted_switch.dart';
import 'package:todo_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:todo_flutter/presentation/widgets/global_snackbar.dart';

class NotesOverviewPage extends StatelessWidget {
  static String id = "notes_overview";
  final Note? note;

  const NotesOverviewPage({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              ///maybeMap allows ignore authenticated, we are only care about unauthenticated
              state.maybeMap(
                unauthenticated: (_) =>
                    Navigator.pushNamed(context, SignInPage.id),
                orElse: () {},
              );
            },
          ),

          ///used to show snacbar
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                deleteFailure: (state) {
                  GlobalSnackBar.show(
                    context,
                    state.noteFailure.map(
                      unexpected: (_) =>
                          'Unexpected error occured while deleting, please contact support.',
                      insufficientPermission: (_) =>
                          'Insufficient permissions ❌',
                      unableToUpdate: (_) => 'Impossible error',
                    ),
                  );
                },
                orElse: () {},
              );
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Provider.of<AuthBloc>(context, listen: false)
                    .add(const AuthEvent.signedOut());
              },
            ),
            actions: <Widget>[
              UncompletedSwitch(),
            ],
          ),
          body: NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, NoteFormPage.id);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
