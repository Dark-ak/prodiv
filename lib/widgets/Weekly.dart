import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "../db/db.dart";
import "../db/model.dart";

class Weekly extends StatefulWidget {
  const Weekly({super.key});

  @override
  State<Weekly> createState() => _WeeklyState();
}

class _WeeklyState extends State<Weekly> {
  final db = DbService();

  Future<List<DataModel>> getData() async {
    List<DataModel> data = await db.get();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SfCartesianChart(
              primaryXAxis: const CategoryAxis(
                  maximumLabels: 4,
                  // edgeLabelPlacement: EdgeLabelPlacement.shift,
                  labelStyle: TextStyle(color: Colors.orange),
                  labelAlignment: LabelAlignment.center),
              primaryYAxis: const NumericAxis(
                labelStyle: TextStyle(color: Colors.orange),
              ),
              series: <CartesianSeries>[
                LineSeries<DataModel, String>(
                  dataSource: snapshot.data,
                  markerSettings: const MarkerSettings(color: Colors.red),
                  enableTooltip: true,
                  // Dash values for line
                  // dashArray: <double>[5, 5],
                  xValueMapper: (DataModel data, _) {
                    String date = data.date;
                    List<String> parts = date.split("-");
                    String formatted = '${parts[1]}-${parts[2]}';
                    return formatted;
                  },
                  yValueMapper: (DataModel data, _) => data.hours,
                  // dataLabelSettings: DataLabelSettings(isVisible: true),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
