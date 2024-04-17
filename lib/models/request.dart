class MyRequest {
  int tipoEquacao, nroReps;
  String equacao;
  String? equacaoDerivada;
  double? pontoA, pontoB;
  double precisao;

  MyRequest(
      this.tipoEquacao, this.equacao, this.equacaoDerivada, this.pontoA, this.pontoB, this.precisao, this.nroReps);

  Map<String, dynamic> toJson() {
    return {
      "tipo_equacao": tipoEquacao,
      "equacao": equacao,
      "equacao_derivada": equacaoDerivada,
      "ponto_a": pontoA,
      "ponto_b": pontoB,
      "precisao": precisao,
      "nro_reps": nroReps
    };
  }
}
