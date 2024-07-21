part of 'course_view_bloc.dart';

@immutable
sealed class CourseViewState {}

final class CourseViewInitial extends CourseViewState {}

final class CourseViewSuccess extends CourseViewState {
  final List<CourseCarasoulData> trendingCourses;
  final List<CourseCarasoulData> newCourses;
  final List<CourseCarasoulData> recommendedCourses;

  CourseViewSuccess(
      {required this.recommendedCourses,
      required this.trendingCourses,
      required this.newCourses});
}

final class CourseViewFailure extends CourseViewState {
  final String errorMessage;

  CourseViewFailure(this.errorMessage);
}

final class CourseViewFetching extends CourseViewState {}
