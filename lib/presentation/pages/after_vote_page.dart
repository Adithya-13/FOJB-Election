import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';

class AfterVotePage extends StatefulWidget {
  const AfterVotePage({Key? key}) : super(key: key);

  @override
  _AfterVotePageState createState() => _AfterVotePageState();
}

class _AfterVotePageState extends State<AfterVotePage> {
  static const Duration _navigateDelay = Duration(seconds: 3);

  @override
  void initState() {
    _navigateOtherScreen();
    super.initState();
  }

  void _navigateOtherScreen() {
    Future.delayed(_navigateDelay).then(
      (_) => Navigator.pushNamedAndRemoveUntil(
          context, PagePath.home, (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
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
            Expanded(
              child: Text('Terima kasih telah Voting!',
                  style: AppTheme.headline2.white),
            ),
          ],
        ),
      ),
    );
  }
}
