import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Push
{
  void PushTo(var direction, BuildContext context)
  {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => direction),
          (Route<dynamic> route) => false,
    );
  }
}
