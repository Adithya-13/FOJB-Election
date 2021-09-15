import 'package:fojb_election/data/exceptions/api_exception.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';


void main() async {
  await GetStorage.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final PageRouter _router;

  MyApp() : _router = PageRouter() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOJB Election',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: AppTheme.scaffold,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: AppTheme.enabledBorder,
          focusedBorder: AppTheme.focusedBorder,
          errorBorder: AppTheme.errorBorder,
          focusedErrorBorder: AppTheme.focusedErrorBorder,
          isDense: true,
          hintStyle: AppTheme.text3.whiteOpacity,
        ),
      ),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      String m = e is APIException ? e.message : e.toString();
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${m != 'null' ? m : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
