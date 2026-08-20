import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_data_hub/widgets/gauges/wellness_gauge.dart';

void main() {
  testWidgets('render wellness gauge to png', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    const dim = 700.0;

    await tester.runAsync(() async {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      canvas.drawRect(
        const Rect.fromLTWH(0, 0, dim, dim),
        Paint()..color = const Color(0xFF060D08),
      );
      WellnessGaugePainter(score: 73, animationValue: 1.0)
          .paint(canvas, const Size(dim, dim));
      final picture = recorder.endRecording();
      final img = await picture.toImage(dim.toInt(), dim.toInt());
      final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
      final out = File('build/gauge_render.png');
      out.parent.createSync(recursive: true);
      await out.writeAsBytes(bytes!.buffer.asUint8List());
    });

    expect(File('build/gauge_render.png').existsSync(), true);
  });
}
