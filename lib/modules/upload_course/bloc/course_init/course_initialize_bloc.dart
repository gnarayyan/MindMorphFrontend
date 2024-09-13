import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/course_domain_repository.dart';
import '../../data/repositories/course_category_repository.dart';
import '../../data/repositories/course_initialize_submit_repository.dart';
import '../../models/course_init/response_model.dart';
import '../../models/course_init/submit_model.dart';

part 'course_initialize_event.dart';

part 'course_initialize_state.dart';

class ListFetchBloc extends Bloc<ListFetchEvent, ListFetchState> {
  late Map<String, String> courseDomains;
  ListFetchBloc() : super(ListFetchInitial()) {
    on<FetchList1>((event, emit) async {
      emit(ListFetchLoading());
      try {
        courseDomains = await CourseDomainRepository.allDomain();
        // xyz = courseDomains;
        emit(ListFetchLoaded(
            courseDomains: courseDomains, courseCategories: const {}));
      } catch (e) {
        emit(ListFetchError(message: e.toString()));
      }
    });

    on<FetchList2>((event, emit) async {
      emit(ListFetchLoading());
      try {
        final courseCategories =
            await CourseCategoryRepository.allCategoriesOfADomain(
                domainId: event.courseDomainId);
        if (state is ListFetchLoaded) {
          emit(ListFetchLoaded(
              courseDomains:
                  courseDomains, //(state as ListFetchLoaded).courseDomains,
              courseCategories: courseCategories));
        } else {
          emit(ListFetchLoaded(
              courseDomains: courseDomains,
              courseCategories: courseCategories));
        }
      } catch (e) {
        emit(ListFetchError(message: e.toString()));
      }
    });

    on<SubmitSelections>((event, emit) async {
      emit(SubmissionLoading());
      try {
        final courseInitResponse =
            await CourseInitializeSubmitRepository.send(event.dataToSubmit);
        emit(SubmissionSuccess(courseInitResponse: courseInitResponse));
      } catch (e) {
        emit(SubmissionError(message: e.toString()));
      }
    });
  }
}
