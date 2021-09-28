import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/custom_button.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';

class DetailPage extends StatefulWidget {
  final ArgumentBundle? bundle;

  const DetailPage({Key? key, required this.bundle}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GetStorage getStorage = GetStorage();
  late int index;
  late String id;

  @override
  void initState() {
    if (widget.bundle != null) {
      index = widget.bundle!.id;
    }
    context.read<CandidateBloc>().add(GetCandidateByIndex(id: index));
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
        child: BlocBuilder<CandidateBloc, CandidateState>(
          buildWhen: (previous, current) => current is CandidateByIndexSuccess,
          builder: (context, state) {
            if (state is CandidateLoading) {
              Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.darkBlue,
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.blue),
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
                  child: Text('Candidate Failure', style: AppTheme.headline3),
                ),
              );
            } else if(state is CandidateByIndexSuccess){
              final candidate = state.entity;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(Helper.normalPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _headerDetail(context, candidate),
                      _description(context, candidate),
                      _vision(context, candidate),
                      _mission(context, candidate),
                      _vote(context, candidate),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _headerDetail(BuildContext context, CandidateItemEntity candidate) {
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
                  candidate.name,
                  style: AppTheme.headline3,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Helper.smallPadding),
                Text(
                  candidate.school,
                  style: AppTheme.text2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Helper.smallPadding),
                Text(
                  candidate.origin,
                  style: AppTheme.text2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: Helper.normalPadding),
                CustomButton(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => _announcementDialog(context),
                  ),
                  text: 'Vote ${candidate.name.firstWord}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, CandidateItemEntity candidate) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Text(
            'Deskripsi',
            style: AppTheme.headline3,
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            candidate.description,
            style: AppTheme.text2.increaseHeight,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _vision(BuildContext context, CandidateItemEntity candidate) {
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
            candidate.vision,
            style: AppTheme.text2.increaseHeight,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _mission(BuildContext context, CandidateItemEntity candidate) {
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
            children: candidate.mission
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

  Widget _vote(BuildContext context, CandidateItemEntity candidate) {
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
            text: 'Vote ${candidate.name.firstWord}',
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
        textAlign: TextAlign.center,
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
