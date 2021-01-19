import 'dart:html';
import 'dart:svg';

import 'package:grizzly_scales/grizzly_scales.dart';
import 'package:vizdom_select/vizdom_select.dart';

void hGrid<T>(
  Selection selection, {
  Scale<T, num> scale,
  Scale<T, num> otherScale,
  Iterable<T> ticks,
  String color = 'black',
}) {
  ticks ??= scale.ticks().toList();

  selection.bind<T>('.line', ticks)
    ..enter((ref) {
      return SvgElement.tag('line')..classes.add('line');
    })
    ..merge((ref) {
      ref.element
        ..setAttribute('x1', null)
        ..setAttribute('y1', null)
        ..setAttribute('x2', null)
        ..setAttribute('y2', null)
        ..setAttribute('stroke', color);
    });
  // TODO
}

void vGrid(
  Selection selection, {
  Scale scale,
  Iterable ticks,
  String axisColor = 'black',
}) {
  // TODO
}
