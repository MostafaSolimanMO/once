
import 'dart:async';

import 'package:flutter/services.dart';

class Once {
  static const MethodChannel _channel = MethodChannel('once');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
