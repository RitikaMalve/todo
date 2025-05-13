import 'package:blog_todoapp/screen/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:blog_todoapp/database/hydratdblog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory directory = await getApplicationDocumentsDirectory();
  final hydratedStorageDirectory = await HydratedStorageDirectory(
    directory.path,
  );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: hydratedStorageDirectory,
  );

  runApp(const blog_todoappApp());
}

class blog_todoappApp extends StatelessWidget {
  const blog_todoappApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>  TodoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        home: SplashScreen(),
      ),
    );
  }
}
