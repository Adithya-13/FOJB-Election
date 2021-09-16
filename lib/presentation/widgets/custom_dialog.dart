import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final Widget? buttons;

  const CustomDialog({Key? key, required this.title, required this.content, this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      insetPadding: EdgeInsets.all(20),
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTheme.headline3),
              SizedBox(height: 16.0),
              content,
              buttons != null ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.0),
                  buttons!,
                ],
              ): Container(),
            ],
          ),
        ),
      ),
    );
  }
}