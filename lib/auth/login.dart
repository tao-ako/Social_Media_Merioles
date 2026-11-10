import 'package:flutter/material.dart';

import '../model/account.dart';
import '../views/profileview.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    final account = Account(
      username: _usernameController.text.trim(),
      password: _passwordController.text,
    );
    if (account.username.isNotEmpty && account.password.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(ProfileView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 102,
                      height: 102,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E4FF),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.music_note_rounded,
                        color: Color(0xFF5967D8),
                        size: 62,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'TIKTOKTOK',
                      style: TextStyle(
                        fontSize: 27,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF29263A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Share your moments with friends',
                      style: TextStyle(color: Color(0xFF777486)),
                    ),
                    const SizedBox(height: 42),
                    TextFormField(
                      key: const ValueKey('username-field'),
                      controller: _usernameController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        hintText: 'Username',
                      ),
                      validator: (value) =>
                          value == null || value.trim().isEmpty
                          ? 'Please enter your username'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const ValueKey('password-field'),
                      controller: _passwordController,
                      obscureText: true,
                      onFieldSubmitted: (_) => _login(),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        hintText: 'Password',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Please enter your password'
                          : null,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5967D8),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
