import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/custom_button.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GetStorage getStorage = GetStorage();
  late String id;

  @override
  void initState() {
    String id = getStorage.read(Keys.id);
    this.id = id;
    super.initState();
  }
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
      body: BlocListener<VoteBloc, VoteState>(
        listener: (context, state) {
          if (state is VoteCheck) {
            if (state.isUserCanVote) {
              Navigator.pushNamed(context, PagePath.vote);
            } else {
              Helper.snackBar(
                context,
                message:
                'Kamu telah vote, kamu tidak bisa vote lagi, suara kamu telah terdaftar, maaf ya!',
                isError: true,
              );
            }
          }
        },
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(Helper.normalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _headerDetail(context),
                _vision(context),
                _mission(context),
                _vote(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerDetail(BuildContext context) {
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
                  child: Image.asset(Resources.imgDummy, fit: BoxFit.cover),
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
                CustomButton(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => _announcementDialog(context),
                  ),
                  text: 'Vote Farah',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vision(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Text(
            'Visi',
            style: AppTheme.headline3,
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            style: AppTheme.text2,
          ),
        ],
      ),
    );
  }

  Widget _mission(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Text(
            'Misi',
            style: AppTheme.headline3,
          ),
          SizedBox(height: Helper.normalPadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: Helper.missions
                .map((e) => Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.black,
                            ),
                            height: 8,
                            width: 8,
                          ),
                          SizedBox(width: Helper.normalPadding),
                          Expanded(
                            child: Text(e, style: AppTheme.text2),
                          ),
                        ],
                      ),
                    ))
                .toList(),
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
            onTap: () => showDialog(
              context: context,
              builder: (context) => _announcementDialog(context),
            ),
            text: 'Vote Farah',
          ),
        ],
      ),
    );
  }

  Widget _announcementDialog(BuildContext context) {
    return CustomDialog(
      title: 'Perhatian',
      content: Text(
        'Pastikan apa yang kamu pilih adalah pilihanmu sendiri, tidak ada campur tangan orang lain dan sesuai dengan kata hati',
        style: AppTheme.text3,
      ),
      buttons: CustomButton(
        onTap: () {
          context.read<VoteBloc>().add(CheckCanVote(id: id));
          Navigator.pop(context);
        },
        text: 'Oke, mengerti',
      ),
    );
  }
}
