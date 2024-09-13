import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MindMorphFilePicker extends StatefulWidget {
  const MindMorphFilePicker(
      {super.key,
      required this.labelText,
      required this.type,
      this.allowedExtensions,
      required this.callback,
      this.isFileOptional});
  final String labelText;
  final FileType type;
  final List<String>? allowedExtensions;
  final bool? isFileOptional;
  final void Function(File) callback;

  @override
  State<MindMorphFilePicker> createState() => _MindMorphFilePickerState();
}

class _MindMorphFilePickerState extends State<MindMorphFilePicker> {
  File? file;
  String? fileName;

  Future<void> _getFile(FileType type) async {
    FilePickerResult? result;
    if (type == FileType.custom) {
      result = await FilePicker.platform
          .pickFiles(type: type, allowedExtensions: widget.allowedExtensions);
    } else {
      result = await FilePicker.platform.pickFiles(
        type: type,
      );
    }
    if (result != null) {
      List<PlatformFile> files = result.files;

      setState(() {
        if (files.isNotEmpty && files.first.path != null) {
          file = File(files.first.path!);
          widget.callback(file!);
        }
        fileName = files.first.name;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelText =
        fileName == null ? widget.labelText : 'Change ${widget.labelText}';
    final validationText = '${widget.labelText} is Required';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () async => await _getFile(widget.type),
          child: Text(labelText, style: const TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 0, bottom: 10),
          child: Text(
            fileName ?? '',
            style: const TextStyle(
                color: Color.fromARGB(255, 113, 108, 107), fontSize: 10),
          ),
        ),
        file == null
            ? Text(
                widget.isFileOptional == true ? '' : validationText,
                style: const TextStyle(
                    color: Color.fromARGB(255, 247, 13, 28), fontSize: 10),
              )
            : widget.type == FileType.image
                ? Image.file(
                    file!,
                    height: 150,
                  )
                : widget.type == FileType.custom
                    ? const SizedBox()
                    : BetterPlayer.file(
                        file!.path,
                        betterPlayerConfiguration:
                            const BetterPlayerConfiguration(
                          // aspectRatio: 16 / 9,
                          autoPlay: false,
                        ),
                      ),
      ],
    );
  }
}
