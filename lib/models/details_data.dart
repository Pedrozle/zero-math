import 'package:zeromath/models/equacao_data.dart';

class DetailsData {
  int typeScreen = 0;
  String equacao = "";
  List<List<dynamic>> tabela = [];
  List<EquacaoData> dataGraph = [];
  List<EquacaoData> dataRaizes = [];

  DetailsData(
    this.typeScreen,
    this.equacao,
    this.dataGraph,
    this.dataRaizes,
    this.tabela,
  );
}
