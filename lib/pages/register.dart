// ignore_for_file: avoid_print

import 'package:chat_fl_fi/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final auth = FirebaseAuth.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('user');

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final emailController = TextEditingController();

  var error = '';
  bool _isObscure = true;
  bool _isObscure2 = true;

  registrar(String email, String password) async {
    if (error == '') {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    } else {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Registro',
                style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              const SizedBox(
                height: 45,
              ),
              TextFormField(
                controller: emailController,
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Ingrese Email',
                  prefixIcon: Icon(Icons.person, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.text,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Ingrese Contraseña',
                  prefixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmController,
                style: const TextStyle(fontSize: 25),
                keyboardType: TextInputType.text,
                obscureText: _isObscure2,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Confirme Contraseña',
                  prefixIcon: IconButton(
                      icon: Icon(
                          _isObscure2 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      }),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                onChanged: (value) {
                  if (confirmController.text != passwordController.text) {
                    setState(() {
                      error = 'error';
                    });
                  } else {
                    setState(() {
                      error = '';
                    });
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _botonaLogin(context, 'Ir al Login'),
                  _botonRegistrar(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botonRegistrar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(7, 8))
        ],
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
          onPressed: () {
            registrar(emailController.text, passwordController.text);
          },
          child: const Text(
            'Registrar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget _botonaLogin(BuildContext context, String titulo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(7, 8))
        ],
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage())),
        child: Text(
          titulo,
          style: const TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
