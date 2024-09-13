// lib/screens/initialize_course_form/submit_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import '../../../../auth/login/data/local_storage/user_storage.dart';
import '../../../bloc/course_init/course_initialize_bloc.dart';
import '../../../models/course_init/submit_model.dart';
import 'package:velocity_x/velocity_x.dart';
import '/constants/constants.dart';

class SubmitButton extends StatelessWidget {
  final String? courseDomainId;
  final String? courseCategoryId;
  final String? languageChoice;
  final TextEditingController priceController;

  const SubmitButton({
    super.key,
    required this.courseDomainId,
    required this.courseCategoryId,
    required this.languageChoice,
    required this.priceController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(
            'Data: courseDomainId:$courseDomainId  courseCategoryId:$courseCategoryId');
        if (courseDomainId != null &&
            courseCategoryId != null &&
            languageChoice != null &&
            priceController.text.trim() != '') {
          final dataToSubmit = CourseInitializeSubmitModel(
            courseCategoryId: int.parse(courseCategoryId!),
            authorId: await UserStorage.userId, // TODO: Use current authorId
            language: languageChoice!,
            price: double.parse(priceController.text.trim()),
          );
          if (context.mounted) {
            context.read<ListFetchBloc>().add(
                  SubmitSelections(dataToSubmit: dataToSubmit),
                );
          }
        } else {
          mindMorphSnackBar(
              context: context,
              message: 'All fields are required',
              isError: true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(width: 1, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        height: 60,
        // constraints:
        //     const BoxConstraints(minWidth: 100), // Making width flexible
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: 'NEXT'
            .text
            .size(15)
            .bold
            .fontFamily(regular)
            .color(Colors.white)
            .makeCentered(), // Using makeCentered for alignment
      ),
    ); // Adding vertical padding for better spacing
  }
}
