import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Helper.unfocus(),
      child: Scaffold(
        body: Background(
          isLogin: true,
          child: SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(Helper.normalPadding),
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).padding.top +
                        MediaQuery.of(context).padding.bottom) -
                    40,
                child: _loginContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _fojbLogo(context),
        _loginTextField(context),
      ],
    );
  }

  Widget _fojbLogo(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Resources.fojbLogo,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            'Login dulu yuk!',
            style: AppTheme.headline1.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _loginTextField(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nomor Telepon', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextField(
              style: AppTheme.text3.white,
              decoration: InputDecoration(
                hintText: 'Masukan nomor telepon kamu',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            CustomButton(
              onTap: () => Navigator.pushReplacementNamed(context, PagePath.home),
              text: 'Masuk',
            ),
          ],
        ),
      ),
    );
  }
}
