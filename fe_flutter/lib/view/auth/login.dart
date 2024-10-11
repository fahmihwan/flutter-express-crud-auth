import 'package:fe_flutter/models/user.dart';
import 'package:fe_flutter/services/user_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordControler = TextEditingController();

  UserService userService = UserService();
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _usernameController.text = 'fahmihwan';
    _passwordControler.text = 'qweqwe123';
  }

  void _submit() async {
    // print();
    final username = _usernameController.text;
    final password = _passwordControler.text;

    await userService.login(username, password).then((_) {
      // Navigator.pushNamed(context, '/home');
      // navigatorKey.currentState?.pushNamed('/');
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        width: 400,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 219, 219, 219), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: "username", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordControler,
                obscureText: true, // Menyembunyikan input dengan titik
                obscuringCharacter: '•', // Mengganti karakter dengan titik
                decoration: const InputDecoration(
                    labelText: "password", border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: _submit, child: Text("Login"))
            ],
          ),
        ),
      ),
    )
        // child: Text("text"),
        );
  }
}
