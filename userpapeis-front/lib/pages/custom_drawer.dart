import 'package:flutter/material.dart';
import 'package:userpapeis/pages/lista_papeis.dart';
import 'package:userpapeis/pages/listar_usuarios.dart';
import 'package:userpapeis/service/api_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Center(
                      child: Text(
                        "Menu de Opções",
                        style: TextStyle(fontSize: 18, color: Colors.purple),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.lock),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Instruções"),
                          ],
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 12),
                                child: const Column(
                                  children: [
                                    Text(
                                      "Instruções",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Realize o cadastro de papéis, depois os atribua para usuários.",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.list),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Papéis"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListaPapeisScreen(
                                      apiService:
                                          ApiService('http://10.0.2.2:8080'),
                                    )));
                      },
                    ),
                    const Divider(),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Usuários"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ListaCadastroUsuariosScreen(
                                      apiService:
                                          ApiService('http://10.0.2.2:8080'),
                                    )));
                      },
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
