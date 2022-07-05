import 'package:flutter/material.dart';
import 'package:teste/dog_photos.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? login;
  String? senha;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'LOGIN PAGE',
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'campo invalido.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    login = value;
                  });
                },
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'senha fraca, senha precisa ser acima de 5 caracteres!';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    senha = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (login == 'admin' && senha == 'admin') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DogPage()),
                      );
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Login e senha invalida!'),
                        duration: Duration(seconds: 10),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('ENTRAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
