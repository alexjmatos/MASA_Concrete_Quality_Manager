import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample.dart';
import 'package:masa_epico_concrete_manager/service/concrete_sample_dao.dart';

import '../utils/sequential_counter_generator.dart';

class HomeViewDTO {
  List<ConcreteSample> pending = [];
  List<Widget> tiles = [];
  ConcreteSampleDAO concreteSampleDAO = ConcreteSampleDAO();

  Future<List<ConcreteSample>> pendingWork() async {
    return await concreteSampleDAO.findAll();
  }

  void buildTiles() {
    pendingWork().then(
      (value) {
        tiles = pending.map((samp) {
          return ExpansionTile(
              title: Text(
                  "${SequentialFormatter.generatePadLeftNumber(samp.id)} - ${samp.remission}"),
              children: [Text(samp.remission ?? "")]);
        }).toList();
      },
    );
  }
}
