import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Example color definitions (replace these with your actual colors)
class AppColors {
  static const backgroundColor = Color(0xFFE0FBFC);
  static const secondaryColor = Color(0xFF90E0EF);
  static const primaryColor   = Color(0xFF00B4D8);
  static const darkBlue       = Color(0xFF03045E);
  static const goodBorder     = Color(0xFF0096C7);
}

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String selectedTimeframe = 'Past Week';
  bool showAverage = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Header Section (Title + Dropdown)**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overall',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  _buildDropdown(),
                ],
              ),

              const SizedBox(height: 12),

              /// **Main Summary Card with Chart**
              _buildSummaryCard(),

              const SizedBox(height: 16),

              /// **Timeframe Selector** (now using Expanded to avoid overflow)
              _buildTimeframeSelector(),
            ],
          ),
        ),
      ),
    );
  }

  /// **Dropdown for Time Selection**
  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedTimeframe,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        underline: const SizedBox(),
        dropdownColor: AppColors.secondaryColor,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        onChanged: (String? newValue) {
          setState(() {
            selectedTimeframe = newValue!;
          });
        },
        items: <String>['Past Week', '1 Month', '3 Months', '1 Year']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  /// **Summary Card with Line Chart**
  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      height: 385,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Overall Percentage**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '+10%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.goodBorder,
                ),
              ),
              _toggleAverageButton(),
            ],
          ),

          /// **Animated Line Chart**
          Expanded(
            child: LineChart(
              showAverage ? _averageData() : _mainData(),
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ],
      ),
    );
  }

  /// **Toggle Button for Chart (Avg Mode)**
  Widget _toggleAverageButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          showAverage = !showAverage;
        });
      },
      child: Text(
        'Avg',
        style: TextStyle(
          fontSize: 14,
          // If showAverage is true, dim the color a bit
          color: showAverage ? Colors.white.withOpacity(0.5) : Colors.white,
        ),
      ),
    );
  }

  /// **Timeframe Selection Bar** (using Expanded in each button to avoid overflow)
  Widget _buildTimeframeSelector() {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTimeframeButton('Past Week'),
          _buildTimeframeButton('1 Month'),
          _buildTimeframeButton('3 Months'),
          _buildTimeframeButton('1 Year'),
        ],
      ),
    );
  }

  /// **Timeframe Button** (now uses Expanded)
  Widget _buildTimeframeButton(String label) {
    bool isSelected = selectedTimeframe == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTimeframe = label;
          });
        },
        child: Container(
          // Removed width to allow flexible sizing
          height: 27,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkBlue : AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.darkBlue,
            ),
          ),
        ),
      ),
    );
  }

  /// **X-Axis Label Builder** (13 Mon, 15 Wed, 19 Sun)
  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    switch (value.toInt()) {
      case 13:
        return Text('13 Mon', style: style);
      case 15:
        return Text('15 Wed', style: style);
      case 19:
        return Text('19 Sun', style: style);
    }
    return const SizedBox();
  }

  /// **Main Line Chart Data** (mimicking "Past Week" with daily spots)
  LineChartData _mainData() {
    return LineChartData(
      minX: 13,
      maxX: 19,
      minY: 0,
      maxY: 100,
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) {
          // Light horizontal lines
          return const FlLine(color: Colors.grey, strokeWidth: 0.5);
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (double value, TitleMeta meta) {
              return Text(
                '${value.toInt()}%',
                style: const TextStyle(fontSize: 12),
              );
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: _bottomTitleWidgets,
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          // Data points from x=13 to x=19
          spots: const [
            FlSpot(13, 20),
            FlSpot(14, 30),
            FlSpot(15, 40),
            FlSpot(16, 45),
            FlSpot(17, 50),
            FlSpot(18, 60),
            FlSpot(19, 70),
          ],
          isCurved: true,
          color: AppColors.goodBorder,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
      ],
    );
  }

  /// **Average Data** (same as mainData, adjust if you want a different "Avg" line)
  LineChartData _averageData() {
    return _mainData();
  }
}