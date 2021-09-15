import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnable;
  final bool isOutline;

  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.isEnable: true,
    this.isOutline: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isOutline ? Colors.transparent: isEnable ? AppTheme.blue : AppTheme.darkBlue,
          border: isOutline ? Border.all(color: AppTheme.black, width: 1) : null,
          boxShadow: Helper.getShadow(),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTheme.text2.bold.white,
          ),
        ),
      ),
    );
  }
}
