import 'package:flutter/material.dart';
import 'package:mindmorph/constants/urls.dart';

import 'package:mindmorph/widgets/loading_indicator.dart';

import '../../../data/provider/get_thumbnail_url.dart';

class CourseThumbnail extends StatefulWidget {
  const CourseThumbnail({super.key, required this.courseId});
  final int courseId;

  @override
  State<CourseThumbnail> createState() => _CourseThumbnailState();
}

class _CourseThumbnailState extends State<CourseThumbnail> {
  String? thumbnailUrl;

  void fetchThumbnail() async {
    final url = await getThumbnailUrl(widget.courseId);
    setState(() {
      thumbnailUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return thumbnailUrl == null
        ? const MindMorphLoadingIndicator()
        : Image.network(
            'http://$COURSE_SERVER/${thumbnailUrl!}',
            fit: BoxFit.cover,
          );
  }
}
