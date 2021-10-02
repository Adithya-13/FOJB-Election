import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';
import 'package:fojb_election/presentation/widgets/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    _refresh();
    super.initState();
  }

  void _refresh() {
    context.read<CandidateBloc>().add(GetCandidates());
    context.read<CountBloc>().add(GetCounts());
  }

  void _stopRefresh() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _refreshController.refreshCompleted();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        automaticallyImplyLeading: false,
        title: Text('Quick Count', style: AppTheme.headline3.white),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _refresh,
        child: BlocBuilder<CandidateBloc, CandidateState>(
          buildWhen: (previous, current) => current is CandidateSuccess,
          builder: (context, candidateState) {
            return BlocBuilder<CountBloc, CountState>(
              builder: (context, countState) {
                if (candidateState is CandidateLoading ||
                    countState is CountLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.darkBlue,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.blue),
                      strokeWidth: 6,
                    ),
                  );
                } else if (candidateState is CandidateEmpty ||
                    countState is CountEmpty) {
                  _stopRefresh();
                  return Center(
                    child:
                        Text('Count Empty', style: AppTheme.headline3),
                  );
                } else if (candidateState is CandidateFailure ||
                    countState is CountFailure) {
                  _stopRefresh();
                  return Center(
                    child: Text('Count Failure',
                        style: AppTheme.headline3),
                  );
                } else if (candidateState is CandidateSuccess &&
                    countState is CountSuccess) {
                  _stopRefresh();
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.all(Helper.normalPadding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: Helper.bigPadding),
                          _chartBar(context, countState.entity),
                          SizedBox(height: Helper.bigPadding),
                          _candidateList(context, countState.entity,
                              candidateState.entity),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }

  Widget _chartBar(BuildContext context, CountEntity counts) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.white,
        boxShadow: Helper.getShadow(),
      ),
      padding: EdgeInsets.all(Helper.normalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    sections: showingSections(counts)),
              ),
            ),
          ),
          SizedBox(width: 32),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                6,
                (index) => Indicator(
                    color: Dummy.colors[index],
                    text: Dummy.shortName[index])).toList(),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  Widget _candidateList(BuildContext context, CountEntity countEntity,
      CandidateEntity candidateEntity) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: candidateEntity.candidates.length,
      itemBuilder: (context, index) {
        final candidate = candidateEntity.candidates[index];
        final countCandidate = countEntity.countCandidates[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, PagePath.detail),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white,
              boxShadow: Helper.getShadow(),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(Helper.smallPadding),
            child: Row(
              children: [
                CustomNetworkImage(
                  imgUrl: candidate.img,
                  height: MediaQuery.of(context).size.height * 0.16,
                  borderRadius: 20,
                ),
                SizedBox(width: Helper.smallPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        candidate.name,
                        style: AppTheme.text1.bold,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        candidate.school,
                        style: AppTheme.text2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        candidate.origin,
                        style: AppTheme.text2,
                      ),
                      SizedBox(height: Helper.normalPadding),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Dummy.colors[index],
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Center(
                          child: Text('Count: $countCandidate%',
                              style: AppTheme.text1.bold.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections(CountEntity counts) {
    return List.generate(6, (i) {
      final radius = 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Dummy.colors[0],
            value: counts.countCandidates[0].toDouble(),
            title: '${counts.countCandidates[0]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        case 1:
          return PieChartSectionData(
            color: Dummy.colors[1],
            value: counts.countCandidates[1].toDouble(),
            title: '${counts.countCandidates[1]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        case 2:
          return PieChartSectionData(
            color: Dummy.colors[2],
            value: counts.countCandidates[2].toDouble(),
            title: '${counts.countCandidates[2]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        case 3:
          return PieChartSectionData(
            color: Dummy.colors[3],
            value: counts.countCandidates[3].toDouble(),
            title: '${counts.countCandidates[3]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        case 4:
          return PieChartSectionData(
            color: Dummy.colors[4],
            value: counts.countCandidates[4].toDouble(),
            title: '${counts.countCandidates[4]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        case 5:
          return PieChartSectionData(
            color: Dummy.colors[5],
            value: counts.countCandidates[5].toDouble(),
            title: '${counts.countCandidates[5]}%',
            radius: radius,
            titleStyle: AppTheme.text1.white,
          );
        default:
          throw Error();
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.isSquare: false,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: AppTheme.text1.bold,
          )
        ],
      ),
    );
  }
}
