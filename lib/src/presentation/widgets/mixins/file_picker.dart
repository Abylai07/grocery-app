import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

mixin FilePickerMixin {
  Future<List<File>> pickPhotoMulti(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    List<File> files = [];
    if (result?.files != null) {
      for (var item in result!.files) {
        files.add(File(item.path!));
      }
    }
    return files;
  }

  Future<File?> pickPhotoSingle(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    File? file;
    if (result?.files != null) {
      for (var item in result!.files) {
        file = File(item.path!);
      }
    }
    return file;
  }

  Future<File?> takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    final directory = await getTemporaryDirectory();

    final filePath = path.join(directory.path, photo?.path);

    final file = File(filePath);
    return file;

  }
}