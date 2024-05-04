import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/views/menu.dart';
import 'package:pocketbase/pocketbase.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({super.key, required this.title});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late final PocketBase pb;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginState() {
    pb = Injector.appInstance.get<PocketBase>();
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
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Image.asset(
                    "images/masa-control.png",
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Usuario"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce tu usuario';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Contraseña"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Introduce tu contraseña';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String username = _usernameController.text;
                          final String password = _passwordController.text;

                          final authData = pb
                              .collection(Constants.USERS)
                              .authWithPassword(username, password);

                          authData
                              .then(
                            (value) => {
                              if (pb.authStore.isValid)
                                {
                                  // // Update singleton
                                  // Injector.appInstance.registerSingleton(() {
                                  //   return pb;
                                  // }),

                                  // Navigate the user to the Home page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MenuPage(
                                        title: "MASA Control y Calidad",
                                      ),
                                    ),
                                  ),
                                }
                              else
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Usuario o contraseña incorrecta. Favor de verificar los datos')),
                                  )
                                }
                            },
                          )
                              .catchError(
                            (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Error al conectar a la base de datos. Verifica conexion a internet o intenta mas tarde')),
                              );
                              if (kDebugMode) {
                                print('Error: $error');
                              }
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Favor de llenar la informacion')),
                          );
                          // Navigate the user to the Home page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MenuPage(
                                  title: "MASA Control y Calidad",
                                ),
                              ));
                        }
                      },
                      child: const Text('Ingresar'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
