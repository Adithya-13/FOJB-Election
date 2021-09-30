import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:fojb_election/data/exceptions/api_exception.dart';
import 'package:fojb_election/data/providers/remotes/remotes.dart';
import 'package:fojb_election/logic/blocs/auth/auth_bloc.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/logic/blocs/count/count_bloc.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';

import 'data/repositories/repositories.dart';

void main() async {
  await GetStorage.init();
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final DatabaseReference _ref = FirebaseDatabase.instance.reference();
  final GetStorage _getStorage = GetStorage();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FojbRepository(
            userDataSource: UserDataSource(ref: _ref),
            voteDataSource: VoteDataSource(ref: _ref),
            countDataSource: CountDataSource(ref: _ref),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              fojbRepository: context.read<FojbRepository>(),
              getStorage: _getStorage,
            ),
          ),
          BlocProvider<HomeVote>(
            create: (context) => VoteBloc(
              fojbRepository: context.read<FojbRepository>(),
            ),
          ),
          BlocProvider<DetailVote>(
            create: (context) => VoteBloc(
              fojbRepository: context.read<FojbRepository>(),
            ),
          ),
          BlocProvider<VotingVote>(
            create: (context) => VoteBloc(
              fojbRepository: context.read<FojbRepository>(),
            ),
          ),
          BlocProvider<CandidateBloc>(
            create: (context) => CandidateBloc(
              fojbRepository: context.read<FojbRepository>(),
            ),
          ),
          BlocProvider<CountBloc>(
            create: (context) => CountBloc(
              fojbRepository: context.read<FojbRepository>(),
            ),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: !Platform.isIOS ? 'Gotham' : null,
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
