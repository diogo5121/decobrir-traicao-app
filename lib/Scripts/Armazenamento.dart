class Armazenamento {
  int? resposta;
  String? pergunta;

  Armazenamento({this.resposta, this.pergunta});

  Armazenamento.fromJson(Map<String, dynamic> json) {
    resposta = json['resposta'];
    pergunta = json['pergunta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resposta'] = this.resposta;
    data['pergunta'] = this.pergunta;
    return data;
  }
}
