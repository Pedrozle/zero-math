import 'package:zeromath/models/equacao_data.dart';

class DetailsData {
  int typeScreen = 0;
  List<List<double>> tabela = [];
  List<EquacaoData> dataGraph = [];
  List<EquacaoData> dataRaizes = [];

  DetailsData(
    this.typeScreen,
    this.dataGraph,
    this.dataRaizes,
    this.tabela,
  );
}
