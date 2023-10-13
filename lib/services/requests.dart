import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zeromath/models/equacao_data.dart';

class Requests {
  String endpoint = "http://10.0.2.2";
  // String endpoint = "http://192.168.1.6";

  calculate(obj) async {
    try {
      final resposta = await Dio()
          .post("$endpoint:8000/calculate", data: obj.toJson(), options: Options(contentType: 'application/json'));
      if (resposta.data != null) {
        List<double> listX = [];
        List<double> listY = [];
        List<double> raizes = [];

        List<EquacaoData> dataGraph = [];
        List<EquacaoData> dataRaizes = [];

        List<dynamic> xDynamic = resposta.data["x"];
        listX = xDynamic.map((element) => double.parse(element.toString())).toList();

        List<dynamic> yDynamic = resposta.data["y"];
        listY = yDynamic.map((element) => double.parse(element.toString())).toList();

        List<dynamic> raizesDynamic = resposta.data["raizes"];

        raizesDynamic = raizesDynamic.map((element) => double.parse(element[0].toString())).toList();

        raizes = raizesDynamic.map((element) => double.parse(element.toString())).toList();

        List<EquacaoData> dados = [];
        List<EquacaoData> dadosRaizes = [];

        for (final (index, item) in listX.indexed) {
          EquacaoData dado = EquacaoData(item, listY.elementAt(index));
          dados.add(dado);
        }

        for (final (_, item) in raizes.indexed) {
          EquacaoData dado = EquacaoData(item, 0);
          dadosRaizes.add(dado);
        }
        dataGraph = dados;
        dataRaizes = dadosRaizes;
        return [dataGraph, dataRaizes, raizes];
      }
    } on DioException catch (err) {
      debugPrint(err.toString());
    }
  }

  grafico(obj) async {
    try {
      final resposta = await Dio()
          .post("$endpoint:8000/grafico", data: obj.toJson(), options: Options(contentType: 'application/json'));
      if (resposta.data != null) {
        List<double> listX = [];
        List<double> listY = [];

        List<EquacaoData> dataGraph = [];

        List<dynamic> xDynamic = resposta.data["x"];
        listX = xDynamic.map((element) => double.parse(element.toString())).toList();

        List<dynamic> yDynamic = resposta.data["y"];
        listY = yDynamic.map((element) => double.parse(element.toString())).toList();

        List<EquacaoData> dados = [];

        for (final (index, item) in listX.indexed) {
          EquacaoData dado = EquacaoData(item, listY.elementAt(index));
          dados.add(dado);
        }
        dataGraph = dados;
        return dataGraph;
      }
    } on DioException catch (err) {
      debugPrint(err.toString());
    }
  }
}
