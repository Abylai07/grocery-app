import 'dart:io';
import 'package:path_provider/path_provider.dart';

mixin CacheFileMixin {
  Future<void> checkStorageUsage() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();

    double tempDirSize = getDirSize(tempDir);
    print("Documents Directory Size: ${getDirSize(appDocDir)} bytes");
    print("Temp Directory Size: $tempDirSize bytes");

    // If Temp Directory size exceeds 30 MB, clear it
    if (tempDirSize > 30) {
      print("Temp directory exceeds 30 MB. Clearing...");
      clearTempFiles(tempDir);
    }
  }

  double getDirSize(Directory dir) {
    int size = 0;
    try {
      dir.listSync(recursive: true).forEach((file) {
        if (file is File) {
          size += file.lengthSync();
        }
      });
    } catch (e) {
      print("Error calculating directory size: $e");
    }
    return (size / 1024) / 1024;
  }

  void clearTempFiles(Directory tempDir) {
    try {
      tempDir.listSync(recursive: true).forEach((file) {
        if (file is File) {
          file.deleteSync();
        }
      });
      print("Temp directory cleared successfully.");
    } catch (e) {
      print("Error clearing temp directory: $e");
    }
  }
}