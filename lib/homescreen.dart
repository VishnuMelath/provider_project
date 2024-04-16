import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/Screens/profile.dart';
import 'package:provider_project/Screens/register.dart';
import 'package:provider_project/data_model/student_model.dart';
import 'package:provider_project/provider/student_providre.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentProvider>().getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Register(
                    student: Student(
                        name: '',
                        age: '',
                        department: '',
                        image: '',
                        place: ''),
                    screen: 'register'),
              ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              onChanged: (value) {
                context.read<StudentProvider>().search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              ),
            ),
          ),
          Expanded(
              child: context.watch<StudentProvider>().isloading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : context.watch<StudentProvider>().students.isEmpty
                      ? const Center(
                          child: Text('No students found'),
                        )
                      : ListView.builder(
                          itemCount:
                              context.watch<StudentProvider>().students.length,
                          itemBuilder: (context, index) {
                            Student student = context
                                .watch<StudentProvider>()
                                .students[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(31, 7, 255, 172),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                onTap: () {

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(student: student),));
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Register(
                                                    student: student,
                                                    screen: 'update'),
                                              ));
                                        },
                                        child: const Icon(Icons.edit)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Confirm'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('cancel')),
                                                     TextButton(
                                                    onPressed: () async{
                                                      await context
                                              .read<StudentProvider>()
                                              .delete(student).then((value) =>Navigator.pop(context) );
                                                      
                                                    },
                                                    child: const Text('confirm'))
                                              ],
                                            ),
                                          );
                                          
                                        },
                                        child: const Icon(Icons.delete))
                                  ],
                                ),
                                title: Text(student.name),
                                leading: student.image == ''
                                    ? const CircleAvatar(
                                        child: Icon(Icons.person_2),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(student.image)),
                                      ),
                              ),
                            );
                          },
                        ))
        ],
      ),
    );
  }
}
