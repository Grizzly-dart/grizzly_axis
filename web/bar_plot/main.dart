import 'dart:html';
import 'dart:svg';

import 'package:grizzly_io/grizzly_io.dart';
import 'package:grizzly_axis/grizzly_axis.dart';
import 'package:grizzly_range/grizzly_range.dart';
import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:grizzly_stat/grizzly_stat.dart';
import 'package:vizdom_select/selection/selection.dart';

final data = """2013-01,53
2013-02,165
2013-03,269
2013-04,344
2013-05,376
2013-06,410
2013-07,421
2013-08,405
2013-09,376
2013-10,359
2013-11,392
2013-12,433
2014-01,455
2014-02,478""";

void main() {
  final chartElement = select('#chart1');

  final parsedData = Table.from(parseCsv(data));

  final x = parsedData.column<String>(0);
  final y = parsedData.columnAsInt(1);

  final xScale = BandScale(x, [0, 950], padding: 0.05);
  final yScale = LinearScale([0, max(y)], [300, 0]);

  chartElement.select('.xaxis', init: SvgElement.tag('g')..classes.add('xaxis'),
      doo: (xAxis) {
    final SvgElement xAxisEl = xAxis.element;
    xAxisEl.setAttribute('transform', 'translate(50, 300)');
    axisBottom(xAxis, scale: xScale);
  });

  chartElement.select('.yaxis', init: SvgElement.tag('g')..classes.add('yaxis'),
      doo: (yAxis) {
    final SvgElement yAxisEl = yAxis.element;
    yAxisEl.setAttribute('transform', 'translate(50, 0)');
    axisLeft(yAxis, scale: yScale);
  });

  chartElement.select('.plot1', init: SvgElement.tag('g')..classes.add('plot1'),
      doo: (plot1) {
    plot1.element.setAttribute('transform', 'translate(50, 0)');

    final rect = indices(x.length).map((i) {
      final d = x.elementAt(i);
      final r = y.elementAt(i);

      final pX = xScale.bound(d);
      final pY = yScale.range.first;
      final width = xScale.size;
      final height = yScale.scale(r) - yScale.range.first;

      return Rect(pX, pY, width, height);
    }).toList();

    plot1.bind('.bar', rect)
      ..enter((d) => SvgElement.tag('rect')..classes.add('bar'))
      ..merge((ref) {
        final SvgElement line = ref.node;
        line
          ..setAttribute('stroke', 'black')
          ..setAttribute('x', ref.data.x.toString())
          ..setAttribute('y', ref.data.y.toString())
          ..setAttribute('width', ref.data.width.toString())
          ..setAttribute('height', ref.data.height.toString())
          ..setAttribute('fill', 'steelblue');
      });
  });
}

class Rect {
  final num x;

  final num y;

  final num width;

  final num height;

  Rect._(this.x, this.y, this.width, this.height);

  factory Rect(num x, num y, num width, num height) {
    if (width.isNegative) {
      width = -width;
      x -= width;
    }
    if (height.isNegative) {
      height = -height;
      y -= height;
    }

    return Rect._(x, y, width, height);
  }
}
