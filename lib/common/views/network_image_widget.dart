import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/common/utils/interfaces/storage_interface.dart';
import 'package:delivery/constants/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetWorkImageWidget extends StatelessWidget {
  final String url;
  NetWorkImageWidget({super.key, required this.url});

  final StorageInterFace storage = locator.get<StorageInterFace>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      initialData: null,
      future: storage.read(secureStorageUserInfo),
      builder: (context, snapshot) {

        return snapshot.connectionState == ConnectionState.waiting ?
        CircularProgressIndicator(color: Colors.black, strokeWidth: 1.sp) :
        CachedNetworkImage(
          imageUrl: url,
          // httpHeaders: {"Authorization": "Bearer ${userProfile != null ? userProfile.accessToken : ''}"},
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.sp),
          ),
        );
      },
    );
  }
}