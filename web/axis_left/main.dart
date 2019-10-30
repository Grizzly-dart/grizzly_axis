import 'dart:html';
import 'dart:svg';

import 'package:grizzly_axis/grizzly_axis.dart';
import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:vizdom_select/selection/selection.dart';

void main() {
  final chartElement = select('#chart1');

  final yScale = LinearScale([1000, 0], [0, 400]);

  chartElement.select('.yaxis', init: SvgElement.tag('g'), doo: (yaxis) {
    final SvgElement yAxisEl = yaxis.element;
    yAxisEl.setAttribute('transform', 'translate(50, 0)');
    axisLeft(yaxis, scale: yScale);
  });
}
