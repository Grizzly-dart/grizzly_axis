import 'dart:html';
import 'dart:svg';

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:vizdom_select/vizdom_select.dart';

void axisBottom(
  Selection selection, {
  Scale scale,
  Iterable ticks,
  String axisColor = 'black',
  tickColor = 'black',
}) {
  ticks ??= scale.ticks().toList();

  final axisSel = selection
    ..select('.axis', init: SvgElement.tag('line'), doo: (axisSel) {
      final SvgElement el = axisSel.element;
      el
        ..setAttribute('x1', scale.range.first.toString())
        ..setAttribute('y1', '0')
        ..setAttribute('x2', scale.range.last.toString())
        ..setAttribute('y2', '0')
        ..setAttribute('stroke', axisColor);
    });

  final ticksSel = selection.bind('.tick', ticks)
    ..enter((_) => SvgElement.tag('g'))
    ..merge((ref) {
      Element el = ref.node;
      final pos = scale.scale(ref.data);
      el.setAttribute('transform', 'translate($pos, 0)');
      el.children.add(SvgElement.tag('line')
        ..setAttribute('x1', '0')
        ..setAttribute('y1', '0')
        ..setAttribute('x2', '0')
        ..setAttribute('y2', '6')
        ..style.setProperty('stroke', axisColor));
      final tickTextEl = SvgElement.tag('text')
        ..text = ref.data.toString()
        ..setAttribute('x', '0')
        ..setAttribute('y', '10')
        ..setAttribute("dominant-baseline", "text-before-edge")
        ..setAttribute("text-anchor", "middle")
        ..setAttribute('color', tickColor)
        ..setAttribute('font-size', '12px');
      /*
      if (ref.dataIndex == 0) {
        tickTextEl.setAttribute("text-anchor", "start");
      } else if (ref.dataIndex == ref.allData.length - 1) {
        tickTextEl.setAttribute("text-anchor", "end");
      } else {
        tickTextEl.setAttribute("text-anchor", "middle");
      }*/
      el.children.add(tickTextEl);
    });
}

void axisLeft(
  Selection selection, {
  Scale scale,
  Iterable ticks,
  String axisColor = 'black',
  tickColor = 'black',
}) {
  ticks ??= scale.ticks().toList();
  double tickSize = 6;

  final axisSel = selection
    ..select('.axis', init: SvgElement.tag('line'), doo: (axisSel) {
      final SvgElement el = axisSel.element;
      el
        ..setAttribute('x1', '0')
        ..setAttribute('y1', scale.range.first.toString())
        ..setAttribute('x2', '0')
        ..setAttribute('y2', scale.range.last.toString())
        ..setAttribute('stroke', axisColor);
    });

  final ticksSel = selection.bind('.tick', ticks)
    ..enter((_) => SvgElement.tag('g'))
    ..merge((ref) {
      Element el = ref.node;
      final pos = scale.scale(ref.data);
      el.setAttribute('transform', 'translate(-$tickSize, $pos)');
      el.children.add(SvgElement.tag('line')
        ..setAttribute('x1', '0')
        ..setAttribute('y1', '0')
        ..setAttribute('x2', tickSize.toString())
        ..setAttribute('y2', '0')
        ..style.setProperty('stroke', axisColor));
      final tickTextEl = SvgElement.tag('text')
        ..text = ref.data.toString()
        ..setAttribute('x', '-10')
        ..setAttribute('y', '0')
        ..setAttribute("text-anchor", "end")
        ..setAttribute("dominant-baseline", "central")
        ..setAttribute('color', tickColor)
        ..setAttribute('font-size', '12px');
      /*
      if (ref.dataIndex == 0) {
        tickTextEl.setAttribute("dominant-baseline", "text-before-edge");
      } else if (ref.dataIndex == ref.allData.length - 1) {
        tickTextEl.setAttribute("dominant-baseline", "text-after-edge");
      } else {
        tickTextEl.setAttribute("dominant-baseline", "central");
      }*/
      el.children.add(tickTextEl);
    });
}
