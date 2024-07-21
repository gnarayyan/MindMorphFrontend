import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';
import 'package:mindmorph/modules/auth/models/signup.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import '../repositories/signup.dart';
import '/constants/color.dart';
import '/constants/fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../login/data/validators/signup_validator.dart' as validator;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  SignupFormModel user = SignupFormModel();
  bool _isSubmitting = false;
  // File? file;
  // String? fileName;

  Future<void> _getImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        // fileName = result.files.first.path;
        user.avatar = File(result.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _isSubmitting
            ? const MindMorphLoadingIndicator()
            : Container(
                color: themecolor,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          50.heightBox,
                          Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 180,
                                width: 180,
                                child:
                                    Lottie.asset('assets/images/signup.json'),
                              )),
                          const Divider(
                            thickness: 2,
                            color: titlecolor,
                            endIndent: 60,
                            indent: 60,
                          ),
                          30.heightBox,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: 'Sign up'
                                .text
                                .color(titlecolor)
                                .size(30)
                                .fontWeight(FontWeight.bold)
                                .fontFamily(bold)
                                .make(),
                          ),
                          10.heightBox,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: 'Please fill the inputs below'
                                .text
                                .size(14)
                                .color(subtexColor)
                                .fontFamily(regular)
                                .make(),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  // style: TextStyle(color: Colors.green),
                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Full Name'),
                                  controller: user.fullName,
                                  validator: validator.fullNameValidator,
                                  // controller: userForm.fullName,
                                ),
                                TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email address',
                                    ),
                                    controller: user.email,
                                    validator: validator.emailValidator),
                                TextFormField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Password',
                                    ),
                                    controller: user.password,
                                    validator: validator.passwordValidator),
                                // DropdownButtonFormField(
                                //   value: 'Student',
                                //   onChanged: (value) {
                                //     setState(() {
                                //       user.role.text = value.toString();
                                //     });
                                //   },
                                //   items: ['Student', 'Instructor']
                                //       .map<DropdownMenuItem<String>>((String value) {
                                //     return DropdownMenuItem<String>(
                                //       value: value,
                                //       child: Text(
                                //         value,
                                //         style: const TextStyle(color: Colors.blue),
                                //       ),
                                //     );
                                //   }).toList(),
                                //   decoration: const InputDecoration(
                                //       labelText: 'Are you Student or Instructor?'),
                                // ),
                                const SizedBox(height: 15),
                                TextButton(
                                  onPressed: () async {
                                    await _getImage();
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.avatar == null
                                            ? 'Profile Picture'
                                            : 'Change Profile Picture',
                                        style: const TextStyle(
                                          color: titlecolor,
                                        ),
                                      ),
                                      user.avatar == null
                                          ? const Text(
                                              'Profile Picture is Required',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 247, 13, 28),
                                                  fontSize: 10),
                                            )
                                          : Center(
                                              child: Image.file(
                                                user.avatar!,
                                                height: 150,
                                              ),
                                            )
                                    ],
                                  ),
                                ),

                                TextFormField(
                                  controller: user.birthdate,
                                  decoration: const InputDecoration(
                                      labelText: 'Birthdate'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your birthdate';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );

                                    if (selectedDate != null) {
                                      user.birthdate.text = selectedDate
                                          .toIso8601String()
                                          .split('T')[0];
                                    }
                                  },
                                ),
                                20.heightBox,
                                Center(
                                  child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 24, 35, 115)),
                                        padding: WidgetStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                        ),
                                        shape: WidgetStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        minimumSize:
                                            WidgetStateProperty.all<Size>(
                                          const Size(200.0,
                                              40.0), // Adjust the width and height as needed
                                        ),
                                      ),
                                      onPressed: () async {
                                        // Donot proceed if form is invalid
                                        if (!_formKey.currentState!
                                                .validate() ||
                                            user.avatar == null) {
                                          if (context.mounted) {
                                            mindMorphSnackBar(
                                                context: context,
                                                message: 'Invalid Form',
                                                isError: true);
                                          }
                                          return;
                                        }

                                        setState(() {
                                          _isSubmitting = true;
                                        });

                                        SignupResponse response =
                                            await signup(user.data);

                                        if (response.status == 201 &&
                                            context.mounted) {
                                          mindMorphSnackBar(
                                              context: context,
                                              message: response.message);
                                          context.go('/login');
                                          return;
                                        } else if (response.status == 500) {
                                          if (context.mounted) {
                                            mindMorphSnackBar(
                                                context: context,
                                                message: 'Image size is Large ',
                                                isError: true);
                                          }
                                        } else {
                                          if (context.mounted) {
                                            mindMorphSnackBar(
                                                context: context,
                                                message: response.message,
                                                isError: true);
                                          }
                                        }
                                        setState(() {
                                          _isSubmitting = false;
                                        });
                                      },
                                      child: 'Sign Up'
                                          .text
                                          .color(titlecolor)
                                          .fontFamily(regular)
                                          .size(18)
                                          .make()),
                                ),
                                30.heightBox,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: 'Already have an account?'
                                          .text
                                          .color(titlecolor)
                                          .fontFamily(semibold)
                                          .make(),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Get.to(() => Login());
                                        context.go('/login');
                                      },
                                      child: 'Sign In '
                                          .text
                                          .color(redColor)
                                          .fontFamily(semibold)
                                          .make(),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
