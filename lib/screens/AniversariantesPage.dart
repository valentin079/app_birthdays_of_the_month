import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:atividade2/services/TbEmerson.dart';
import 'package:atividade2/screens/EdicaoAniversariantePage.dart';

class AniversariantesPage extends StatefulWidget {
  final int mes;
  final String month;

  const AniversariantesPage({required this.mes, required this.month, Key? key})
      : super(key: key);

  @override
  _AniversariantesPageState createState() => _AniversariantesPageState();
}

class _AniversariantesPageState extends State<AniversariantesPage> {
  late Future<List<dynamic>> _fetchDadosMes;

  @override
  void initState() {
    super.initState();
    _fetchDadosMes = fetchDadosMes(widget.mes);
  }

  Future<List<dynamic>> fetchDadosMes(int mes) {
    return TbEmerson().fetchDadosMes(mes);
  }

  Future<void> excluirAniversariante(int id) async {
    try {
      await TbEmerson().excluirAniversariante(id);
      setState(() {
        // Recarregar a tela
        _fetchDadosMes = fetchDadosMes(widget.mes);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao excluir o aniversariante.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aniversariantes ${widget.month}'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchDadosMes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Falha ao carregar os dados'),
            );
          } else {
            List<dynamic> aniversariantes = snapshot.data!;
            return ListView.builder(
              itemCount: aniversariantes.length,
              itemBuilder: (context, index) {
                final aniversariante = aniversariantes[index];
                final dataNascimentoString = aniversariante['data_nascimento'];

                // Convertendo a String para DateTime
                final dataNascimento = DateTime.parse(dataNascimentoString);

                // Formatando a data para "dd/mm/aaaa"
                final formattedDataNascimento =
                DateFormat('dd/MM/yyyy').format(dataNascimento);

                return ListTile(
                  title: Text(aniversariante['nome'] ?? ''),
                  subtitle: Text(formattedDataNascimento),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EdicaoAniversariantePage(
                            id: aniversariante['id'],
                            nome: aniversariante['nome'] ?? '',
                            dataNascimento: dataNascimento,
                            email: aniversariante['email'] ?? '',
                            telefone: aniversariante['telefone'] ?? '', // Add this line
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmar exclusão'),
                          content:
                          Text('Deseja excluir o aniversariante ${aniversariante['nome']}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Fechar o diálogo
                              },
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                excluirAniversariante(aniversariante['id']);
                                Navigator.pop(context); // Fechar o diálogo
                              },
                              child: Text('Excluir'),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
