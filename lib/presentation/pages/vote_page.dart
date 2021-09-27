import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  int? vote;
  final GetStorage getStorage = GetStorage();
  late String name;
  late String id;

  @override
  void initState() {
    String name = getStorage.read(Keys.name);
    String id = getStorage.read(Keys.id);
    this.name = name;
    this.id = id;
    super.initState();
  }

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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.green,
          leading: Container(
            margin: EdgeInsets.only(left: Helper.normalPadding),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(Resources.back),
            ),
          ),
          title: Text('Vote Caketum', style: AppTheme.headline3.white),
        ),
        body: BlocListener<VoteBloc, VoteState>(
          listener: (context, state) {
            if (state is VoteLoading) {
              context.loaderOverlay.show();
              Helper.snackBar(context, message: 'Voting...');
            } else if (state is VoteSuccess) {
              context.loaderOverlay.hide();
              Helper.snackBar(context, message: 'Vote Berhasil!');
              Navigator.pushNamed(context, PagePath.afterVote);
            } else if (state is VoteFailure) {
              context.loaderOverlay.hide();
              Helper.snackBar(context, message: state.message);
            } else if (state is VoteCheck) {
              context.loaderOverlay.hide();
              if (!state.isUserCanVote) {
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
                  _gridListCandidate(context),
                  _vote(context),
                ],
              ),
            ),
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
              if (vote == null) {
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
          context.read<VoteBloc>().add(
                PostVote(
                  position: vote! + 1,
                  id: id,
                  name: name,
                ),
              );
        },
        text: 'Yap, saya yakin',
      ),
    );
  }
}
