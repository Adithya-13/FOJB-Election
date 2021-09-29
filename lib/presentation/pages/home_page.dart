import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/argument_bundle.dart';
import 'package:fojb_election/presentation/routes/page_path.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/custom_button.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetStorage getStorage = GetStorage();
  late String name;
  late String fullName;
  late String id;

  @override
  void initState() {
    context.read<CandidateBloc>().add(GetCandidates());
    String fullName = getStorage.read(Keys.name);
    String id = getStorage.read(Keys.id);
    name = fullName.toLowerCase().capitalizeFirstTofEach;
    this.fullName = name;
    this.id = id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeVote, VoteState>(
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
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _headerHome(context),
                _candidate(context),
                _voteNow(context),
              ],
            ),
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
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Halo, $name',
                    style: AppTheme.headline1.white,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
                SizedBox(width: Helper.smallPadding),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      context.read<AuthBloc>().add(Logout());
                    },
                    child: SvgPicture.asset(Resources.vote),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                'Ayo pilih Calon Ketua Umum Forum Osis Jawa Barat pilihanmu!',
                style: AppTheme.headline3.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _candidate(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
            child: Text(
              'Calon Ketua Umum',
              style: AppTheme.headline3,
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(height: Helper.normalPadding),
          BlocBuilder<CandidateBloc, CandidateState>(
            buildWhen: (previous, current) => current is CandidateSuccess,
            builder: (context, state) {
              if (state is CandidateLoading) {
                Container(
                  height: MediaQuery.of(context).size.height * 0.36,
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
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Center(
                    child: Text('Candidate Empty', style: AppTheme.headline3),
                  ),
                );
              } else if (state is CandidateFailure) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Center(
                    child: Text('Candidate Failure', style: AppTheme.headline3),
                  ),
                );
              } else if (state is CandidateSuccess) {
                final candidates = state.entity.candidates;
                return Container(
                  height: MediaQuery.of(context).size.height * 0.36,
                  alignment: Alignment.topRight,
                  child: ListView.builder(
                    itemCount: candidates.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final candidate = candidates[index];
                      return _candidateItem(context, index, candidate);
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          SizedBox(height: Helper.normalPadding),
        ],
      ),
    );
  }

  Widget _candidateItem(
      BuildContext context, int index, CandidateItemEntity candidate) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        PagePath.detail,
        arguments: ArgumentBundle(id: index),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: Helper.getShadow(),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(Helper.smallPadding),
        margin: index == 0
            ? EdgeInsets.only(left: Helper.normalPadding, right: 8, bottom: 8)
            : index == 5
                ? EdgeInsets.only(
                    left: 8, right: Helper.normalPadding, bottom: 8)
                : EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: AspectRatio(
          aspectRatio: 6.4 / 10,
          child: Column(
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 16),
              Text(
                'Lihat Visi Misi',
                style: AppTheme.subText1.blue,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _voteNow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Helper.normalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: Helper.normalPadding),
          Text(
            'Vote Sekarang!',
            style: AppTheme.headline3,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Helper.normalPadding),
          Text(
            'Setelah kamu lihat-lihat visi dan misi Calon Ketua Umum Forum Osis Jawa Barat, yuk Vote sekarang, ingat! Pilih lah sesuai kata hati, bukan kata orang!',
            style: AppTheme.text2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Helper.normalPadding),
          CustomButton(
              onTap: () => showDialog(
                    context: context,
                    builder: (context) => _announcementDialog(context),
                  ),
              text: 'Vote'),
          SizedBox(height: Helper.normalPadding),
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
          context.read<HomeVote>().add(CheckCanVote(id: id));
          Navigator.pop(context);
        },
        text: 'Oke, mengerti',
      ),
    );
  }
}
