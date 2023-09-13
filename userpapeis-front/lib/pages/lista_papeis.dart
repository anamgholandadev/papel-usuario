import 'package:flutter/material.dart';
import 'package:userpapeis/model/papel_model.dart';
import 'package:userpapeis/service/api_service.dart';

class ListaPapeisScreen extends StatefulWidget {
  final ApiService apiService;

  const ListaPapeisScreen({required this.apiService});

  @override
  _ListaPapeisScreenState createState() => _ListaPapeisScreenState();
}

class _ListaPapeisScreenState extends State<ListaPapeisScreen> {
  late List<Papel> papeis = [];

  get http => null;

  @override
  void initState() {
    super.initState();
    papeis = [];
    _carregarPapeis();
  }

  void _carregarPapeis() {
    widget.apiService.fetchPapeis().then((papeis) {
      setState(() {
        this.papeis = papeis;
      });
    }).catchError((error) {
      print('Erro ao carregar papeis: $error');
    });
  }

  void _excluirPapel(Papel papel) async {
    try {
      await widget.apiService.deletePapel(papel.id);
      setState(() {
        papeis.remove(papel);
      });
    } catch (e) {
      print('Erro ao excluir papel: $e');
    }
  }

  void _excluirTodosPapeis() async {
    try {
      await widget.apiService.deletarTodosPapeis();
      setState(() {
        papeis.clear();
      });
    } catch (e) {
      print('Erro ao excluir todos os papéis: $e');
    }
  }

  void _mostrarModalCadastroPapel(BuildContext context) {
    final TextEditingController descricaoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastrar Papel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição do Papel'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cadastrar'),
              onPressed: () async {
                final novaDescricao = descricaoController.text;
                if (novaDescricao.isNotEmpty) {
                  final novoPapel = Papel(id: 0, descricao: novaDescricao);

                  await widget.apiService.cadastrarPapel(novoPapel);

                  setState(() {
                    papeis.add(novoPapel);
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Papeis'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _excluirTodosPapeis();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Excluir Todos'),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: papeis.length,
              itemBuilder: (context, index) {
                final papel = papeis[index];
                return ListTile(
                  title: Text(papel.descricao),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _editarPapel(papel);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _excluirPapel(papel);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarModalCadastroPapel(context);
        },
        tooltip: 'Cadastrar Papel',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _editarPapel(Papel papel) async {
    final TextEditingController descricaoController =
        TextEditingController(text: papel.descricao);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Papel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: descricaoController,
                decoration:
                    const InputDecoration(labelText: 'Nova Descrição do Papel'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () async {
                final novaDescricao = descricaoController.text;
                if (novaDescricao.isNotEmpty) {
                  final novoPapel =
                      Papel(id: papel.id, descricao: novaDescricao);

                  try {
                    await widget.apiService.editarPapel(papel.id, novoPapel);
                    Navigator.of(context).pop();
                    _carregarPapeis();
                  } catch (e) {
                    print('Falha ao editar papel: $e');
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
