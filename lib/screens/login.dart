import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key key,
    @required this.onForgotPasswordTapped,
  }) : super(key: key);

  final Function(String email) onForgotPasswordTapped;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailCtrl,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordCtrl,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(hintText: 'Password'),
                    obscureText: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text('Forgot password?'),
                      onPressed: () => widget.onForgotPasswordTapped(_emailCtrl.text.trim()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
