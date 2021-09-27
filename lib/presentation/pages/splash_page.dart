import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const Duration _navigateDelay = Duration(seconds: 3);

  @override
  void initState() {
    _navigateOtherScreen();
    super.initState();
  }

  void _navigateOtherScreen() {
    GetStorage _getStorage = GetStorage();
    bool isLoggedIn = _getStorage.read(Keys.isLoggedIn) ?? false;
    if (!isLoggedIn) {
      Future.delayed(_navigateDelay)
          .then((_) => Navigator.pushReplacementNamed(context, PagePath.login));
    } else {
      Future.delayed(_navigateDelay)
          .then((_) => Navigator.pushReplacementNamed(context, PagePath.base));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Resources.fojbLogo,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              Text(
                'FOJB Election',
                style: AppTheme.text1.white,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
