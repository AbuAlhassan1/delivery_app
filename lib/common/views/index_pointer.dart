import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sliderIndex({
  required int index,
  required int numOfPages,
  required double size,
  required Color indexColor,
  required Color otherColor
}){

  List<Widget> dots = [];

  for( int i = 0; i < numOfPages; i++ ){
    dots.add(
      Container(
        height: size, width: size, margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: index == i ? indexColor: otherColor, borderRadius: BorderRadius.circular(50)
        ),
      )
    );
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: dots,
  );
}


class SliderIndex extends StatefulWidget {
  final PageController controller;
  final int index;
  final int numOfPages;
  final double size;
  final Color indexColor;
  final Color otherColor;

  const SliderIndex({
    super.key,
    required this.index,
    required this.numOfPages,
    required this.size,
    required this.indexColor,
    required this.otherColor,
    required this.controller,
  });

  @override
  State<SliderIndex> createState() => _SliderIndexState();
}

class _SliderIndexState extends State<SliderIndex> {

  List<Widget> dots = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() => index = widget.controller.page!.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.numOfPages,
        (i) => Container(
          height: widget.size, width: widget.size, margin: EdgeInsets.symmetric(horizontal: 3.w),
          decoration: BoxDecoration(
            color: index == i ? widget.indexColor: widget.otherColor, borderRadius: BorderRadius.circular(50)
          ),
        )
      ),
    );
  }
}