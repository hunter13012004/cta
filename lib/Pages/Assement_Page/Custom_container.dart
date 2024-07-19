import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  Function(Object?)? onChanged;
  String options;

  CustomContainer({super.key, required this.options, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: Center(
            child: Row(
              children: [
                Text(options),
                Radio(value: options, groupValue: 2, onChanged: onChanged)
              ],
            ),
          ),
        )
      ],
    );
  }
}
