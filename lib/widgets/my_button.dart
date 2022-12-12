import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.color,
    required this.title,
    required this.function,
    required this.isWaiting,
  }) : super(key: key);
  final Color color;
  final String title;
  final VoidCallback function;
  final bool isWaiting;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Material(
        elevation: 4,
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        child: MaterialButton(
          onPressed: function,
          // minWidth: 200,
          height: 42,
          child: isWaiting
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: LoadingIndicator(
                    indicatorType: Indicator.circleStrokeSpin,
                    colors: [Colors.white],
                  ),
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
