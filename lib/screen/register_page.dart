import 'package:distribution_coursework/exception/app_exception.dart';
import 'package:distribution_coursework/model/request/save_student_request.dart';
import 'package:distribution_coursework/model/request/save_teacher_request.dart';
import 'package:distribution_coursework/provider/student_provider.dart';
import 'package:distribution_coursework/provider/teacher_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Status { student, teacher }

class _RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  Status _status = Status.student;

  final _nameController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  _RegisterPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.height / 2,
        child: Card(
          elevation: 20,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Студент'),
                          leading: Radio<Status>(
                            value: Status.student,
                            groupValue: _status,
                            onChanged: (Status value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Преподаватель'),
                          leading: Radio<Status>(
                            value: Status.teacher,
                            groupValue: _status,
                            onChanged: (Status value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      return _validEmpty(value);
                    },
                  ),
                  TextFormField(
                    controller: _loginController,
                    validator: (value) {
                      return _validEmpty(value);
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      return _validEmpty(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (_formKey.currentState.validate()) {
                            if (_status.name == Status.student.name) {
                              final request = SaveStudentRequest(
                                  _nameController.text,
                                  _loginController.text,
                                  _passwordController.text);
                              Provider.of<StudentProvider>(
                                  context, listen: false)
                                  .saveStudent(request);
                              Navigator.pushNamed(context, "/student");
                            } else {
                              final request = SaveTeacherRequest(
                                  _nameController.text,
                                  _loginController.text,
                                  _passwordController.text);
                              Provider.of<TeacherProvider>(
                                  context, listen: false)
                                  .saveTeacher(request);
                              Navigator.pushNamed(context, "/teacher");
                            }
                          }
                        } on SaveStudentException catch (exception) {
                          if (kDebugMode) {
                            print(exception);
                          }
                        } on SaveTeacherException catch (exception) {
                          if (kDebugMode) {
                            print(exception);
                          }
                        }
                        //Navigator.pushNamed(context, "/student");
                      },
                      child: const Text("Зарегистрироваться"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validEmpty(String value) {
    if (value.isEmpty) {
      return "Поле не должно быть пустым";
    }
    return null;
  }
}
