import 'dart:io';

class UploadFileParams {
  final File file;
  final String fileName;

  UploadFileParams({
    required this.file,
    required this.fileName,
  });
}
