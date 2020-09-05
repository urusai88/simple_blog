import 'package:flutter/material.dart';

class DummyImageWidget extends StatelessWidget {
  static const imageAspectRatio = 16 / 9;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Не нашёл в предоставленном API изображений
        final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
        final width = constraints.maxWidth;
        final height = (constraints.maxWidth / imageAspectRatio);

        final finalWidth = (width * devicePixelRatio).toInt();
        final finalHeight = (height * devicePixelRatio).toInt();

        return Image.network(
          'https://via.placeholder.com/${finalWidth}x$finalHeight',
          width: width,
          height: height,
        );
      },
    );
  }
}
