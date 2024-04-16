import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/provider/image_provider.dart';
import 'package:provider_project/provider/student_providre.dart';

import 'data_model/student_model.dart';
import 'homescreen.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ 
        ChangeNotifierProvider(create:(context) => StudentProvider(),
        
         ),
         ChangeNotifierProvider(create: (context) => ImageProvidr(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
