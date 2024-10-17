import 'dart:io';
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

Future<File?> imagePicker ({int? fileSize}) async {
  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery
  );

  if ( image != null ){
    if( fileSize != null ){
      int maxFileSize = fileSize * 1024 * 1024;
      File imageFile = File(image.path);

      if( imageFile.lengthSync() <= maxFileSize ){
        return File(image.path);
      } else {
        // showToast(
        //   message: message,
        //   toastType: toastType
        // );
        // TODO :: Show Toast ...
        return null;
      }

    }
    return File(image.path);
  }
  return null;
}