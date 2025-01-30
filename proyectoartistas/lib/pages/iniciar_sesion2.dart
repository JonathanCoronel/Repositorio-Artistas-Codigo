import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyectoartistas/pages/components/button_tab.dart';
import 'package:proyectoartistas/pages/registro2.dart';

class IniciarSesion2 extends StatefulWidget {
  const IniciarSesion2({super.key, required String title});

  @override
  State<IniciarSesion2> createState() => _IniciarSesion2State();
}

class _IniciarSesion2State extends State<IniciarSesion2> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  int activeIndex = 0;
  Timer? _timer;

  @override
  void dispose() {
    // Cancela el Timer al eliminar el widget
    _timer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final List<String> _images = [
    'https://img.freepik.com/fotos-premium/arte-abstracto-circulos-lineas-sobre-fondo-blanco-generativo-ai_901242-314.jpg?w=740',
    'https://static.vecteezy.com/system/resources/previews/005/437/465/large_2x/the-style-of-abstract-art-suprematism-modern-street-art-and-graffiti-the-design-element-is-isolated-on-a-white-background-suitable-for-printing-and-web-design-geometric-elements-vector.jpg',
    'https://img.freepik.com/fotos-premium/salpicaduras-pintura-colores-aisladas-sobre-fondo-blanco-arte-abstracto-salpicaduras-pintura-colores-aisladas-sobre-fondo-blanco-fondo-artistico-abstracto-ai-generado_538213-5576.jpg',
    'https://i.pinimg.com/736x/91/61/f9/9161f9bda44f9cbbef405cd1835f1457.jpg',
  ];

  Future<Map<String, dynamic>?> iniciarSesion(
      String email, String password) async {
    const url = 'http://172.17.170.54:5000/api/authentication';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // El inicio de sesión fue exitoso
        return json.decode(response.body);
      } else {
        // El inicio de sesión falló
        throw Exception('Credenciales inválidas');
      }
    } catch (e) {
      // Manejo de errores
      print('Error al iniciar sesión: $e');
      return null;
    }
  }

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
              FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registro2(
                                        title: '',
                                      )),
                            );
                          },
                          child: const Text(
                            'Registrate',
                            style: TextStyle(
                                color: Color(0xFF004170),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                                color: Color(0xFF004170),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          )),
                    ],
                  )),
              const SizedBox(
                height: 5,
              ),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                delay: const Duration(milliseconds: 800),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Por favor, ingresa un correo y una contraseña')),
                      );
                    } else {
                      var userData = await iniciarSesion(email, password);

                      if (userData != null) {
                        // Navega a ButtonTab pasando los datos del usuario
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ButtonTab(userData: userData)),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Credenciales inválidas')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ingresar',
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
                  'O inicia sesión con una cuenta de',
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
