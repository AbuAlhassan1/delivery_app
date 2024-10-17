import 'package:delivery/common/models/log_storage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogsPageWrapper extends StatefulWidget {
  const LogsPageWrapper({super.key});

  @override
  State<LogsPageWrapper> createState() => _LogsPageWrapperState();
}

class _LogsPageWrapperState extends State<LogsPageWrapper> {
  @override
  Widget build(BuildContext context) {

    List<String> logs = LogStorage.getLogs().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Log"),
        actions: [
          IconButton(
            onPressed: () => setState(() => LogStorage.clearLogs()),
            icon: const Icon(Icons.delete_sweep_outlined)
          ),
          IconButton(
            onPressed: () async {
              logs = LogStorage.getLogs().reversed.toList();
              setState((){});
            },
            icon: const Icon(Icons.refresh)
          ),
        ],
      ),
      body: Scrollbar(
        thickness: ScreenUtil().setHeight(20),
        trackVisibility: true,
        thumbVisibility: true,
        scrollbarOrientation: ScrollbarOrientation.right,
        radius: Radius.circular(100.sp),
        child: ListView.builder(
          itemCount: logs.length,
          reverse: true,
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(10)),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // IconButton(
                //   onPressed: (){},
                //   icon: const Icon(Icons.keyboard_arrow_down_rounded),
                // ),
                Text(
                  logs[index],
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}