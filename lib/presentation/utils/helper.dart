import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class Helper {
  static void unfocus() {
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
  }

  ///padding 32
  static double get bigPadding {
    return 20;
  }

  ///padding 20
  static double get normalPadding {
    return 20;
  }

  ///padding 12
  static double get smallPadding {
    return 12;
  }

  static List<BoxShadow> getShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> getBigShadow() {
    return [
      BoxShadow(
        color: AppTheme.darkGreen.withOpacity(0.8),
        blurRadius: 12,
        offset: Offset(0, 4),
      ),
    ];
  }

  static List<BoxShadow> getNavBarShadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0,-2),
      ),
    ];
  }

  static void snackBar(BuildContext context, {required String message, bool isError: false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: AppTheme.text1.white),
        backgroundColor: isError ? AppTheme.red : AppTheme.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  static List<String> missions = [
    'Lorem Ipsum Dolor sit Amet',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
    'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
    'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
  ];

}