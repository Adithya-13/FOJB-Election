import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VotePage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const VotePage({Key? key, required this.bundle}) : super(key: key);

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
    if (widget.bundle != null) {
      vote = widget.bundle!.id;
    }
    context.read<CandidateBloc>().add(GetCandidates());
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
        body: SafeArea(
          child: BlocListener<VotingVote, VoteState>(
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
              }
            },
            child: BlocBuilder<CandidateBloc, CandidateState>(
              buildWhen: (previous, current) => current is CandidateSuccess,
              builder: (context, state) {
                if (state is CandidateLoading) {
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.darkBlue,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppTheme.blue),
                        strokeWidth: 6,
                      ),
                    ),
                  );
                } else if (state is CandidateEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text('Candidate Empty', style: AppTheme.headline3),
                    ),
                  );
                } else if (state is CandidateFailure) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child:
                          Text('Candidate Failure', style: AppTheme.headline3),
                    ),
                  );
                } else if (state is CandidateSuccess) {
                  final candidateEntity = state.entity;
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.all(Helper.normalPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _gridListCandidate(context, candidateEntity),
                          _vote(context, candidateEntity),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _gridListCandidate(
      BuildContext context, CandidateEntity candidateEntity) {
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
            itemCount: candidateEntity.candidates.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 7 / 10,
              crossAxisSpacing: Helper.normalPadding,
              mainAxisSpacing: Helper.normalPadding,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final candidate = candidateEntity.candidates[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    vote = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: vote == index ? AppTheme.lightGreen : AppTheme.white,
                    boxShadow: vote == index ? null : Helper.getShadow(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(Helper.smallPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: CustomNetworkImage(
                          imgUrl: candidate.img,
                          borderRadius: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        candidate.name,
                        style: AppTheme.text1.bold,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        candidate.origin,
                        style: AppTheme.subText1,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _vote(BuildContext context, CandidateEntity candidateEntity) {
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
                builder: (context) => _confirmationDialog(
                    context, candidateEntity.candidates[vote!]),
              );
            },
            isEnable: vote != null,
            text: vote != null ? 'Vote ${Dummy.shortName[vote!]}' : 'Vote',
          ),
        ],
      ),
    );
  }

  Widget _confirmationDialog(
      BuildContext context, CandidateItemEntity candidate) {
    return CustomDialog(
      title: 'Konfirmasi',
      content: Text(
        'Anda yakin memilih ${candidate.name} dari ${candidate.origin}?',
        style: AppTheme.text3,
      ),
      buttons: CustomButton(
        onTap: () {
          if (vote == null) {
            Helper.snackBar(context, message: 'Kamu harus memilih Calon!');
            return;
          }
          Navigator.pop(context);
          context.read<VotingVote>().add(
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
