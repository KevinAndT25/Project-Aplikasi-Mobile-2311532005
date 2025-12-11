import 'package:flutter/material.dart';

class PatternBackground extends StatelessWidget {
  final bool isDarkMode;
  final Widget child;
  final double opacity;

  const PatternBackground({
    super.key,
    required this.isDarkMode,
    required this.child,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background dengan pattern
        _buildBackgroundPattern(),
        
        // Child content dengan opacity
        Opacity(
          opacity: opacity,
          child: child,
        ),
      ],
    );
  }

  Widget _buildBackgroundPattern() {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Background gradient dasar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [
                        Colors.black,
                        Color(0xFF0A0A0A),
                        Colors.black,
                      ]
                    : [
                        Colors.white,
                        Color(0xFFF5F7FA),
                        Colors.white,
                      ],
              ),
            ),
          ),
          
          // Pattern 1: Lingkaran besar di pojok
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? Colors.blue.withOpacity(0.03)
                    : Colors.blue.withOpacity(0.05),
              ),
            ),
          ),
          
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? Colors.green.withOpacity(0.02)
                    : Colors.green.withOpacity(0.04),
              ),
            ),
          ),
          
          // Pattern 2: Kotak dengan sudut rounded
          Positioned(
            top: 100,
            left: 40,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isDarkMode
                    ? Colors.purple.withOpacity(0.03)
                    : Colors.purple.withOpacity(0.06),
                border: Border.all(
                  color: isDarkMode
                      ? Colors.purple.withOpacity(0.1)
                      : Colors.purple.withOpacity(0.15),
                  width: 1.5,
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 150,
            right: 60,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDarkMode
                    ? Colors.orange.withOpacity(0.03)
                    : Colors.orange.withOpacity(0.05),
                border: Border.all(
                  color: isDarkMode
                      ? Colors.orange.withOpacity(0.08)
                      : Colors.orange.withOpacity(0.12),
                  width: 1,
                ),
              ),
            ),
          ),
          
          // Pattern 3: Segitiga (menggunakan Container dengan border trick)
          Positioned(
            top: 200,
            right: 80,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 0,
                height: 0,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.transparent,
                      width: 30,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                      width: 30,
                    ),
                    bottom: BorderSide(
                      color: isDarkMode
                          ? Colors.teal.withOpacity(0.04)
                          : Colors.teal.withOpacity(0.08),
                      width: 52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 80,
            left: 100,
            child: Transform.rotate(
              angle: 1.0,
              child: Container(
                width: 0,
                height: 0,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Colors.transparent,
                      width: 40,
                    ),
                    right: BorderSide(
                      color: Colors.transparent,
                      width: 40,
                    ),
                    bottom: BorderSide(
                      color: isDarkMode
                          ? Colors.red.withOpacity(0.03)
                          : Colors.red.withOpacity(0.06),
                      width: 69,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Pattern 4: Dots pattern kecil
          Positioned(
            top: 300,
            left: 30,
            child: _buildDotsPattern(
              rows: 3,
              columns: 4,
              spacing: 25,
              dotSize: 4,
              color: isDarkMode
                  ? Colors.white.withOpacity(0.03)
                  : Colors.black.withOpacity(0.05),
            ),
          ),
          
          // Pattern 5: Garis diagonal halus
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Pattern 6: Diamond shapes
          Positioned(
            top: 100,
            right: 150,
            child: Transform.rotate(
              angle: 0.785, // 45 degrees
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.yellow.withOpacity(0.02)
                      : Colors.yellow.withOpacity(0.04),
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.yellow.withOpacity(0.1)
                        : Colors.yellow.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: 100,
            left: 150,
            child: Transform.rotate(
              angle: 0.785, // 45 degrees
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.cyan.withOpacity(0.03)
                      : Colors.cyan.withOpacity(0.05),
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.cyan.withOpacity(0.1)
                        : Colors.cyan.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDotsPattern({
    required int rows,
    required int columns,
    required double spacing,
    required double dotSize,
    required Color color,
  }) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          children: List.generate(columns, (colIndex) {
            return Container(
              margin: EdgeInsets.all(spacing / 4),
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            );
          }),
        );
      }),
    );
  }
}