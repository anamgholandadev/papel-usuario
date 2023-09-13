import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:userpapeis/model/papel_model.dart';
import 'package:userpapeis/model/usuario_model.dart';
import 'package:userpapeis/service/api_service.dart';

class ListaCadastroUsuariosScreen extends StatefulWidget {
  final ApiService apiService;

  ListaCadastroUsuariosScreen({required this.apiService});

  @override
  _ListaCadastroUsuariosScreenState createState() =>
      _ListaCadastroUsuariosScreenState();
}

class _ListaCadastroUsuariosScreenState
    extends State<ListaCadastroUsuariosScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataCadastroController = TextEditingController();
  final TextEditingController dataCadastroEditController =
      TextEditingController();

  DateTime? dataCadastro;
  Papel? papelSelecionado;
  late List<Papel> papeisDisponiveis;
  List<Usuario> _usuarios = [];
  List<Papel> papeisSelecionados = [];

  @override
  void initState() {
    super.initState();
    _carregarPapeisDisponiveis();
    _carregarUsuarios();
  }

  Future<void> _carregarPapeisDisponiveis() async {
    try {
      final papeis = await widget.apiService.fetchPapeis();
      setState(() {
        papeisDisponiveis = papeis;
      });
    } catch (e) {}
  }

  Future<void> _carregarUsuarios() async {
    try {
      final usuariosCarregados = await widget.apiService.fetchUsuarios();

      setState(() {
        _usuarios = usuariosCarregados;
        _atualizarPapeisSelecionados();
      });
    } catch (e) {}
  }

  void _atualizarPapeisSelecionados() {
    if (_usuarios.isNotEmpty) {
      papeisSelecionados = _usuarios[0].papeis;
    } else {
      papeisSelecionados.clear();
    }
  }

  void _mostrarModalCadastroUsuario(BuildContext context) {
    final selectedPapeis = <Papel>{};
    final currentDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Cadastrar Usuário',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    controller: nomeController,
                    decoration:
                        const InputDecoration(labelText: 'Nome do Usuário'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dataCadastroController,
                    readOnly: true,
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          dataCadastro = selectedDate;
                          dataCadastroController.text = selectedDate.toString();
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Data de Cadastro',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Selecione os Papéis:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: papeisDisponiveis.map((papel) {
                        return CheckboxListTile(
                          title: Text(papel.descricao),
                          value: selectedPapeis.contains(papel),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  selectedPapeis.add(papel);
                                } else {
                                  selectedPapeis.remove(papel);
                                }
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final novoUsuario = Usuario(
                          id: 0,
                          nome: nomeController.text,
                          papeis: selectedPapeis.toList(),
                          dataCadastro: dataCadastro,
                        );
                        await widget.apiService.cadastrarUsuario(novoUsuario);
                        _carregarUsuarios();
                        Navigator.of(context).pop();
                      } catch (e) {}
                    },
                    child: const Text('Cadastrar'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _mostrarModalEditarUsuario(BuildContext context, Usuario usuario) {
    final TextEditingController nomeController =
        TextEditingController(text: usuario.nome);
    List<Papel> papeisSelecionados = List.from(usuario.papeis);
    dataCadastroEditController.text =
        usuario.dataCadastro != null ? usuario.dataCadastro!.toString() : '';
    final currentDate = DateTime.now();
    papeisSelecionados = List.from(usuario.papeis);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Editar Usuário',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      controller: nomeController,
                      decoration: InputDecoration(labelText: 'Nome do Usuário'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: dataCadastroEditController,
                      readOnly: true,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDate != null) {
                          setState(() {
                            dataCadastro = selectedDate;
                            dataCadastroEditController.text =
                                DateFormat('dd/MM/yyyy').format(selectedDate);
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Data de Cadastro',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Papéis:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: papeisDisponiveis.map((papel) {
                        return CheckboxListTile(
                          title: Text(papel.descricao),
                          value: papeisSelecionados.contains(papel),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                if (value) {
                                  papeisSelecionados.add(papel);
                                } else {
                                  papeisSelecionados.remove(papel);
                                }
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final usuarioEditado = Usuario(
                            id: usuario.id,
                            nome: nomeController.text,
                            papeis: papeisSelecionados,
                            dataCadastro:
                                dataCadastroEditController.text.isNotEmpty
                                    ? DateFormat('dd/MM/yyyy')
                                        .parse(dataCadastroEditController.text)
                                    : null,
                          );
                          await widget.apiService
                              .editarUsuario(usuario.id, usuarioEditado);

                          _carregarUsuarios();

                          Navigator.of(context).pop();
                        } catch (e) {}
                      },
                      child: Text('Salvar Alterações'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _excluirUsuario(Usuario usuario) async {
    try {
      await widget.apiService.deleteUsuario(usuario.id);
      setState(() {
        _usuarios.remove(usuario);
      });
    } catch (e) {
      print('Erro ao excluir usuário: $e');
    }
  }

  void _excluirTodosUsuarios() async {
    try {
      await widget.apiService.deletarTodosUsuarios();
      setState(() {
        _usuarios.clear();
      });
    } catch (e) {
      print('Erro ao excluir todos os usuários: $e');
    }
  }

  Future<String?> _mostrarDialogEditarNome(String nomeAtual) async {
    final TextEditingController nomeController =
        TextEditingController(text: nomeAtual);

    return showDialog<String?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Nome'),
          content: TextFormField(
            controller: nomeController,
            decoration: InputDecoration(labelText: 'Nome do Usuário'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                Navigator.of(context).pop(nomeController.text);
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
        title: const Text('Cadastro e Lista de Usuários'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  _excluirTodosUsuarios();
                },
                child: Text('Excluir Todos'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _usuarios.length,
              itemBuilder: (context, index) {
                final usuario = _usuarios[index];
                var usuarioDataCadastro = '';
                if (dataCadastro != null) {
                  usuarioDataCadastro =
                      DateFormat('dd/MM/yyyy').format(usuario.dataCadastro!);
                }
                return ListTile(
                  title: Text(usuario.nome),
                  subtitle: Text(
                    'Data de Cadastro: ${usuarioDataCadastro}\n'
                    'Papéis: ${usuario.papeis.map((papel) => papel.descricao).join(', ')}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _mostrarModalEditarUsuario(context, usuario);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _excluirUsuario(usuario);
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
          _mostrarModalCadastroUsuario(context);
        },
        tooltip: 'Cadastrar Usuário',
        child: const Icon(Icons.add),
      ),
    );
  }
}
