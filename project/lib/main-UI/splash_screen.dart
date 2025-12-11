import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/theme_provider.dart';
import 'login.dart';
import 'home.dart';
import '../helper/authService.dart';
import '../sub-UI/circle_pattern.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthWrapper(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: CirclePatternBackground(
        isDarkMode: isDarkMode,
        patternType: CirclePatternType.bubbles, // Ganti dengan pattern yang diinginkan
        patternOpacity: 1.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75),
                    color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode 
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset(
                      'assets/Images/logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey[800] : Colors.blue[100],
                            borderRadius: BorderRadius.circular(75),
                          ),
                          child: Icon(
                            Icons.account_balance_wallet,
                            size: 70,
                            color: isDarkMode ? Colors.blue[300] : Colors.blue,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // App Name
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 1500),
                child: Column(
                  children: [
                    Text(
                      'MoneyTrack',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.blue[700],
                        fontFamily: 'RobotoSlab',
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Loading
                    SizedBox(
                      width: 100,
                      child: LinearProgressIndicator(
                        backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// AuthWrapper tetap sama
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      
      if (isLoggedIn) {
        final user = await AuthService.getCurrentUser();
        if (user != null) {          
          setState(() {
            _isLoggedIn = true;
            _userData = user;
          });
        }
      } 
    } catch (e) {
      print('✗ Auth check error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    if (_isLoggedIn && _userData != null) {
      return HomePage(
        username: _userData!['username'],
        userId: _userData!['id'],
        token: _userData!['token'],
      );
    }
    return const LoginPage();
  }
}