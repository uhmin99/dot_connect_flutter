import 'package:dot_connect_flutter/ui/constants/fixed_data.dart';
import 'package:dot_connect_flutter/ui/pages/translate_cam_page/translate_cam_vm.dart';
import 'package:dot_connect_flutter/ui/widgets/black_btn.dart';
import 'package:dot_connect_flutter/utils/route/route_util.dart';
import 'package:flutter/material.dart';

import '../../../core/tflite/recognition.dart';
import '../../../core/tflite/stats.dart';
import 'box_widget.dart';
import 'camera_view.dart';
import 'camera_view_singleton.dart';

class TranslateCamPage extends StatefulWidget {
  const TranslateCamPage({Key? key}) : super(key: key);

  @override
  State<TranslateCamPage> createState() => _TranslateCamPageState();
}

class _TranslateCamPageState extends State<TranslateCamPage> {

  /// Results to draw bounding boxes
  List<Recognition>? results;

  /// Realtime stats
  Stats? stats;

  @override
  Widget build(BuildContext context) {
    var vm = TranslateCamViewModel();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback, statsCallback),

          // Bounding boxes
          boundingBoxes(results),

          // Heading
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24,),
                  IconButton(
                    padding: EdgeInsets.only(bottom: pageHozPadding),
                    onPressed: () {
                      RouteUtil().pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                  ),
                  SizedBox(height: 40,),
                  Row(
                    children: const [
                      SizedBox(width: pageHozPadding,),
                      Text(
                        'Translate',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Bottom Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 40),
              child: BlackBtn(
                text: "translate",
                tapAction: () {
                  vm.translate(context, "braille");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    setState(() {
      this.results = results;
    });
  }

  /// Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() {
      this.stats = stats;
    });
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  StatsRow(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}