import 'package:flutter/material.dart';

class NoMultiTouchScrollPhysics extends ScrollPhysics {
  const NoMultiTouchScrollPhysics({super.parent});

  @override
  NoMultiTouchScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return NoMultiTouchScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    // Only accept scroll if one finger is being used
    return true;
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Ignore two-finger gestures
    return offset;
  }
}