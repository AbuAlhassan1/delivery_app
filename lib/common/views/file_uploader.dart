// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:delivery/common/helper/file_picker.dart';
import 'package:delivery/common/helper/image_cropper.dart';
import 'package:delivery/common/helper/image_picker.dart';
import 'package:delivery/common/models/file_field_data_object.dart';
import 'package:delivery/common/views/network_image_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_fade/image_fade.dart';

class FileUploader extends StatefulWidget {
  final FileFieldDataObject fieldObject;
  final String placeHolderPath;
  final double? aspectRatioX;
  final double? aspectRatioY;
  final bool isImage;
  const FileUploader({
    super.key,
    required this.fieldObject,
    required this.placeHolderPath,
    this.aspectRatioX,
    this.aspectRatioY,
    this.isImage = true,
  });

  @override
  State<FileUploader> createState() => _FileUploaderState();
}

class _FileUploaderState extends State<FileUploader> {

  Future<void> getImage() async {
    final File? image = await imagePicker();

    if(image != null){
      widget.fieldObject.file = await imageCropper(
        imageFile: image,
        aspectRatioX: widget.aspectRatioX,
        aspectRatioY: widget.aspectRatioY,
      );
      setState((){});
    }
  }

  showOptions() async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ScreenUtil().setHeight(12))),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(ScreenUtil().setHeight(12)),
          child: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10)),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(TablerIcons.camera, size: ScreenUtil().setHeight(30)),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        Text(
                          "التقاط صورة",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setHeight(16)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    if( widget.fieldObject.file == null ){
                      if( widget.isImage ){
                        await getImage();
                      } else {
                        widget.fieldObject.file = await filePicker();
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10)),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(ScreenUtil().setHeight(10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(TablerIcons.files, size: ScreenUtil().setHeight(30)),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                        Text(
                          "رفع من الملفات",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setHeight(16)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (x){
        if( widget.fieldObject.validator != null ){
          return widget.fieldObject.validator!(widget.fieldObject.file, widget.fieldObject.preview);
        } else {
          return null;
        }
      },
      builder: (field) => SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            widget.fieldObject.lable != null ?
            Padding(
              padding: EdgeInsetsDirectional.only(bottom: ScreenUtil().setHeight(5), start: ScreenUtil().setHeight(5)),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.fieldObject.lable!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setHeight(12)
                      )
                    ),
                  ] + (
                    widget.fieldObject.isRequired ?
                    const [TextSpan(
                      text: "*",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                      ),
                    )] : []
                  )
                )
              ),
            ) : const SizedBox(),
          
            InkWell(
              onTap: () async {
                showOptions();
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                padding: EdgeInsets.all(ScreenUtil().setHeight(2)),
                radius: Radius.circular(ScreenUtil().setHeight(6)),
                dashPattern: const [5, 5],
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias, width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenUtil().setHeight(5)),
                        child: SizedBox(
                          child: widget.fieldObject.file != null ?
                          ImageFade(
                            image: FileImage(widget.fieldObject.file!),
                            fit: BoxFit.cover,
                          ) :
                          (
                            widget.fieldObject.preview != null ?
                            NetWorkImageWidget(url: widget.fieldObject.preview!) :
                            ImageFade(
                              image: AssetImage(widget.placeHolderPath),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                      ),
                    ),
            
                    widget.fieldObject.file != null ?
                    PositionedDirectional(
                      end: 0, top: 0,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
                        child: IconButton(
                          onPressed: () async {
                            if( widget.fieldObject.file != null ){
                              getImage();
                            }
                          },
                          icon: const Icon(TablerIcons.edit),
                          color: Colors.white,
                          highlightColor: Colors.grey,
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black.withOpacity(0.5))),
                        ),
                      )
                    ) : const SizedBox()
                  ],
                ),
              ),
            ),
          
            field.hasError ? Text(
              field.errorText.toString(),
              style: TextStyle(
                color: Colors.red,
                fontSize: ScreenUtil().setHeight(14)
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }
}