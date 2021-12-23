import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_flutter/injection.dart';
import 'package:todo_flutter/presentation/app_widget.dart';

void main() async{
  configureInjection(Environment.prod);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( AppWidget());
}

