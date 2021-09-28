import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fojb_election/data/entities/entities.dart';
import 'package:fojb_election/logic/blocs/blocs.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class CountPage extends StatefulWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  _CountPageState createState() => _CountPageState();
}

class _CountPageState extends State<CountPage> {

  @override
  void initState() {
    context.read<CandidateBloc>().add(GetCandidates());
    context.read<CountBloc>().add(GetCounts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        automaticallyImplyLeading: false,
        title: Text('Quick Count', style: AppTheme.headline3.white),
      ),
      body: BlocBuilder<CandidateBloc, CandidateState>(
        buildWhen: (previous, current) => current is CandidateSuccess,
        builder: (context, candidateState) {
          return BlocBuilder<CountBloc, CountState>(
            builder: (context, countState) {
              if (candidateState is CandidateLoading || countState is CountLoading) {
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
              } else if (candidateState is CandidateEmpty || countState is CountEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text('Candidate Empty', style: AppTheme.headline3),
                  ),
                );
              } else if (candidateState is CandidateFailure || countState is CountFailure) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text('Candidate Failure', style: AppTheme.headline3),
                  ),
                );
              } else if (candidateState is CandidateSuccess &&
                  countState is CountSuccess) {
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
                        _candidateList(
                            context, countState.entity, candidateState.entity),
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
    );
  }

  Widget _chartBar(BuildContext context, CountEntity counts) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.darkGreen,
          gradient: LinearGradient(
            colors: [Colors.green.shade400, AppTheme.darkGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: Helper.getBigShadow(),
        ),
        padding: EdgeInsets.all(Helper.normalPadding),
        child: CountChart(countEntity: counts),
      ),
    );
  }

  Widget _candidateList(
      BuildContext context, CountEntity countEntity, CandidateEntity candidateEntity) {
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    Resources.imgDummy,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.16,
                  ),
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
                          color: AppTheme.green,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Center(
                          child: Text('Count: $countCandidate',
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
}


class CountChart extends StatelessWidget {
  final CountEntity countEntity;

  const CountChart({Key? key, required this.countEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups(countEntity),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: countEntity.total.toDouble() + (countEntity.total.toDouble() / 4),
      ),
      swapAnimationDuration: Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeInOutCubic,
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.y.round().toString(),
          TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => AppTheme.text2.whiteOpacity,
      margin: 30,
      getTitles: (double value) {
        switch (value.toInt()) {
          case 0:
            return '1';
          case 1:
            return '2';
          case 2:
            return '3';
          case 3:
            return '4';
          case 4:
            return '5';
          case 5:
            return '6';
          default:
            return '';
        }
      },
    ),
    leftTitles: SideTitles(showTitles: false),
    topTitles: SideTitles(showTitles: false),
    rightTitles: SideTitles(showTitles: false),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  List<BarChartGroupData> barGroups(CountEntity counts) => [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[0].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[1].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[2].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barsSpace: 10,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[3].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[4].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 5,
      barRods: [
        BarChartRodData(
          y: counts.countCandidates[5].toDouble(),
          colors: [
            AppTheme.darkBlue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
            AppTheme.blue,
          ],
        )
      ],
      showingTooltipIndicators: [0],
    ),
  ];
}
