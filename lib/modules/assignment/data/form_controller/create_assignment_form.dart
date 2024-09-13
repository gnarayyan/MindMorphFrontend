// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../models/instructor/create_assignment_submission.dart';
import '../../models/instructor/view_assignment_model.dart';

class CreateAssignmentFormController {
  final title = TextEditingController();
  final instruction = TextEditingController();
  final points = TextEditingController();
  String? deadline;
  String? courseId;
  File? attachment;
  bool isAttachmentOptional = false;
  int? id;

  void setAttachment(File file) {
    attachment = file;
  }

  void setCourseId(String? id) {
    courseId = id;
  }

  void setDeadline(String dateTime) {
    deadline = dateTime;
  }

  void init(ViewAssignmentModel assignment) {
    id = assignment.id;
    courseId = assignment.courseId.toString();
    title.text = assignment.title;
    instruction.text = assignment.instruction;
    points.text = assignment.points.toString();
    deadline = assignment.deadline.toUtc().toIso8601String();
    isAttachmentOptional = true;
  }

  CreateAssignmentSubmission cleanData() {
    return CreateAssignmentSubmission(
        courseId: int.parse(courseId!),
        deadline: deadline!,
        file: attachment,
        instruction: instruction.text.trim(),
        points: double.parse(points.text.trim()),
        title: title.text.trim(),
        id: id);
  }

  Validation validate() {
    if (deadline == null) {
      return Validation(isValid: false, message: 'Deadline is required');
    }
    if (isAttachmentOptional == false && attachment == null) {
      return Validation(
          isValid: false, message: 'Questions attachment is required');
    }
    return Validation(isValid: true, message: '');
  }

  void content() {
    print('''
title: ${title.text}, 
instruction: ${instruction.text}, 
points: ${points.text}, 
deadline: $deadline, 
courseId: $courseId, 
attachment: $attachment, 




''');
  }
}

class Validation {
  bool isValid;
  String message;
  Validation({
    required this.isValid,
    required this.message,
  });
}
