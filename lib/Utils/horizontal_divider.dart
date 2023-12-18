import 'package:flutter/cupertino.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key, required this.height,
  }) : super(key: key);
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
    );
  }
}