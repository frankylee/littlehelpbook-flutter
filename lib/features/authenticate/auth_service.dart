import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:littlehelpbook_flutter/shared/supabase/supabase.dart';

final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  AuthService();

  bool isLoggedIn() {
    return supabaseClient.auth.currentSession?.accessToken != null;
  }

  String? getUserId() {
    return supabaseClient.auth.currentSession?.user.id;
  }

  Future<void> signOut() async {
    return supabaseClient.auth.signOut();
  }
}
