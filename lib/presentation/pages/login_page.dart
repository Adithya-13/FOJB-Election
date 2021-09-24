import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoading) {
                      Helper.snackBar(context, message: 'Sedang Masuk...');
                    } else if (state is AuthSuccess) {
                      Helper.snackBar(context, message: 'Login berhasil!');
                      Navigator.pushReplacementNamed(context, PagePath.home);
                    } else if (state is AuthFailure) {
                      Helper.snackBar(context, message: state.message);
                    }
                  },
                  child: _loginContent(context),
                ),
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
            Text('ID', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextField(
              controller: phoneNumberController,
              style: AppTheme.text3.white,
              decoration: InputDecoration(
                hintText: 'Masukan ID kamu',
              ),
            ),
            SizedBox(height: 16),
            Text('Password', style: AppTheme.text3.white.bold),
            SizedBox(height: 8),
            TextField(
              controller: passwordController,
              style: AppTheme.text3.white,
              decoration: InputDecoration(
                hintText: 'Masukan password kamu',
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
              onTap: () {
                context.read<AuthBloc>().add(PostAuth(
                      phoneNumber: phoneNumberController.text,
                      password: passwordController.text,
                    ));
              },
              text: 'Masuk',
            ),
          ],
        ),
      ),
    );
  }
}
