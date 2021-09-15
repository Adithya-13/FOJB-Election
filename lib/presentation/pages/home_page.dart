import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerHome(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerHome(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Helper.normalPadding),
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(64)),
        color: AppTheme.green,
        boxShadow: Helper.getShadow(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Text('Halo, Adit!', style: AppTheme.headline1.white),
              ),
              Flexible(child: SvgPicture.asset(Resources.vote)),
            ],
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            'Ayo pilih Calon Ketua Umum Forum Osis Jawa Barat pilihanmu!',
            style: AppTheme.headline3.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
