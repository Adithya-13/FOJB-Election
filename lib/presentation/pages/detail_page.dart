import 'package:flutter/cupertino.dart';
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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    if (widget.bundle != null) {
      index = widget.bundle!.id;
    }
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'IfE3j-i9PV8', //Add videoID.
      flags: YoutubePlayerFlags(
        hideControls: false,
        controlsVisibleAtStart: false,
        autoPlay: true,
        mute: false,
        loop: true,
        hideThumbnail: true,
      ),
    );
    context.read<CandidateBloc>().add(GetCandidateByIndex(id: index));
    String id = getStorage.read(Keys.id);
    this.id = id;
    super.initState();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
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
      body: SafeArea(
        child: BlocListener<DetailVote, VoteState>(
          listener: (blocContext, state) {
            if (state is VoteCheck) {
              if (state.isUserCanVote) {
                _youtubeController.pause();
                Navigator.pushNamed(context, PagePath.vote,
                    arguments: ArgumentBundle(id: index));
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
            buildWhen: (previous, current) =>
                current is CandidateByIndexSuccess,
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
              } else if (state is CandidateByIndexSuccess) {
                final candidate = state.entity;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(Helper.normalPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _youtubeVideo(context, candidate),
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
      ),
    );
  }

  Widget _youtubeVideo(BuildContext context, CandidateItemEntity candidate) {
    return Container(
      margin: EdgeInsets.only(bottom: Helper.normalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: Helper.getShadow(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: _youtubeController,
          bottomActions: [
            const SizedBox(width: 14.0),
            CurrentPosition(),
            const SizedBox(width: 8.0),
            ProgressBar(
              isExpanded: true,
            ),
            RemainingDuration(),
            const PlaybackSpeedButton(),
          ],
          onReady: () {
            _youtubeController.load(candidate.urlVideo);
          },
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppTheme.green,
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
                child: CustomNetworkImage(
                  imgUrl: candidate.img,
                  borderRadius: 20,
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
                  text: 'Vote ${Dummy.shortName[index]}',
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
                .asMap()
                .map((index, value) => MapEntry(
                      index,
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((index + 1).toString() + '.',
                                style: AppTheme.text2),
                            SizedBox(width: Helper.normalPadding),
                            Expanded(
                              child: Text(value, style: AppTheme.text2.increaseHeight),
                            ),
                          ],
                        ),
                      ),
                    ))
                .values
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
            text: 'Vote ${Dummy.shortName[index]}',
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
          context.read<DetailVote>().add(CheckCanVote(id: id));
          Navigator.pop(context);
        },
        text: 'Oke, mengerti',
      ),
    );
  }
}
