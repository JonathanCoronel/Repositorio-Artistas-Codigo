import 'package:flutter/material.dart';
import 'package:proyectoartistas/pages/iniciar_sesion2.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _logoOpacity = 0.0;
  @override
  void initState() {
    super.initState();
    _showLogo();
    _navigatetoHome();
  }

   _showLogo() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Retraso antes de mostrar el logo
    setState(() {
      _logoOpacity = 1.0;
    });
  }

  

  _navigatetoHome() async {
    await Future.delayed(const Duration(milliseconds: 2200), () {});
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
            builder: (context) => const IniciarSesion2(
                  title: 'Flutter',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'images/splash.png',
              fit: BoxFit.cover,
            ),
          ),
            Center(
            child: AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(milliseconds: 1000),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ArteLatino',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'images/logo.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    '¡Bienvenido a la App!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}