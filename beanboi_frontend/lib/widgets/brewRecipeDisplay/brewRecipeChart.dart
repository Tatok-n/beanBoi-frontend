import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BrewRecipeChart extends StatefulWidget {
  final double ratio;
  final double temperature;
  final double duration;
  final int numStages;
  final bool isEspresso;

  const BrewRecipeChart({
    Key? key,
    required this.ratio,
    required this.temperature,
    required this.duration,
    required this.numStages,
    required this.isEspresso,
  }) : super(key: key);

  @override
  _BrewRecipeChartState createState() => _BrewRecipeChartState();
}

class _BrewRecipeChartState extends State<BrewRecipeChart> {
  int _selectedChartIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chart selector
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(
                value: 0,
                label: Text('Brewing Profile'),
                icon: Icon(Icons.timeline),
              ),
              ButtonSegment(
                value: 1,
                label: Text('Parameters'),
                icon: Icon(Icons.pie_chart),
              ),
              ButtonSegment(
                value: 2,
                label: Text('Stages'),
                icon: Icon(Icons.bar_chart),
              ),
            ],
            selected: {_selectedChartIndex},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                _selectedChartIndex = newSelection.first;
              });
            },
          ),
        ),
        
        // Chart display
        SizedBox(
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSelectedChart(),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedChart() {
    switch (_selectedChartIndex) {
      case 0:
        return _buildBrewingProfileChart();
      case 1:
        return _buildParametersChart();
      case 2:
        return _buildStagesChart();
      default:
        return _buildBrewingProfileChart();
    }
  }

  Widget _buildBrewingProfileChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 20,
          verticalInterval: widget.duration / 10,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Colors.grey,
              strokeWidth: 0.5,
            );
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(
              color: Colors.grey,
              strokeWidth: 0.5,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: widget.duration / 5,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    '${value.toInt()}s',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    '${value.toInt()}°C',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              reservedSize: 50,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        minX: 0,
        maxX: widget.duration,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: _generateBrewingProfileSpots(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.8),
                Colors.blue.withOpacity(0.3),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.blue.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _generateBrewingProfileSpots() {
    List<FlSpot> spots = [];
    double stageTime = widget.duration / widget.numStages;
    
    for (int i = 0; i <= widget.numStages; i++) {
      double x = i * stageTime;
      double y = widget.temperature;
      
      // Add variation for different stages
      if (i > 0) {
        y = widget.temperature - (i * 2.0); // Slight temperature drop over time
      }
      
      spots.add(FlSpot(x, y));
    }
    
    return spots;
  }

  Widget _buildParametersChart() {
    return PieChart(
      PieChartData(
        sections: _generateParametersSections(),
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            // Handle touch events if needed
          },
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateParametersSections() {
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: widget.ratio * 10,
        title: 'Ratio\n${widget.ratio.toStringAsFixed(1)}',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: widget.temperature,
        title: 'Temp\n${widget.temperature.toStringAsFixed(1)}°C',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: widget.duration,
        title: 'Duration\n${widget.duration.toStringAsFixed(1)}s',
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildStagesChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Stage ${group.x + 1}\n${rod.toY.toStringAsFixed(1)}%',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    'Stage ${value.toInt() + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    '${value.toInt()}%',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d)),
        ),
        barGroups: _generateStagesBarGroups(),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  List<BarChartGroupData> _generateStagesBarGroups() {
    List<BarChartGroupData> groups = [];
    
    for (int i = 0; i < widget.numStages; i++) {
      // Calculate intensity for each stage (simulated brewing intensity)
      double intensity = 100 - (i * 10); // Decreasing intensity over stages
      if (intensity < 20) intensity = 20; // Minimum intensity
      
      groups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: intensity,
              color: Colors.blue.withOpacity(0.8),
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    
    return groups;
  }
}