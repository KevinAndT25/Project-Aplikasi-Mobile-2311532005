import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'https://dummyjson.com';
  static const String _loginEndpoint = '/auth/login';
  
  // DEMO users untuk offline mode
  static final List<Map<String, dynamic>> _demoUsers = [
    {
      'username': 'emilys',
      'password': 'emilyspass',
      'name': 'Emily',
      'id': 1,
      'token': 'demo_token_emily_123'
    },
    {
      'username': 'michaelw',
      'password': 'michaelwpass',
      'name': 'Michael',
      'id': 2,
      'token': 'demo_token_michael_456'
    },
    {
      'username': 'sophiab',
      'password': 'sophiabpass',
      'name': 'Sophia',
      'id': 3,
      'token': 'demo_token_sophia_789'
    },
  ];
  
  // Simpan data user yang sedang login
  static Future<void> saveUserData({
    required String username,
    required String token,
    required int userId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Simpan dengan dua key untuk redundancy
      await prefs.setString('auth_username', username);
      await prefs.setString('auth_token', token);
      await prefs.setInt('auth_user_id', userId);
      
      // Simpan username di key terpisah untuk data persistence (TIDAK AKAN DIHAPUS SAAT LOGOUT)
      await prefs.setString('last_username', username);
    } catch (e) {
      print('✗ Error saving user data: $e');
      rethrow;
    }
  }
  
  // Login dengan API DummyJSON atau fallback ke demo users
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      // Coba login dengan API online
      print('🔄 Attempting API login...');
      final response = await http.post(
        Uri.parse('$_baseUrl$_loginEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        print('✅ API login successful');
        final data = jsonDecode(response.body);
        
        // Simpan data user
        await saveUserData(
          username: data['username'] ?? username,
          token: data['accessToken'],
          userId: data['id'] ?? 0,
        );
        
        return {
          'success': true,
          'message': 'Login successful',
          'user': {
            'username': data['username'],
            'id': data['id'],
            'token': data['accessToken'],
          }
        };
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'success': false,
          'message': errorData['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      print('⚠️ API login failed: $e');
      print('🔄 Falling back to demo authentication...');
      
      // FALLBACK: Cek apakah ini demo user
      final demoUser = _demoUsers.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => {},
      );
      
      if (demoUser.isNotEmpty) {
        print('✅ Demo authentication successful for ${demoUser['name']}');
        
        // Simpan data demo user
        await saveUserData(
          username: demoUser['username'],
          token: demoUser['token'],
          userId: demoUser['id'],
        );
        
        return {
          'success': true,
          'message': 'Login successful (Demo Mode)',
          'user': {
            'username': demoUser['username'],
            'id': demoUser['id'],
            'token': demoUser['token'],
          }
        };
      } else {
        print('✗ Demo authentication failed');
        return {
          'success': false,
          'message': 'Invalid credentials. Available demo users:\n'
                     '- Username: emilys, Password: emilyspass\n'
                     '- Username: michaelw, Password: michaelwpass\n'
                     '- Username: sophiab, Password: sophiabpass',
        };
      }
    }
  }
  
  // Ambil token
  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      print('✗ Error getting token: $e');
      return null;
    }
  }
  
  // Ambil user ID
  static Future<int?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('auth_user_id');
    } catch (e) {
      print('✗ Error getting user ID: $e');
      return null;
    }
  }
  
  // Ambil username
  static Future<String?> getAuthUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_username');
    } catch (e) {
      print('✗ Error getting auth username: $e');
      return null;
    }
  }
  
  // Logout
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Hapus data autentikasi
      await prefs.remove('auth_username');
      await prefs.remove('auth_token');
      await prefs.remove('auth_user_id');

    } catch (e) {
      print('✗ Logout error: $e');
      rethrow;
    }
  }
  
  // Clear ALL data termasuk transaksi (hanya untuk debugging atau reset)
  static Future<void> clearAllUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastUsername = await getLastUsername();
      
      if (lastUsername != null) {
        // Hapus semua data dengan prefix last_username
        final keys = prefs.getKeys();
        for (final key in keys) {
          if (key.contains('_$lastUsername')) {
            await prefs.remove(key);
          }
        }
      }
      
      // Hapus semua data autentikasi termasuk last_username
      await prefs.remove('auth_username');
      await prefs.remove('auth_token');
      await prefs.remove('auth_user_id');
      await prefs.remove('last_username');
    } catch (e) {
      print('✗ Error clearing all user data: $e');
      rethrow;
    }
  }
  
  // Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final username = await getAuthUsername();
    final isLoggedIn = token != null && token.isNotEmpty && username != null && username.isNotEmpty;
    return isLoggedIn;
  }
  
  // Get current user info
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('auth_username');
      final token = prefs.getString('auth_token');
      final userId = prefs.getInt('auth_user_id');
      
      if (username == null || token == null || userId == null) {
        return null;
      }
      
      return {
        'username': username,
        'token': token,
        'id': userId,
      };
    } catch (e) {
      print('✗ Error getting current user: $e');
      return null;
    }
  }
  
  // Clear semua data autentikasi
  static Future<void> clearAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_username');
      await prefs.remove('auth_token');
      await prefs.remove('auth_user_id');
    } catch (e) {
      print('✗ Error clearing auth data: $e');
      rethrow;
    }
  }
  
  // Helper untuk mendapatkan username yang benar untuk storage
  static Future<String?> getStorageUsername() async {
    final authUsername = await getAuthUsername();
    final lastUsername = await getLastUsername();
    final storageUsername = authUsername ?? lastUsername;
    
    return storageUsername;
  }
  
  // Ambil last username (selalu ada meski user logout)
  static Future<String?> getLastUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('last_username');
      return username;
    } catch (e) {
      print('✗ Error getting last username: $e');
      return null;
    }
  }
}