import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:poketcg/Services/notifications_services.dart';
import 'package:poketcg/provider/login_form_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenido al centro pokemon',
          style: getCustomTextStyle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 40, 70, 180),
                Color.fromARGB(255, 175, 0, 150)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _LoginForm(),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginForm = Provider.of<LoginF_Pfrovider>(context);
    return SizedBox(
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: loginForm.formKey,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 247, 0, 255),
                    Color.fromARGB(255, 117, 8, 206),
                    Color.fromARGB(255, 8, 127, 206),
                    Color.fromARGB(255, 8, 133, 206)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: size.width * 0.80,
                      height: size.height * 0.17,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/287/287226.png'),
                          // fit: BoxFit.cover, // Add this to scale the image
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    TextFormField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      //controller: _emailController,
                      decoration: const InputDecoration(
                          hintText: 'ejemplo@test.com',
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 244, 244))),
                      onChanged: (value) => loginForm.email = value,

                      validator: (value) {
                        String pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regExp = RegExp(pattern);
                        return regExp.hasMatch(value ?? '')
                            ? null
                            : 'El valor ingresado no es un correo';
                      },
                    ),
                    TextFormField(
                      autocorrect: false,
                      //controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: '**************',
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 255, 244, 244))),
                      onChanged: (value) => loginForm.password = value,
                      validator: (value) {
                        return (value != null && value.length >= 8)
                            ? null
                            : 'La contraseña debe ser mayor a 7 caracteres';
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        print('Olvidaste contraseña');
                      },
                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 244, 244)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: loginForm.isLoading
                          ? null
                          : () async {
                              final authService = Provider.of<AuthService>(
                                  context,
                                  listen: false);
                              if (!loginForm.isValidForm()) return;
                              final String? errorMessage = await authService
                                  .login(loginForm.email, loginForm.password);
                              if (errorMessage == null) {
                                Navigator.pushReplacementNamed(context, 'home');
                              } else {
                                NotificationsServices.showSnackbar(
                                    errorMessage);
                                loginForm.isLoading = false;
                              }
                            },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 255, 244, 244))),
                      child: const Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 96, 100, 93),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 255, 244, 244),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'register', arguments: '');
                      },
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 96, 108, 93)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.183,
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

TextStyle getCustomTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 20.0,
    color: Colors.black,
    shadows: [
      Shadow(
        color: Color.fromARGB(255, 255, 255, 255),
        offset: Offset(1, 1),
        blurRadius: 3,
      ),
    ],
  );
}
