import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:todo_flutter/application/auth/auth_bloc.dart';
import 'package:todo_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:todo_flutter/presentation/notes/note_overview/notes_overview_page.dart';

class SplashPage extends StatelessWidget {
  static String id = "splash_page";

  @override
  Widget build(BuildContext interprcontext) {
    //BlocListener is useful for thing that cannot be done during build (navigation FE.)
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        //we ignoring initial
        state.map(
            initial: (_) {},
            authenticated: (_) {
                 Navigator.pushReplacementNamed(context, NotesOverviewPage.id);

              },
            unauthenticated: (_) {
              Logger logger = Logger();
              logger.d('UNatuhenticated');
        Navigator.pushReplacementNamed(context, SignInPage.id);

        });
      },
      child:  Scaffold(
        body: Center(
          child:  Container(height: 100.0, width: 100.0, color: Colors.yellow,),
        ),
      ),
    );
  }
}
