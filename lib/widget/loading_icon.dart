import 'package:flutter/material.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 28.0,
      height: size ?? 28.0,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).primaryColor,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
