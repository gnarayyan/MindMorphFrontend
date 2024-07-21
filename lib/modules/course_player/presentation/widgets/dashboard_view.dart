import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/course_player/data/repositories/course_repository.dart';
import 'package:mindmorph/utils/get_formated_time.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/pdf_view_screen.dart';
import 'package:mindmorph/widgets/snackbar.dart';
import '../../../cart/data/repositories/cart_repository.dart';
import '../../../cart/models/add_to_cart.dart';
import '../../../upload_course/data/repositories/course_section.dart';
import '../../../upload_course/models/course_section/section_preview_response.dart';
import '/constants/color.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../bloc/imports.dart';
import 'course_details_view.dart';
import 'dashboard/course_progress_bar.dart';
import 'dashboard/dashboard_tab_controller.dart';
import 'xyz_player.dart';

class DashboardView extends StatelessWidget {
  const DashboardView(
      {super.key,
      required this.courseData,
      required this.areSectionsPlayAble,
      required this.showAddToCartBtn,
      required this.hasEnrolled});
  final CourseResponse courseData;
  final bool areSectionsPlayAble;
  final bool showAddToCartBtn;
  final bool hasEnrolled;

  @override
  Widget build(BuildContext context) {
    final course = courseData.course;
    final courseDetails = courseData.courseDetails;

    return BlocProvider(
      create: (context) =>
          VideoBloc(courseDetails.titleVideoUrl, courseDetails.title),
      child: Scaffold(
        backgroundColor: themecolor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<VideoBloc, VideoState>(
                  builder: (context, state) {
                    final videoUrl = 'http://$COURSE_SERVER/${state.videoUrl}';

                    // return PDFViewWidget(
                    //     lectureName: state.videoTitle, pdfUrl: videoUrl);

                    if (state.isAttachment) {
                      return const Center(child: Text('Loading DPF'));
                    }

                    return XYZPlayer(
                      videoUrl: videoUrl,
                      lectureId: hasEnrolled ? state.lectureId : '',
                    );
                  },
                ),
                5.heightBox,
                areSectionsPlayAble
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: context.width * .7,
                              child: BlocBuilder<VideoBloc, VideoState>(
                                builder: (context, state) {
                                  return Text(
                                    state.videoTitle,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis),
                                  );
                                },
                              )),
                          //
                          // progress:courseDetails
                          CourseProgressBar(
                              completed: courseDetails.courseCompleted),
                        ],
                      )
                    : CourseDetails(course: course, title: courseDetails.title),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showAddToCartBtn)
                      ElevatedButton.icon(
                        onPressed: () async {
                          final requestData =
                              AddToCartRequestModel(courseId: course.id);
                          final response =
                              await CartRepository.addToCart(requestData);
                          if (context.mounted) {
                            mindMorphSnackBar(
                                context: context,
                                message: response.message,
                                isError: !response.isSuccess);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 42, 40, 40),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.add_shopping_cart_sharp,
                            color: Colors.white),
                        label: const Text('Add to Cart'),
                      )
                  ],
                ),
                DashboardTabController(
                  courseDetails: courseDetails,
                  // courseModel: course,
                  courseSectionView:
                      FutureBuilder<List<CourseSectionResponseModel>>(
                    future: CourseSectionRepository.previewSection(
                        courseId: course.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MindMorphLoadingIndicator();
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data available'));
                      } else {
                        List<CourseSectionResponseModel> sections =
                            snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sections.length,
                          itemBuilder: (context, index) {
                            final section = sections[index];

                            return ExpansionTile(
                              maintainState: true,
                              tilePadding: const EdgeInsets.only(left: 8),
                              title: Text(
                                section.title,
                                style: const TextStyle(color: Vx.amber100),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: section.lectures.length,
                                  itemBuilder: ((context, index) {
                                    final lecture = section.lectures[index];
                                    return ListTile(
                                      title: Text(
                                        lecture.title,
                                        style:
                                            const TextStyle(color: titlecolor),
                                      ),
                                      subtitle: Text(
                                        getFormatedTime(
                                            seconds: lecture.duration),
                                        style: const TextStyle(
                                            color: featureColor),
                                      ),
                                      onTap: !areSectionsPlayAble
                                          ? () {}
                                          : () {
                                              if (lecture.isAttachment) {
                                                final pdfUrl =
                                                    'http://$COURSE_SERVER/${lecture.file}';
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PDFViewScreen(
                                                            appBarTitle:
                                                                lecture.title,
                                                            pdfUrl: pdfUrl,
                                                          )),
                                                );
                                              } else {
                                                context.read<VideoBloc>().add(
                                                    VideoUrlChanged(
                                                        lecture.file,
                                                        lecture.title,
                                                        lecture.id,
                                                        lecture.isAttachment));
                                              }

                                              // get Data about lecture
                                            },
                                    );
                                  }),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
