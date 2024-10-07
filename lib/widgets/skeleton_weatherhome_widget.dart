import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_wise/constants/app_colors.dart';

class SkeletonWeatherhome extends StatelessWidget {
  const SkeletonWeatherhome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.darkBlue.withOpacity(0.9),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // topbarwidget(weather.location.name),
                const SizedBox(height: 8),
                _skeleton(
                  height: 80,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _skeleton(
                      height: 80,
                    ),
                    const SizedBox(
                        height: 16), // Space between the heading and the image
                    // 'assets/images/partly_cloudy.png'
                    // !image is here
                    _skeleton(
                      height: 200,
                    ),
                    // _skeleton(),
                    const SizedBox(height: 16),

                    _skeleton(
                      height: 60,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                // const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // ! pass the weather tempC, WindKph, Humidity to the widget
                    _skeleton(
                      width: 80,
                      height: 80,
                    ),
                    _skeleton(
                      width: 80,
                      height: 80,
                    ),
                    _skeleton(
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
