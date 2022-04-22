// ignore_for_file: avoid_print

import 'package:chat_fl_fi/pages/chatpage.dart';
import 'package:chat_fl_fi/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 70),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        TextFormField(
                          controller: emailController,
                          style: const TextStyle(fontSize: 25),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Ingrese Email',
                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "DEBE INGRESAR EMAIL";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "INGRESE UN EMAIL VALIDO";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
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
                                    _isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "DEBE INGRESAR CONTRASEÑA";
                            }
                            if (!regex.hasMatch(value)) {
                              return "LA CONTRASEÑA DEBE TENER MIN. 6 CARACTERES";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _botonIngresar(context),
                        const SizedBox(
                          height: 20,
                        ),
                        _botonaRegistro(context, 'Registrarse'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ingresar(BuildContext context, String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(
              () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(email: email)),
                )
              },
            );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('EMAIL INCORRECTO');
        } else if (e.code == 'wrong-password') {
          print('CONTRASEÑA INCORRECTA');
        }
      }
    }
  }

  Widget _botonIngresar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(7, 8),
          )
        ],
        color: Colors.green,
        borderRadius: BorderRadius.circular(50),
      ),
      child: TextButton(
        onPressed: () {
          ingresar(context, emailController.text, passwordController.text);
        },
        child: const Text(
          'Ingresar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _botonaRegistro(BuildContext context, String titulo) {
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
            MaterialPageRoute(builder: (context) => const RegisterPage())),
        child: Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
