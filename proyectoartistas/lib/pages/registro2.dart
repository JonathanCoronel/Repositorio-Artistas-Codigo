import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyectoartistas/pages/iniciar_sesion2.dart';

class Registro2 extends StatefulWidget {
  const Registro2({super.key, required String title});

  @override
  State<Registro2> createState() => _Registro2State();
}

class _Registro2State extends State<Registro2> {
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordController2 = TextEditingController();
  int activeIndex = 0;
  Timer? _timer;

  @override
  void dispose() {
    // Cancela el Timer al eliminar el widget
    _timer?.cancel();
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    super.dispose();
  }

  final List<String> _images = [
    'https://img.freepik.com/fotos-premium/arte-abstracto-circulos-lineas-sobre-fondo-blanco-generativo-ai_901242-314.jpg?w=740',
    'https://static.vecteezy.com/system/resources/previews/005/437/465/large_2x/the-style-of-abstract-art-suprematism-modern-street-art-and-graffiti-the-design-element-is-isolated-on-a-white-background-suitable-for-printing-and-web-design-geometric-elements-vector.jpg',
    'https://img.freepik.com/fotos-premium/salpicaduras-pintura-colores-aisladas-sobre-fondo-blanco-arte-abstracto-salpicaduras-pintura-colores-aisladas-sobre-fondo-blanco-fondo-artistico-abstracto-ai-generado_538213-5576.jpg',
    'https://i.pinimg.com/736x/91/61/f9/9161f9bda44f9cbbef405cd1835f1457.jpg',
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          activeIndex = (activeIndex + 1) % _images.length;
        });
      }
    });
  }

  Future<void> _registerUser() async {
    final name = _userController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _passwordController2.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    final url = Uri.parse('http://172.17.170.54:5000/api/register');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registro exitoso')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const IniciarSesion2(title: '')),
        );
      } else {
        final responseData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['error'] ?? 'Error desconocido')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 1,
              ),
              FadeInUp(
                  child: SizedBox(
                height: 350,
                child: Stack(
                  children: _images.asMap().entries.map((e) {
                    return Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 1),
                          opacity: activeIndex == e.key ? 1 : 0,
                          child: Image.network(
                            e.value,
                            height: 400,
                          ),
                        ));
                  }).toList(),
                ),
              )),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _userController,
                  decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Nombre',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 27,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'Correo',
                      hintText: 'Usuario o Correo',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 27,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Contraseña',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 27,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: _passwordController2,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirmar Contraseña',
                      hintText: 'Confirmar Contraseña',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 27,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                delay: const Duration(milliseconds: 800),
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                delay: const Duration(milliseconds: 800),
                child: const Text(
                  'O Registrate con una cuenta de',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                delay: const Duration(milliseconds: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () {
                        // Handle Google login
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.apple,
                          color: Colors.black, size: 40),
                      onPressed: () {
                        // Handle Apple login
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.blue, size: 40),
                      onPressed: () {
                        // Handle Facebook login
                      },
                    ),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.twitter,
                          color: Colors.lightBlue, size: 40),
                      onPressed: () {
                        // Handle Twitter login
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
