import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_notes/blocs/blocs.dart';
import 'package:bloc_notes/repositories/repositories.dart';
import 'package:bloc_notes/screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            authRepository: AuthRepository(),
          )..add(AppStarted()),
        ),
        BlocProvider<NotesBloc>(
          create: (_) => NotesBloc(
            authRepository: AuthRepository(),
            notesRepository: NotesRepository(),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Bloc Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}