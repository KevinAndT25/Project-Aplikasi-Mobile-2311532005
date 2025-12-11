import 'package:flutter/material.dart';

/// CirclePatternBackground - Widget background dengan berbagai variasi bentuk lingkaran
class CirclePatternBackground extends StatelessWidget {
  final bool isDarkMode;
  final Widget child;
  final double patternOpacity;
  final CirclePatternType patternType;
  final Color? primaryColor;
  final Color? secondaryColor;

  const CirclePatternBackground({
    super.key,
    required this.isDarkMode,
    required this.child,
    this.patternOpacity = 1.0,
    this.patternType = CirclePatternType.bubbles,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? Color(0xFF0A0A0A) : Color(0xFFE0E0E0);
    final primary = primaryColor ?? (isDarkMode ? Colors.blueGrey[800]! : Colors.blueGrey[100]!);
    final secondary = secondaryColor ?? (isDarkMode ? Colors.grey[800]! : Colors.grey[200]!);
    
    return Stack(
      children: [
        // Background dasar dengan warna solid
        Container(color: bgColor),
        
        // Pattern dengan opacity
        Opacity(
          opacity: patternOpacity,
          child: _buildPatternByType(context, bgColor, primary, secondary),
        ),
        
        // Child content
        child,
      ],
    );
  }

  Widget _buildPatternByType(BuildContext context, Color bgColor, Color primary, Color secondary) {
    switch (patternType) {
      case CirclePatternType.bubbles:
        return _buildBubblesPattern(context, bgColor, primary, secondary);
      case CirclePatternType.waves:
        return _buildWavesPattern(context, bgColor, primary, secondary);
      case CirclePatternType.geometric:
        return _buildGeometricPattern(context, bgColor, primary, secondary);
      case CirclePatternType.organic:
        return _buildOrganicPattern(context, bgColor, primary, secondary);
      case CirclePatternType.minimal:
        return _buildMinimalPattern(context, bgColor, primary, secondary);
    }
  }

  // Pattern 1: Bubbles - Lingkaran dengan variasi ukuran besar
  Widget _buildBubblesPattern(BuildContext context, Color bgColor, Color primary, Color secondary) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          // Bubble besar 1 - Pojok kiri atas (oval horizontal)
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    _withOpacity(primary, isDarkMode ? 0.08 : 0.15),
                    _withOpacity(primary, 0.01),
                  ],
                ),
              ),
            ),
          ),
          
          // Bubble besar 2 - Pojok kanan bawah (oval vertikal)
          Positioned(
            bottom: -200,
            right: -150,
            child: Container(
              width: 350,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.7,
                  colors: [
                    _withOpacity(secondary, isDarkMode ? 0.06 : 0.12),
                    _withOpacity(secondary, 0.01),
                  ],
                ),
              ),
            ),
          ),
          
          // Bubble sedang 3 - Tengah kiri (lingkaran sempurna)
          Positioned(
            top: 150,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.6,
                  colors: [
                    _withOpacity(primary, isDarkMode ? 0.05 : 0.1),
                    _withOpacity(primary, 0.01),
                  ],
                ),
              ),
            ),
          ),
          
          // Bubble sedang 4 - Tengah kanan (lemon/oval miring)
          Positioned(
            top: 300,
            right: -100,
            child: Transform.rotate(
              angle: 0.3,
              child: Container(
                width: 220,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(140),
                  gradient: RadialGradient(
                    center: const Alignment(0.2, 0.1),
                    radius: 0.7,
                    colors: [
                      _withOpacity(secondary, isDarkMode ? 0.04 : 0.08),
                      _withOpacity(secondary, 0.01),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Bubble kecil 5 - Bawah tengah (drop shape)
          Positioned(
            bottom: 100,
            left: screenWidth / 2 - 100,
            child: Container(
              width: 180,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(90),
                  topRight: Radius.circular(90),
                  bottomLeft: Radius.circular(90),
                  bottomRight: Radius.circular(180),
                ),
                gradient: RadialGradient(
                  center: const Alignment(0.3, 0.3),
                  radius: 0.8,
                  colors: [
                    _withOpacity(primary, isDarkMode ? 0.03 : 0.06),
                    _withOpacity(primary, 0.01),
                  ],
                ),
              ),
            ),
          ),
          
          // Bubble kecil 6 - Atas tengah (teardrop)
          Positioned(
            top: -50,
            left: screenWidth / 2 - 50,
            child: Transform.rotate(
              angle: -0.4,
              child: Container(
                width: 150,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(75),
                    topRight: Radius.circular(75),
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(75),
                  ),
                  gradient: RadialGradient(
                    center: const Alignment(-0.2, -0.2),
                    radius: 0.6,
                    colors: [
                      _withOpacity(secondary, isDarkMode ? 0.04 : 0.08),
                      _withOpacity(secondary, 0.01),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Efek halus tambahan - Blur overlay untuk soft edges
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    _withOpacity(bgColor, 0.1),
                    _withOpacity(bgColor, 0.3),
                    _withOpacity(bgColor, 0.6),
                    _withOpacity(bgColor, 0.8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pattern 2: Waves - Lingkaran dengan efek gelombang
  Widget _buildWavesPattern(BuildContext context, Color bgColor, Color primary, Color secondary) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          // Wave besar - Concentric circles
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    _withOpacity(primary, isDarkMode ? 0.04 : 0.08),
                    _withOpacity(primary, 0.01),
                    _withOpacity(primary, isDarkMode ? 0.02 : 0.04),
                    _withOpacity(primary, 0.01),
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
              ),
            ),
          ),
          
          // Wave sedang - Offset center
          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(0.3, 0.3),
                  radius: 0.7,
                  colors: [
                    _withOpacity(secondary, isDarkMode ? 0.03 : 0.06),
                    _withOpacity(secondary, 0.01),
                    _withOpacity(secondary, isDarkMode ? 0.02 : 0.04),
                    _withOpacity(secondary, 0.01),
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),
          
          // Small ripples
          for (int i = 0; i < 5; i++)
            Positioned(
              left: i % 2 == 0 ? -50 + i * 100 : screenWidth - 150 + i * 50,
              top: 100 + i * 80,
              child: Container(
                width: 200 + i * 30,
                height: 200 + i * 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _withOpacity(primary, isDarkMode ? 0.02 : 0.04),
                    width: 20 - i * 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Pattern 3: Geometric - Lingkaran dengan pola geometris
  Widget _buildGeometricPattern(BuildContext context, Color bgColor, Color primary, Color secondary) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          // Large base circle
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.1,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(primary, isDarkMode ? 0.03 : 0.06),
              ),
            ),
          ),
          
          // Half circle - Right side
          Positioned(
            top: screenHeight * 0.4,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(secondary, isDarkMode ? 0.02 : 0.04),
              ),
            ),
          ),
          
          // Quarter circles in corners
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(200),
                ),
                color: _withOpacity(primary, isDarkMode ? 0.02 : 0.04),
              ),
            ),
          ),
          
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),
                ),
                color: _withOpacity(secondary, isDarkMode ? 0.02 : 0.04),
              ),
            ),
          ),
          
          // Oval shapes
          Positioned(
            top: screenHeight * 0.6,
            left: screenWidth * 0.3,
            child: Transform.rotate(
              angle: 0.5,
              child: Container(
                width: 150,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(125),
                  color: _withOpacity(primary, isDarkMode ? 0.015 : 0.03),
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: screenHeight * 0.2,
            right: screenWidth * 0.4,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 180,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: _withOpacity(secondary, isDarkMode ? 0.01 : 0.02),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Pattern 4: Organic - Bentuk organik seperti tetesan air
  Widget _buildOrganicPattern(BuildContext context, Color bgColor, Color primary, Color secondary) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          // Water drop shapes
          Positioned(
            top: 100,
            left: screenWidth * 0.2,
            child: _buildWaterDrop(120, 180, primary, isDarkMode ? 0.04 : 0.08, 0.2),
          ),
          
          Positioned(
            top: 300,
            right: screenWidth * 0.15,
            child: Transform.rotate(
              angle: 0.7,
              child: _buildWaterDrop(150, 220, secondary, isDarkMode ? 0.03 : 0.06, -0.1),
            ),
          ),
          
          Positioned(
            bottom: 200,
            left: screenWidth * 0.1,
            child: Transform.rotate(
              angle: -0.4,
              child: _buildWaterDrop(100, 160, primary, isDarkMode ? 0.02 : 0.04, 0.3),
            ),
          ),
          
          // Blob shapes
          Positioned(
            top: -80,
            right: -50,
            child: _buildBlobShape(250, 300, secondary, isDarkMode ? 0.02 : 0.04),
          ),
          
          Positioned(
            bottom: -100,
            left: -80,
            child: _buildBlobShape(300, 250, primary, isDarkMode ? 0.03 : 0.06),
          ),
          
          // Circle clusters
          Positioned(
            top: screenHeight * 0.4,
            left: screenWidth * 0.6,
            child: _buildCircleCluster(primary, secondary, isDarkMode),
          ),
        ],
      ),
    );
  }

  // Pattern 5: Minimal - Hanya beberapa lingkaran besar
  Widget _buildMinimalPattern(BuildContext context, Color bgColor, Color primary, Color secondary) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return SizedBox.expand(
      child: Stack(
        children: [
          // Single large subtle circle
          Positioned(
            top: screenHeight * 0.3,
            left: screenWidth * 0.2,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(primary, isDarkMode ? 0.02 : 0.04),
              ),
            ),
          ),
          
          // Another large subtle circle
          Positioned(
            bottom: screenHeight * 0.3,
            right: screenWidth * 0.2,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(secondary, isDarkMode ? 0.015 : 0.03),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat bentuk tetesan air
  Widget _buildWaterDrop(double width, double height, Color color, double opacity, double offset) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width / 2),
          topRight: Radius.circular(width / 2),
          bottomLeft: Radius.circular(width),
          bottomRight: Radius.circular(width / 2),
        ),
        gradient: RadialGradient(
          center: Alignment(offset, offset),
          radius: 0.8,
          colors: [
            _withOpacity(color, opacity),
            _withOpacity(color, opacity * 0.3),
            _withOpacity(color, 0.01),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat bentuk blob organik
  Widget _buildBlobShape(double width, double height, Color color, double opacity) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(width * 0.7),
          topRight: Radius.circular(width * 0.3),
          bottomLeft: Radius.circular(width * 0.4),
          bottomRight: Radius.circular(width * 0.6),
        ),
        gradient: RadialGradient(
          center: const Alignment(0.2, 0.2),
          radius: 0.7,
          colors: [
            _withOpacity(color, opacity),
            _withOpacity(color, opacity * 0.5),
            _withOpacity(color, 0.01),
          ],
        ),
      ),
    );
  }

  // Helper untuk membuat cluster lingkaran kecil
  Widget _buildCircleCluster(Color primary, Color secondary, bool isDarkMode) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(primary, isDarkMode ? 0.02 : 0.04),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 80,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(secondary, isDarkMode ? 0.015 : 0.03),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 120,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(primary, isDarkMode ? 0.01 : 0.02),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 40,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _withOpacity(secondary, isDarkMode ? 0.01 : 0.02),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method untuk menghindari deprecated warning
  Color _withOpacity(Color color, double opacity) {
    // Gunakan withOpacity dengan cara yang lebih aman
    return color.withOpacity(opacity.clamp(0.0, 1.0));
  }
}

/// Jenis pattern lingkaran yang tersedia
enum CirclePatternType {
  bubbles,    // Gelembung dengan variasi bentuk
  waves,      // Gelombang konsentris
  geometric,  // Pola geometris
  organic,    // Bentuk organik
  minimal,    // Minimalis
}