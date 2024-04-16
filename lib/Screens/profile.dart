import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_model/student_model.dart';
import '../provider/student_providre.dart';
import 'register.dart';

class Profile extends StatelessWidget {
  final Student student;
  const Profile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  student.image == ''
                      ? const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person_2),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(File(student.image)),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    student.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.age),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.department),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(student.place),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(
                                      student: student, screen: 'update'),
                                ));
                          },
                          child: const Text('edit')),
                      TextButton(
                          onPressed: () {
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
                                      onPressed: () async {
                                        await context
                                            .read<StudentProvider>()
                                            .delete(student)
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: const Text('confirm'))
                                ],
                              ),
                            );
                          },
                          child: const Text('delete'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
