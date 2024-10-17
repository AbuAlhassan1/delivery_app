import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File?> imageCropper({required File imageFile, double? aspectRatioX, double? aspectRatioY}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatio: aspectRatioX == null || aspectRatioY == null ? null : CropAspectRatio(ratioX: aspectRatioX, ratioY: aspectRatioY),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
      ),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  if ( croppedFile != null ){
    return File(croppedFile.path);
  }

  return null;
}