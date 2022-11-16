import 'package:flutter/material.dart';
import 'package:sure_learn_electrical/configs/themes/custom_text_style.dart';

class CoutdownTimer extends StatelessWidget {
  const CoutdownTimer({super.key, this.color, required this.time});

  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: countdownTimerTs().copyWith(color: color),
        ),
      ],
    );
  }
}
