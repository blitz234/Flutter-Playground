import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login Screen")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Email",
              ),
              controller: email,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: authProvider.obscure,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: (() {
                    authProvider.setObscure();
                  }),
                  child: (authProvider.obscure)
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                hintText: "Password",
              ),
              controller: password,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                child: (authProvider.loading)
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Login",
                      ),
                onPressed: () {
                  authProvider.login(
                      email.text.toString(), password.text.toString());
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
