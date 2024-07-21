import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/home_container.dart';
import '../../bloc/course_view_bloc.dart';
import '/widgets/loading_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _courseViewBloc = CourseViewBloc();

  @override
  void initState() {
    _courseViewBloc.add(CoursesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _courseViewBloc,
      child: BlocListener<CourseViewBloc, CourseViewState>(
        listener: (context, state) {
          if (state is CourseViewFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<CourseViewBloc, CourseViewState>(
            builder: (context, state) {
          if (state is CourseViewSuccess) {
            return HomeContainer(
                trendingCourses: state.trendingCourses,
                newCourses: state.newCourses,
                recommendedCourses: state.recommendedCourses);
          }

          return const MindMorphLoadingIndicator();
        }),
      ),
    );
  }
}
