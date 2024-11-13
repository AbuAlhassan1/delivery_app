import 'package:delivery/driver/views/widgets/driver_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DriverProfilePageWrapper extends StatelessWidget {
  const DriverProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < constraints.maxHeight) {
          return const DriverProfileVertical();
        } else {
          return const DriverProfileHorizontal();
        }
      },
    );
  }
}

class DriverProfileVertical extends StatelessWidget {
  const DriverProfileVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('دلفــري العراق'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: const Icon(Icons.arrow_back_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Stack(
        children: [
          const DriverInfoCard(),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 5,
                  child: Icon(Icons.person, size: 50.sp),
                ),
              ),
            )
          ),
      
        ],
      ),
    );
  }
}

class DriverProfileHorizontal extends StatelessWidget {
  const DriverProfileHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.red);
  }
}