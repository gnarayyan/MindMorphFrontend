import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../data/repositories/course_view_repository.dart';

import '../models/course_carasoul_data_model.dart';

part 'course_view_event.dart';
part 'course_view_state.dart';

class CourseViewBloc extends Bloc<CourseViewEvent, CourseViewState> {
  CourseViewBloc() : super(CourseViewInitial()) {
    on<CoursesFetched>((event, emit) async {
      emit(CourseViewFetching());
      await _onCoursesFetched(event, emit);
    });
  }

  Future<void> _onCoursesFetched(
      CoursesFetched event, Emitter<CourseViewState> emit) async {
    try {
      // final courses = event.courses;

      final trendingCourses = await CourseViewRepository.trendingCourses();
      final newCourses = await CourseViewRepository.newCourses();
      final recommendedCourses =
          await CourseViewRepository.recommendedCourses();

      emit(
        CourseViewSuccess(
            trendingCourses: trendingCourses,
            newCourses: newCourses,
            recommendedCourses: recommendedCourses),
      );
    } catch (e) {
      return emit(CourseViewFailure(e.toString()));
    }
  }
}
