import 'package:flutter/material.dart';
import 'package:bmr_calculator/constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  final String buttonTitle; 
  final Function() onTap; 

  @override
  Widget build(BuildContext context) {
    // SafeArea supaya tombol tidak tertutup garis navigasi HP
    return SafeArea(
      top: false,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          height: bottomContainerHeight,
          color: bottomContainerColor,
          child: Center(
            child: Text(
              buttonTitle,
              style: buttonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
