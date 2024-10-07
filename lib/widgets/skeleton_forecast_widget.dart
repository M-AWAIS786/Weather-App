import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class forecastSketch extends StatelessWidget {
  const forecastSketch({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: _skeleton(
              height: 60,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // _skeleton(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _skeleton(width: 80),
                _skeleton(width: 80),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _skeleton(height: 100),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _skeleton(width: 80),
                _skeleton(width: 80),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                itemCount: 7,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: _skeleton(height: 100),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _skeleton extends StatelessWidget {
  _skeleton({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      enabled: true,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
