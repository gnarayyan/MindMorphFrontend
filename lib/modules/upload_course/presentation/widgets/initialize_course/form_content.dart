import 'package:flutter/material.dart';
import 'package:mindmorph/widgets/form_field.dart';
import '../../../../../widgets/dropdown.dart';
import 'course_options.dart';
import 'submit_button.dart';
import '../../../data/validators/price_validator.dart' as validator;

class FormContent extends StatefulWidget {
  const FormContent({super.key});

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  String? courseCategoryId;
  String? courseDomainId;
  String? languageChoice;
  List<String> languages = ['English', 'Nepali', 'Hindi', 'German'];
  final _priceController = TextEditingController();

  void setCourseData({required String domainId, required String categoryId}) {
    courseDomainId = domainId;
    courseCategoryId = categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseOptions(
            updateCourseData: setCourseData,
          ),
          const SizedBox(height: 15),
          MindMorphDropdown(
            hint: 'Language',
            items: {for (String item in languages) item: item},
            selectedItem: languageChoice,
            onChanged: (value) {
              setState(() {
                languageChoice = value;
              });
            },
          ),
          const SizedBox(height: 15),
          MindMorphFormField(
            controller: _priceController,
            labelText: 'Course Price',
            validator: validator.priceValidator,
            minLines: 1,
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 30),
          SubmitButton(
            courseDomainId: courseDomainId,
            courseCategoryId: courseCategoryId,
            languageChoice: languageChoice,
            priceController: _priceController,
          ),
        ],
      ),
    );
  }
}


// class _FormContentState extends State<FormContent> {
//   String? courseCategoryId;
//   String? courseDomainId;
//   String? languageChoice;
//   List<String> languages = ['English', 'Nepali', 'Hindi', 'German'];
//   final _priceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ListFetchBloc, ListFetchState>(
//       builder: (context, state) {
//         if (state is ListFetchLoading || state is SubmissionLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is ListFetchLoaded) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MindMorphDropdown(
//                   hint: 'Course Domain',
//                   items: state.courseDomains,
//                   selectedItem: courseDomainId,
//                   onChanged: (value) {
//                     setState(() {
//                       courseDomainId = value;
//                       courseCategoryId = null;
//                     });
//                     context
//                         .read<ListFetchBloc>()
//                         .add(FetchList2(courseDomainId: value!));
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MindMorphDropdown(
//                   hint: 'Course Category',
//                   items: state.courseCategories,
//                   selectedItem: courseCategoryId,
//                   onChanged: (value) {
//                     setState(() {
//                       courseCategoryId = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MindMorphDropdown(
//                   hint: 'Language',
//                   items: {for (String item in languages) item: item},
//                   selectedItem: languageChoice,
//                   onChanged: (value) {
//                     setState(() {
//                       languageChoice = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 15),
//                 MindMorphFormField(
//                   controller: _priceController,
//                   labelText: 'Course Price',
//                   validator: _validator.priceValidator,
//                   minLines: 1,
//                   maxLines: 1,
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 30),
//                 SubmitButton(
//                   courseDomainId: courseDomainId,
//                   courseCategoryId: courseCategoryId,
//                   languageChoice: languageChoice,
//                   priceController: _priceController,
//                 ),
//               ],
//             ),
//           );
//         } else if (state is ListFetchError) {
//           return Center(child: Text('Fetch Error: ${state.message}'));
//         } else if (state is SubmissionError) {
//           return Center(child: Text('Submission Error: ${state.message}'));
//         }
//         return const Center(child: Text('Unexpected state'));
//       },
//     );
//   }
// }
