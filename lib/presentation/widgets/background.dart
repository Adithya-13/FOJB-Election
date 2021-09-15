import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool isLogin;

  const Background({
    Key? key,
    required this.child,
    this.isLogin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SvgPicture.asset(
            isLogin ? Resources.loginBackground : Resources.background,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
