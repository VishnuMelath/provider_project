import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_project/provider/image_provider.dart';
import 'package:provider_project/provider/student_providre.dart';

import '../data_model/student_model.dart';
import '../widgets/custom_textfield.dart';

class Register extends StatelessWidget {
  final String screen;
  final Student student;
  const Register({super.key, required this.student,required this.screen});

  @override
  Widget build(BuildContext context) {
 
    TextEditingController namecontroller =
        TextEditingController(text: student.name);
    TextEditingController agecontroller =
        TextEditingController(text: student.age);
    TextEditingController departmentcontroller =
        TextEditingController(text: student.department);
    TextEditingController placecontroller =
        TextEditingController(text: student.place);
    GlobalKey<FormState> formkey = GlobalKey();
    context.watch<ImageProvidr>().change(student.image);
   
    return Scaffold(
      appBar: AppBar(
        title: Text(screen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:context.watch<ImageProvidr>().image == ''
                    ? GestureDetector(
                        onTap: () async {
                          context.read<ImageProvidr>().change( await pickImage1());
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 192, 192, 192),
                          radius: 60,
                          child: Icon(
                            Icons.person_add_alt,
                            size: 60,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          context.read<ImageProvidr>().change( await pickImage1());
                          
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(context.watch<ImageProvidr>().image),
                          ),
                        ),
                      )
              ),
              CustomTextField(
                hintText: 'name',
                controller: namecontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'age',
                controller: agecontroller,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'place',
                controller: placecontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: 'department.',
                controller: departmentcontroller,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                         
                            if(screen=='register')
                            {
                              var image=context.read<ImageProvidr>().getimage();
                               context.read<StudentProvider>().insert(Student(
                                name: namecontroller.text.toLowerCase(),
                                age: agecontroller.text,
                                department: departmentcontroller.text,
                                image: image,
                                place: placecontroller.text)).then((value) {Navigator.pop(context);});
                                
                            }
                            else{
                               int key=student.key;
                            var student1=Student(
                                name: namecontroller.text.toLowerCase(),
                                age: agecontroller.text,
                                department: departmentcontroller.text,
                                image:  context.read<ImageProvidr>().getimage(),
                                place: placecontroller.text);
                            await context.read<StudentProvider>().updateStudent(student1,key).then((value) => Navigator.pop(context));
                            }
                         
                        }
                      },
                      child: const Text('submit')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> pickImage1() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image != null ? image.path : '';
}
