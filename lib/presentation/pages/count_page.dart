import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fojb_election/presentation/routes/routes.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class _BarChart extends StatelessWidget {
  const _BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
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
          margin: 20,
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

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              y: 8,
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
              y: 10,
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
              y: 11,
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
          barRods: [
            BarChartRodData(
              y: 15,
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
              y: 13,
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
              y: 10,
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

class CountPage extends StatelessWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.green,
        automaticallyImplyLeading: false,
        title: Text('Quick Count', style: AppTheme.headline3.white),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(Helper.normalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Helper.bigPadding),
              _chartBar(context),
              SizedBox(height: Helper.bigPadding),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                itemBuilder: (context, index) {
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
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.16,
                            ),
                          ),
                          SizedBox(width: Helper.smallPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Farah Fauziah Danopa',
                                  style: AppTheme.text1.bold,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Kab. Majalengka',
                                  style: AppTheme.text2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'SMA Negeri 1 Majalengka',
                                  style: AppTheme.text2,
                                ),
                                SizedBox(height: Helper.normalPadding),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppTheme.green,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  child: Center(
                                    child: Text('Count: 432',
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chartBar(BuildContext context) {
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
        child: _BarChart(),
      ),
    );
  }
}
