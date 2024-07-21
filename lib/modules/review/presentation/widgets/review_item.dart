import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/modules/course_player/presentation/widgets/dashboard/rating_bar.dart';

import 'package:mindmorph/widgets/snackbar.dart';

import '../../data/repositories/reply_repository.dart';
import '../../models/get_all_review_model.dart';
import '../../models/create_reply_model.dart';

class ReviewWidget extends StatefulWidget {
  final Review review;
  final int courseId;
  // final int authorId;
  final bool isUserAuthor;
  // final Function(String) onReplyAdded;

  const ReviewWidget({
    super.key,
    required this.review,
    required this.courseId,
    // required this.authorId,
    required this.isUserAuthor,
    // required this.onReplyAdded
  });

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 133, 133, 133),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReviewCard(review: widget.review),

            ReviewReplyView(
                replies: widget.review.replies,
                reviewId: widget.review.id,
                courseId: widget.courseId,
                isUserAuthor: widget.isUserAuthor
                // onReplyAdded: widget.onReplyAdded
                )

            // const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class ReviewReplyView extends StatefulWidget {
  const ReviewReplyView({
    super.key,
    required this.replies,
    required this.reviewId,
    required this.courseId,
    required this.isUserAuthor,
    // required this.review,
    // this.onReplyAdded
  });
  final List<Reply> replies;
  final int reviewId;
  final int courseId;
  final bool isUserAuthor;

  // final Function(String)? onReplyAdded;
  // final Review review;

  @override
  State<ReviewReplyView> createState() => _ReviewReplyViewState();
}

class _ReviewReplyViewState extends State<ReviewReplyView> {
  late List<Reply> replies;
  // late bool hasReply;
  bool hideReplyField = true;
  final _replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      replies = widget.replies;
      // hasReply = widget.replies.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (replies.isNotEmpty) {
      return Column(
        children: [
          const SizedBox(height: 8.0),
          Padding(
              padding: const EdgeInsets.only(left: 25),
              // Assuming every replies list have single reply from Instructor

              child: ReplyCard(reply: replies[0])),
        ],
      );
    } else if (widget.isUserAuthor && hideReplyField) {
      return TextButton(
          onPressed: () {
            setState(() {
              hideReplyField = false;
            });
          },
          child: const Text(
            'Reply',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ));
    } else if (widget.isUserAuthor && !hideReplyField) {
      return TextField(
        controller: _replyController,
        decoration: InputDecoration(
          hintText: 'Reply to this review...',
          hintStyle: const TextStyle(
            color: titlecolor,
          ),
          fillColor: featureColor,
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              // Validate Reply Text
              final replyText = _replyController.text.trim();

              String errorMessage = replyText.length < 10
                  ? 'Reply must have at least 10 characters'
                  : replyText.length > 500
                      ? 'Reply must have at max 500 characters'
                      : '';
              if (errorMessage.isNotEmpty) {
                mindMorphSnackBar(
                    context: context, message: errorMessage, isError: true);
                return;
              }

              // Send Data to Backend
              final replyData = CreateReviewReplyModel(
                  content: replyText,
                  courseId: widget.courseId,
                  reviewId: widget.reviewId);

              final result = await ReplyRepository.addReply(
                  await replyData.toRequestBody());

              if (result.isFailure && context.mounted) {
                mindMorphSnackBar(
                    context: context,
                    message: result.message,
                    isError: result.isFailure);
                return;
              }

              // Clear TextField
              _replyController.clear();

              // Get ReplyModel from response
              final reply = result.data;

              // Update replyList
              setState(() {
                // widget.review.replies.add(reply);
                replies.add(reply!);
                // hasReply = true;
              });
              // widget.onReplyAdded!(replyController.text);
            },
          ),
        ),
      );
    }
    return const SizedBox(height: 0, width: 0);
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: listcolor,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserDetailInReview(
              avatarUrl: review.user.avatar,
              fullName: review.user.fullName,
              //TODO: send id to update, delete review
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RatingBar(rating: review.rating),
                const SizedBox(width: 20),
                Text(
                  review.updatedAt,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            ReviewContentsInReview(content: review.content),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.reply});
  final Reply reply;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(179, 236, 44, 82),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserDetailInReview(
              avatarUrl: reply.user.avatar,
              fullName: reply.user.fullName,

              //TODO: send id to update, delete reply
            ),
            const SizedBox(height: 12.0),
            ReviewContentsInReview(content: reply.content),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

// User Details
class UserDetailInReview extends StatelessWidget {
  final String fullName;

  final String avatarUrl;

  const UserDetailInReview(
      {super.key, required this.fullName, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            'http://$NODE_SERVER/$avatarUrl',
            width: 30,
            height: 30,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          fullName,
          style: const TextStyle(
              fontSize: 20.0, color: titlecolor, fontWeight: FontWeight.bold),
        ),
      ],
    );
    //Update or Delete Review
    //     IconButton(
    //         onPressed: () {
    //           _showOptions(context);
    //         },
    //         icon: const Icon(Icons.more_vert))
    //   ],
    // );
  }

  // Popup operations
  void _showOptions(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        context.width - offset.dx,
        offset.dy + 10, // + button.size.height,
        offset.dx + button.size.width + 20,
        offset.dy + button.size.height + 10,
      ),
      items: [
        PopupMenuItem(
          value: 1,
          child: ElevatedButton.icon(
            label: const Text('Update'),
            icon: const Icon(Icons.edit),
            onPressed: () {
              print('Update Pressed');
            },
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Delete'),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle item selection
      if (value != null) {
        _handleMenuSelection(context, value);
      }
    });
  }

  void _handleMenuSelection(BuildContext context, int value) {
    switch (value) {
      case 1:
        // Update action
        print('Update action');
        break;
      case 2:
        // Delete action
        print('Delete action');
        break;
    }
  }
}

class ReviewContentsInReview extends StatelessWidget {
  final String content;

  const ReviewContentsInReview({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content, textAlign: TextAlign.left,
      maxLines: 5,
      // overflow: TextOverflow.clip,
      style: const TextStyle(
        fontSize: 16.0,
        color: featureColor,
      ),
    );
  }
}
