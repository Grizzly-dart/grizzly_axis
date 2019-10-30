import 'dart:html';
import 'dart:svg';

import 'package:grizzly_axis/grizzly_axis.dart';
import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:vizdom_select/selection/selection.dart';

void main() {
  final chartElement = select('#chart1');

  final xScale = LinearScale([0, 1000], [0, 400]);

  final xaxis = chartElement.select('.xaxis', init: SvgElement.tag('g'));
  axisBottom(xaxis, scale: xScale);
}
