import 'package:uuid/uuid.dart';

class Arquivo {
  String id;
  String nome;
  String fone;
  String cpf;
  String dataNascimento;

  Arquivo({required this.id, required this.nome, required this.fone, required this.cpf, required this.dataNascimento});

  Arquivo.empty()
      : id = Uuid().v1(),
        nome = "",
        fone = "",
        cpf = "",
        dataNascimento = "";


  Map<String, dynamic> toMap() {
    return {"id": id, "nome": nome, "fone": fone, "cpf": cpf, "dataNascimento": dataNascimento};
  }
}
