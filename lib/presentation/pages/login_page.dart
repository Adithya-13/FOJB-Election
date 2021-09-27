import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayColor: AppTheme.black.withOpacity(0.5),
      overlayWidget: Center(
        child: CircularProgressIndicator(
          color: AppTheme.darkBlue,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.blue),
          strokeWidth: 6,
        ),
      ),
      child: GestureDetector(
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
                        context.loaderOverlay.show();
                      } else if (state is AuthSuccess) {
                        context.loaderOverlay.hide();
                        Helper.snackBar(context, message: 'Login berhasil!');
                        Navigator.pushReplacementNamed(context, PagePath.base);
                      } else if (state is AuthFailure) {
                        context.loaderOverlay.hide();
                        Helper.snackBar(context,
                            message: state.message, isError: true);
                      }
                    },
                    child: _loginContent(context),
                  ),
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ID', style: AppTheme.text3.white.bold),
              SizedBox(height: 8),
              TextFormField(
                controller: idController,
                style: AppTheme.text3.white,
                decoration: InputDecoration(
                  hintText: 'Masukan ID kamu',
                  errorStyle: AppTheme.text3.red,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukan input!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Password', style: AppTheme.text3.white.bold),
              SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                style: AppTheme.text3.white,
                obscureText: isObscure,
                decoration: InputDecoration(
                  hintText: 'Masukan password kamu',
                  errorStyle: AppTheme.text3.red,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                        isObscure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                        color: AppTheme.white),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukan input!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(Login(
                          id: idController.text,
                          password: passwordController.text,
                        ));
                  }
                },
                text: 'Masuk',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
