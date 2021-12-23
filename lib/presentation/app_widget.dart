import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/presentation/sign_in/sign_in_page.dart';

import '../injection.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
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