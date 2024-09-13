import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mindmorph/constants/constants.dart';
import 'package:mindmorph/constants/urls.dart';
import 'package:mindmorph/widgets/loading_indicator.dart';
import 'package:mindmorph/widgets/snackbar.dart';

import '../../data/repository/swiper_repository.dart';
import '../../models/swiper_model.dart';

class SwiperScreen extends StatefulWidget {
  const SwiperScreen({super.key});

  @override
  State<SwiperScreen> createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  List<SwiperModel> swipers = [];

  void initSwipers() async {
    final response = await SwiperRepository.getAllSwipers();
    setState(() {
      swipers = response;
    });
  }

  @override
  void initState() {
    super.initState();
    initSwipers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      appBar: AppBar(
        backgroundColor: listcolor,
        centerTitle: true,
        title: const Text(
          'SWIPER IMAGES',
          style: TextStyle(color: titlecolor, fontSize: 18),
        ),
      ),
      body: swipers.isEmpty
          ? const MindMorphLoadingIndicator()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: swipers.length,
              itemBuilder: (BuildContext context, int index) {
                final swiper = swipers[index];
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'http://$NODE_SERVER/${swiper.image}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          // Send request to backend: swiper.id
                          final response =
                              await SwiperRepository.deleteSwiper(swiper.id);

                          if (context.mounted) {
                            mindMorphSnackBar(
                                context: context,
                                message: response.message,
                                isError: !response.isSuccess);
                          }
                          // Delete from list

                          if (response.isSuccess) {
                            setState(() {
                              swipers.remove(swiper); //response.swiper
                            });
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: titlecolor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 224, 5, 5),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (result != null) {
            String path = result.files.first.path!;

            final response = await SwiperRepository.uploadSwiper(path);

            if (context.mounted) {
              mindMorphSnackBar(
                  context: context,
                  message: response.message,
                  isError: !response.isSuccess);
            }

            if (response.isSuccess) {
              setState(() {
                swipers.add(response.swiper);
              });
            }
          }
        },
        backgroundColor: listcolor,
        child: const Icon(
          Icons.add,
          color: titlecolor,
        ),
      ),
    );
  }
}
