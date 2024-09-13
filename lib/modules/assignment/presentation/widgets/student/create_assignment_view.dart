import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/download_file_button.dart';
import 'package:mindmorph/widgets/form_field.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/mindmorph_file_picker.dart';
import 'package:mindmorph/widgets/secondary_button.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../data/repository/assignemnt_student_repository.dart';
import '../../../data/validators/short_text_validator.dart';
import '../../../models/instructor/view_assignment_model.dart';
import '../../../models/student/submit_assignment_model.dart';
import '../instructor/course_thumbnail.dart';

class CreateAssignmentView extends StatefulWidget {
  const CreateAssignmentView({super.key, required this.assignmentId});
  final int assignmentId;

  @override
  State<CreateAssignmentView> createState() => _CreateAssignmentViewState();
}

class _CreateAssignmentViewState extends State<CreateAssignmentView> {
  File? homework;
  final commentController = TextEditingController();
  ViewAssignmentModel? assignment;
  bool isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  void setAttachment(File file) {
    homework = file;
  }

  void fetchAssignment() async {
    final a =
        await AssignmentStudentRepository.getAssignment(widget.assignmentId);
    setState(() {
      assignment = a;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAssignment();
  }

  @override
  Widget build(BuildContext context) {
    return assignment == null || isSubmitting
        ? const MindMorphLoadingIndicator()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 50.heightBox,
              Card(
                color: backgrounghilghtcolor,
                shadowColor: const Color.fromARGB(255, 17, 17, 16),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  // height: 200,
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child:
                              CourseThumbnail(courseId: assignment!.courseId)),
                      const SizedBox(height: 10),
                      // Center(
                      //   child: 'Flutter Basic courses'
                      //       .text
                      //       .size(18)
                      //       .color(titlecolor)
                      //       .fontFamily(bold)
                      //       .make(),
                      // ),
                      20.heightBox,
                      Row(
                        children: [
                          const Icon(
                            Icons.numbers,
                            color: titlecolor,
                          ),
                          'Points Possible: ${assignment!.points}'
                              .text
                              .size(14)
                              .color(Colors.amber)
                              .fontFamily(bold)
                              .make(),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: titlecolor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Due Date: ${assignment!.deadline}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.amber),
                          ),
                        ],
                      ),
                      20.heightBox,
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: assignment!.title.text
                                .size(16)
                                .color(const Color.fromARGB(255, 190, 214, 254))
                                .fontFamily(bold)
                                .make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              5.heightBox,
              Card(
                  color: boxcolor,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: context.width,
                    child: Text(
                      assignment!.instruction,
                      style: const TextStyle(color: titlecolor),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Attachment File',
                      style: TextStyle(color: Colors.white)),
                  MindMorphDownloadFileButton(
                      pdfUrl: 'http://$NODE_SERVER/${assignment!.attachment}'),
                ],
              ),
              const Divider(),
              10.heightBox,
              MindMorphFilePicker(
                labelText: 'Upload Work',
                type: FileType.custom,
                allowedExtensions: const ['pdf'],
                callback: setAttachment,
              ),
              Form(
                key: _formKey,
                child: MindMorphFormField(
                  labelText: 'Comment on your work',
                  controller: commentController,
                  validator: shortTextValidator,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                ),
              ),
              30.heightBox,
              Center(
                  child: MindMorphSecondaryButton(
                      labelText: 'Submit Work',
                      onTap: () async {
                        if (homework == null) {
                          mindMorphSnackBar(
                              context: context,
                              message: 'Work Attachment is Required',
                              isError: true);
                          return;
                        }
                        if (!_formKey.currentState!.validate()) {
                          mindMorphSnackBar(
                              context: context,
                              message: 'Invalid Assignment Data',
                              isError: true);

                          return;
                        }

                        setState(() {
                          isSubmitting = true;
                        });

                        // Proceed to save
                        final data = SubmitAssignmentModel(
                            assignmentId: widget.assignmentId,
                            attachment: homework,
                            comment: commentController.text);

                        //Send to Backend
                        final result =
                            await AssignmentStudentRepository.submitAssignment(
                                data);

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
                            // context.push('/course/add_section/${widget.courseId}');
                            context.go('/assignments/student/list');
                          }
                        } else {
                          setState(() {
                            isSubmitting = false;
                          });
                        }
                      }))
            ],
          );
  }
}
