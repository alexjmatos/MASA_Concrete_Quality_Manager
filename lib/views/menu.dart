import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/views/concrete_testing_order_form.dart';
import 'package:masa_epico_concrete_manager/views/concrete_quality_sample.dart';
import 'package:masa_epico_concrete_manager/views/concrete_quality_search.dart';
import 'package:masa_epico_concrete_manager/views/concrete_volumetric_weight.dart';
import 'package:masa_epico_concrete_manager/views/customer_form.dart';
import 'package:masa_epico_concrete_manager/views/home_view.dart';
import 'package:masa_epico_concrete_manager/views/project_site_form.dart';
import 'package:masa_epico_concrete_manager/views/site_resident_form.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.title});

  final String title;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const CustomerForm(),
    const SiteResidentForm(),
    const ProjectSiteAndResidentForm(),
    const ConcreteTestingOrderForm(),
    const ConcreteVolumetricWeightForm(),
    const ConcreteTestingSampleForm(),
    const ConcreteQualitySearch(),
  ];

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Agregar cliente'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Agregar residente de obra'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Agregar obra'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Crear orden de muestreo'),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Peso volumetrico'),
              selected: _selectedIndex == 5,
              onTap: () {
                // Update the state of the app
                _onItemTapped(5);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Registrar ensayo'),
              selected: _selectedIndex == 6,
              onTap: () {
                // Update the state of the app
                _onItemTapped(6);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Registros'),
              selected: _selectedIndex == 7,
              onTap: () {
                // Update the state of the app
                _onItemTapped(7);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
