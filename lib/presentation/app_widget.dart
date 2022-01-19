import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/application/auth/auth_bloc.dart';
import 'package:todo_flutter/presentation/sign_in/sign_in_page.dart';
import 'package:todo_flutter/presentation/splash/splash_page.dart';

import '../injection.dart';
import 'notes/note_form/note_form_page.dart';
import 'notes/note_overview/notes_overview_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //providing auth block as soon ass possible
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        home: SplashPage(),
       // initialRoute: SplashPage.id,
        routes: {
          SignInPage.id: (context) => SignInPage(),
          SplashPage.id: (context) => SplashPage(),
          NotesOverviewPage.id: (context) =>  NotesOverviewPage(),
          NoteFormPage.id: (context) =>     NoteFormPage(),
        },
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(
    //       create: (context) =>
    //       getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
    //     )
    //   ],
    //   child: MaterialApp(
    //     title: 'Todo',
    //     debugShowCheckedModeBanner: false,
    //     //builder: ExtendedNavigator.builder(router: app_router.Router()),
    //     theme: ThemeData.light().copyWith(
    //       primaryColor: Colors.green[800],
    //       floatingActionButtonTheme: FloatingActionButtonThemeData(
    //         backgroundColor: Colors.blue[900],
    //       ),
    //       inputDecorationTheme: InputDecorationTheme(
    //         border: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
