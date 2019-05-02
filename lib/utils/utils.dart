


import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {

  static String getImgPath(String name, {String format: 'jpg'}) {
    return 'assets/images/$name.$format';
  }


}