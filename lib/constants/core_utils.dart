import 'package:flutter/scheduler.dart';

abstract class CoreUtils {
  const CoreUtils();

  static void postFrameCall(VoidCallback callback) =>
      SchedulerBinding.instance.addPostFrameCallback((_) => callback);
}
