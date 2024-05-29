// Realizado em aula com o professor (dias 1 e 2)

import 'package:flutter/material.dart';

void main() {
  runApp(AppCrud());
}

class Item {
  String nome;
  String categoria;
  String precoMax;

  Item({required this.nome, required this.categoria, required this.precoMax});
}

class AppCrud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Adiciona a imagem do logo
                Image.asset(
                  'imagem/logo.png',
                  height: 244, // Ajuste conforme necessário
                  width: 275, // Ajuste conforme necessário
                ),

                // Adiciona a segunda imagem acima do logo
                Positioned(
                  top: 72, // Ajuste conforme necessário
                  child: Image.asset(
                    'imagem/logo.png',
                    height: 52.11, // Ajuste conforme necessário
                    width: 300, // Ajuste conforme necessário
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Verificar credenciais
                if (_usernameController.text == 'Giovanna' &&
                    _passwordController.text == 'gi123') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemListPage()),
                  );
                } else {
                  // Exibir mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Credenciais inválidas')),
                  );
                }
              },
              child: Text('Login'),
            ),
            Text('Desenvolvido por Giovanna Cristina'),
          ],
        ),
      ),
    );
  }
}

class ItemListPage extends StatefulWidget {
  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  // Lista de alunos (simulando um banco de dados)
  List<Item> Items = [
    Item(nome: 'Tomate', categoria: 'Fruta', precoMax: '6'),
    Item(nome: 'Maca', categoria: 'Fruta', precoMax: '10'),
    Item(nome: 'Kiwi', categoria: 'Fruta', precoMax: '10'),
    Item(nome: 'Banana', categoria: 'Fruta', precoMax: '5'),
    Item(nome: 'Mel', categoria: 'Alimento', precoMax: '13'),
    Item(nome: 'Coca Cola', categoria: 'Bebida', precoMax: '4'),
    Item(nome: 'Leite', categoria: 'Bebida', precoMax: '2'),
    Item(nome: 'Pão', categoria: 'Alimento', precoMax: '5'),
    Item(nome: 'Frango', categoria: 'Alimento', precoMax: '7'),
    Item(nome: 'Arroz', categoria: 'Alimento', precoMax: '6'),
  ];

  bool _isValidEmail(String email) {
    // Validar o formato do email
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: ListView.builder(
        itemCount: Items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Items[index].nome),
            subtitle: Text(Items[index].categoria),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Excluir aluno
                Items.removeAt(index);
                // Atualizar a interface
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item removido')),
                );
                // Atualizar a lista de alunos
                setState(() {});
              },
            ),
            onTap: () async {
              // Editar o aluno
              Item updatedItem = await showDialog(
                context: context,
                builder: (context) {
                  TextEditingController _nomeController =
                      TextEditingController(text: Items[index].nome);
                  TextEditingController _categoriaController =
                      TextEditingController(text: Items[index].categoria);
                  TextEditingController _precoMaxController =
                      TextEditingController(text: Items[index].precoMax);
                  return AlertDialog(
                    title: Text('Editar Item'),
                    content: Column(
                      children: [
                        TextField(
                          controller: _nomeController,
                          decoration: InputDecoration(labelText: 'Nome'),
                        ),
                        TextField(
                          controller: _categoriaController,
                          decoration: InputDecoration(labelText: ' Categoria'),
                        ),
                        TextField(
                          controller: _precoMaxController,
                          decoration:
                              InputDecoration(labelText: 'Preço Máximo'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Validar e salvar as alterações

                          if (_nomeController.text.isNotEmpty &&
                              _categoriaController.text.isNotEmpty &&
                              _precoMaxController.text.isNotEmpty) {
                            Navigator.pop(
                              context,
                              Item(
                                nome: _nomeController.text.trim(),
                                categoria: _categoriaController.text.trim(),
                                precoMax: _precoMaxController.text.trim(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Preencha todos os campos corretamente')),
                            );
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ],
                  );
                },
              );

              if (updatedItem != null) {
                // Atualizar o aluno na lista
                Items[index] = updatedItem;
                // Atualizar a interface
                setState(() {});
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Adicionar novo aluno
          Item newItem = await showDialog(
            context: context,
            builder: (context) {
              TextEditingController _nomeController = TextEditingController();
              TextEditingController _categoriaController =
                  TextEditingController();
              TextEditingController _precoMaxController =
                  TextEditingController();
              TextEditingController();
              // Adicionar novo aluno
              return AlertDialog(
                title: Text('Novo Item'),
                content: Column(
                  children: [
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextField(
                      controller: _categoriaController,
                      decoration: InputDecoration(labelText: 'Categoria'),
                    ),
                    TextField(
                      controller: _precoMaxController,
                      decoration: InputDecoration(labelText: 'Preço Máximo'),
                      obscureText: true,
                    ),
                  ],
                ),
                // Cancelar operação
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  // Validar e adicionar o novo aluno
                  TextButton(
                    onPressed: () {
                      if (_nomeController.text.isNotEmpty &&
                          _categoriaController.text.isNotEmpty &&
                          _precoMaxController.text.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Item(
                            nome: _nomeController.text.trim(),
                            categoria: _categoriaController.text.trim(),
                            precoMax: _precoMaxController.text.trim(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Preencha todos os campos corretamente')),
                        );
                      }
                    },
                    child: Text('Adicionar'),
                  ),
                ],
              );
            },
          );
          // Verificar espaço a ser alocado para a adição do novo aluno
          if (newItem != null) {
            // Adicionar o novo aluno à lista
            Items.add(newItem);

            // Atualizar a tela
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
