import 'dart:async';
import 'package:flutter/foundation.dart';

class DeBouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  /// It takes time in milliseconds after which the method need to be execute
  DeBouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
