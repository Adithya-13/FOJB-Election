import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  int? vote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        leading: Container(
          margin: EdgeInsets.only(left: Helper.normalPadding),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(Resources.back),
          ),
        ),
        title: Text('Detail Caketum', style: AppTheme.headline3.white),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(Helper.normalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _gridListCandidate(context),
              _vote(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridListCandidate(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Pilih Calon Ketua Umum',
            style: AppTheme.headline3,
          ),
          SizedBox(height: Helper.normalPadding),
          GridView.builder(
            itemCount: 6,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 7 / 10,
              crossAxisSpacing: Helper.normalPadding,
              mainAxisSpacing: Helper.normalPadding,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  vote = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: vote == index ? AppTheme.lightGreen : AppTheme.white,
                  boxShadow: Helper.getShadow(),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.all(Helper.smallPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          Resources.imgDummy,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Farah Fauziah Danopa',
                      style: AppTheme.text1.bold,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Kab. Majalengka',
                      style: AppTheme.subText1,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _vote(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Helper.normalPadding),
          CustomButton(
            onTap: () {
              if(vote == null){
                Helper.snackBar(context, message: 'Kamu harus memilih Calon!');
                return;
              }
              showDialog(
                context: context,
                builder: (context) => _confirmationDialog(context),
              );
            },
            text: 'Vote Farah',
          ),
        ],
      ),
    );
  }

  Widget _confirmationDialog(BuildContext context) {
    return CustomDialog(
      title: 'Konfirmasi',
      content: Text(
        'Anda yakin memilih Farah Fauziah Danopa dari Kab. Majalengka?',
        style: AppTheme.text3,
      ),
      buttons: CustomButton(
        onTap: () {
          if (vote == null) {
            Helper.snackBar(context, message: 'Kamu harus memilih Calon!');
            return;
          }
          Navigator.pop(context);
          Navigator.pushNamed(context, PagePath.afterVote);
        },
        text: 'Yap, saya yakin',
      ),
    );
  }
}
