import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/custom_button.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        leading: Expanded(
          child: Container(
            margin: EdgeInsets.only(left: Helper.normalPadding),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(Resources.back),
            ),
          ),
        ),
        title: Text('Detail Caketum', style: AppTheme.headline3.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Helper.normalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _headerDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerDetail(BuildContext context){
    return Container(
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: Helper.getShadow(),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    Resources.imgDummy,
                    fit: BoxFit.cover
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Helper.normalPadding),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Farah Fauziah Danopa',
                  style: AppTheme.headline3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Helper.smallPadding),
                Text(
                  'Kab. Majalengka',
                  style: AppTheme.text2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Helper.smallPadding),
                Text(
                  'SMA Negeri 1 Majalengka',
                  style: AppTheme.text2,
                ),
                SizedBox(height: Helper.normalPadding),
                CustomButton(onTap: () {}, text: 'Vote Farah'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
