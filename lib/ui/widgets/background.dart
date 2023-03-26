import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart' hide Image;

class GrainBackground extends StatefulWidget {
  const GrainBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<GrainBackground> createState() => _GrainBackgroundState();
}

class _GrainBackgroundState extends State<GrainBackground> {
  Future<ui.Image> generateImage(Size size) async {
    int width = size.width.ceil();
    int height = size.height.ceil();

    var noise = ValueNoise(
      seed: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      octaves: 5,
      frequency: 1,
      fractalType: FractalType.RigidMulti,
    );

    var completer = Completer<ui.Image>();
    Int32List pixels = Int32List(width * height);

    for (var x = 0; x < width; x++) {
      for (var y = 0; y < height; y++) {
        int index = y * width + x;
        var luminance = noise.getValue2(x.toDouble(), y.toDouble());
        pixels[index] =
            luminance > .93 ? Colors.white.value : Colors.black.value;
      }
    }

    ui.decodeImageFromPixels(
      pixels.buffer.asUint8List(),
      width,
      height,
      ui.PixelFormat.bgra8888,
      (ui.Image img) {
        completer.complete(img);
      },
    );

    return completer.future;
  }

  Future<ui.Image>? _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = generateImage(const Size(512, 512));
  }

  @override
  Widget build(BuildContext context) {
    var matrix = Matrix4.identity();
    matrix.scale(0.1, 0.1, 0.1);

    return RepaintBoundary(
      child: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder(
            future: _loadingFuture,
            builder: (context, AsyncSnapshot<ui.Image> image) {
              return (image.hasData)
                  ? ShaderMask(
                      shaderCallback: (bounds) => ImageShader(
                        image.data!,
                        TileMode.mirror,
                        TileMode.mirror,
                        matrix.storage,
                      ),
                      blendMode: BlendMode.colorDodge,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Color(0xffF5F7FA),
                              Color(0xffB8C6DB),
                            ],
                          ),
                        ),
                        child: SizedBox.expand(),
                      ),
                    )
                  : Container();
            },
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
