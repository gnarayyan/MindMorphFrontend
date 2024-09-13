import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmorph/widgets/dropdown.dart';

import '../../../bloc/course_init/course_initialize_bloc.dart';

class CourseOptions extends StatefulWidget {
  const CourseOptions({super.key, required this.updateCourseData});
  final void Function({required String domainId, required String categoryId})
      updateCourseData;

  @override
  State<CourseOptions> createState() => _CourseOptionsState();
}

class _CourseOptionsState extends State<CourseOptions> {
  String? courseCategoryId;
  String? courseDomainId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListFetchBloc, ListFetchState>(
      builder: (context, state) {
        if (state is ListFetchLoading || state is SubmissionLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListFetchLoaded) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MindMorphDropdown(
                hint: 'Course Domain',
                items: state.courseDomains,
                selectedItem: courseDomainId,
                onChanged: (value) {
                  setState(() {
                    courseDomainId = value;
                    courseCategoryId = null;
                  });
                  context
                      .read<ListFetchBloc>()
                      .add(FetchList2(courseDomainId: value!));
                },
              ),
              const SizedBox(height: 15),
              MindMorphDropdown(
                hint: 'Course Category',
                items: state.courseCategories,
                selectedItem: courseCategoryId,
                onChanged: (value) {
                  setState(() {
                    courseCategoryId = value;
                    widget.updateCourseData(
                        domainId: courseDomainId!,
                        categoryId: courseCategoryId!);
                  });
                },
              ),
            ],
          );
        } else if (state is ListFetchError) {
          return Center(child: Text('Fetch Error: ${state.message}'));
        } else if (state is SubmissionError) {
          return Center(child: Text('Submission Error: ${state.message}'));
        }
        return const Center(child: Text('Unexpected state'));
      },
    );
  }
}
