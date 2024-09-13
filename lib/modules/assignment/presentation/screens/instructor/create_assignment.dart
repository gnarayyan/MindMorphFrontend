import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/widgets/app_bar.dart';
import 'package:mindmorph/widgets/dropdown.dart';
import 'package:mindmorph/widgets/form_field.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/mindmorph_file_picker.dart';
import 'package:mindmorph/widgets/secondary_button.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../data/form_controller/create_assignment_form.dart';
import '../../../data/repository/assignemnt_instructor_repository.dart';
import '../../../data/validators/validators.dart' as validator;
import '../../../../../widgets/date_time_picker.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({super.key});

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final _controller = CreateAssignmentFormController();
  Map<String, String>? courseItems;
  void initCourseData() async {
    final courses = await AssignmentInstructorRepository.getInstructorCourses();
    setState(() {
      courseItems = courses;
    });
  }

  bool isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initCourseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MindMorphAppBar(title: 'Create Assignment'),
        body: isSubmitting
            ? const MindMorphLoadingIndicator()
            : SingleChildScrollView(
                child: Container(
                  width: context.screenWidth,
                  height: context.screenHeight,
                  color: themecolor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      20.heightBox,
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            color: boxtilecolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                courseItems == null
                                    ? const MindMorphLoadingIndicator()
                                    : MindMorphDropdown(
                                        hint: 'Choose Course',
                                        items: courseItems!,
                                        onChanged: _controller.setCourseId,
                                        selectedItem: _controller.courseId,
                                        contentMaxLength: 35),
                                5.heightBox,
                                MindMorphFormField(
                                  controller: _controller.title,
                                  maxLines: 3,
                                  labelText: 'Title',
                                  validator: validator.shortTextValidator,
                                ),
                                5.heightBox,
                                MindMorphFormField(
                                  controller: _controller.instruction,
                                  maxLines: 3,
                                  labelText: 'Instruction',
                                  validator: validator.longTextValidator,
                                ),
                                5.heightBox,
                                MindMorphFormField(
                                  controller: _controller.points,
                                  maxLines: 1,
                                  minLines: 1,
                                  keyboardType: TextInputType.number,
                                  labelText: 'Points',
                                  validator: validator.numberValidator,
                                ),
                                10.heightBox,
                                DateTimePicker(
                                    callback: _controller.setDeadline),
                                10.heightBox,
                                MindMorphFilePicker(
                                  labelText: 'Attachemnt File',
                                  type: FileType.custom,
                                  allowedExtensions: const ['pdf'],
                                  callback: _controller.setAttachment,
                                ),
                                35.heightBox,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MindMorphSecondaryButton(
                                      labelText: 'Submit',
                                      onTap: () async {
                                        _controller.content();
                                        final validationResult =
                                            _controller.validate();
                                        if (!validationResult.isValid) {
                                          mindMorphSnackBar(
                                              context: context,
                                              message: validationResult.message,
                                              isError: true);
                                          return;
                                        }
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          mindMorphSnackBar(
                                              context: context,
                                              message:
                                                  'Invalid Assignment Data',
                                              isError: true);

                                          return;
                                        }

                                        setState(() {
                                          isSubmitting = true;
                                        });

                                        // Proceed to save
                                        final data = _controller.cleanData();

                                        //Send to Backend
                                        final result =
                                            await AssignmentInstructorRepository
                                                .createAssignment(data);

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
                                            context.go(
                                                '/assignments/instructor/list');
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
