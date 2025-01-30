import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:proyectoartistas/pages/Home.dart';
import 'package:proyectoartistas/pages/carrito_compras.dart';
import 'package:proyectoartistas/pages/chat_artista.dart';
import 'package:proyectoartistas/pages/perfil.dart';

class ButtonTab extends StatefulWidget {
  const ButtonTab({super.key, required this.userData});

  final Map<String, dynamic> userData;

  @override
  State<ButtonTab> createState() => _ButtonTabState();
}

class _ButtonTabState extends State<ButtonTab> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      Home(userData: widget.userData),
      // const Home(),
      const ChatArtista(),
      const CarritoCompras(),
      Perfil(userData: widget.userData), // Pasa los datos aquí
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: const Color(0xFFFFC107),
        inactiveColorPrimary: Colors.grey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.search),
      //   title: "Buscar",
      //   activeColorPrimary: const Color(0xFFFFC107),
      //   inactiveColorPrimary: Colors.grey,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat),
        title: "Chats",
        activeColorPrimary: const Color(0xFFFFC107),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Carrito",
        activeColorPrimary: const Color(0xFFFFC107),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Usuarios",
        activeColorPrimary: const Color(0xFFFFC107),
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineToSafeArea: true,
      backgroundColor: const Color(0xFF003366),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      navBarStyle: NavBarStyle.style13,
    );
  }
}
