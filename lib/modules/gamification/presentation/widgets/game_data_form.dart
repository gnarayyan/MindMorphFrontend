import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/snackbar.dart';

import '../../../assignment/data/validators/long_text_validator.dart';
import '../../../upload_course/bloc/course_init/course_initialize_bloc.dart';
import '../../../upload_course/presentation/widgets/initialize_course/course_options.dart';
import '../../data/repository/gamification_repository.dart';
import '../../models/create_game_data.dart';
import '/widgets/button.dart';
import '/widgets/form_field.dart';
import '../../../../widgets/mindmorph_file_picker.dart';

class GameDataForm extends StatefulWidget {
  const GameDataForm({
    super.key,
  });

  @override
  State<GameDataForm> createState() => _GameDataFormState();
}

class _GameDataFormState extends State<GameDataForm> {
  final _textController = TextEditingController();
  File? image;
  String? courseCategoryId;
  String? courseDomainId;

  final _formKey = GlobalKey<FormState>();
  bool isSubmitting = false;

  void uploadImage(File file) {
    image = file;
  }

  void setCourseData({required String domainId, required String categoryId}) {
    courseDomainId = domainId;
    courseCategoryId = categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return isSubmitting
        ? const MindMorphLoadingIndicator()
        : SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocProvider(
                      create: (_) => ListFetchBloc()..add(FetchList1()),
                      child: CourseOptions(updateCourseData: setCourseData)),
                  MindMorphFormField(
                      controller: _textController,
                      labelText: 'Data',
                      validator: longTextValidator,
                      keyboardType: TextInputType.multiline,
                      minLines: 2),
                  MindMorphFilePicker(
                    labelText: 'Image',
                    type: FileType.image,
                    callback: uploadImage,
                    isFileOptional: true,
                  ),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    labelText: 'Save',
                    onTap: () async {
                      // if (image == null) {
                      //   print('No image picked');
                      // } else {
                      //   print('Image at: ${image!.path}');
                      // }
                      // Donot proceed if form is invalid
                      if (courseCategoryId == null) {
                        mindMorphSnackBar(
                            context: context,
                            message: 'Course Category is Required',
                            isError: true);
                        return;
                      }
                      if (!_formKey.currentState!.validate()) {
                        mindMorphSnackBar(
                            context: context,
                            message: 'Invalid Gamification Data',
                            isError: true);

                        return;
                      }

                      setState(() {
                        isSubmitting = true;
                      });

                      // Proceed to save
                      final data = CreateGameModel(
                          courseCategoryId: int.parse(courseCategoryId!),
                          text: _textController.text,
                          image: image);

                      //Send to Backend
                      final result =
                          await GamificationRepository.createGameData(data);

                      // Show Result in Snackbar
                      if (context.mounted) {
                        mindMorphSnackBar(
                            context: context,
                            message: result.message,
                            isError: !result.isSuccess);
                      }

                      // Goto next Page
                      if (result.isSuccess) {
                        if (context.mounted) {
                          context.go('/');
                        }
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
