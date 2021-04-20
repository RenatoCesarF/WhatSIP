import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:project/shared/models/game_model.dart';
import 'package:project/shared/models/recomendations_model.dart';

part 'recomendations_controller.g.dart';

class RecomendationsController = _RecomendationsControllerBase with _$RecomendationsController;

abstract class _RecomendationsControllerBase with Store {
  @observable
  bool finishLoad = false;

  @observable
  ObservableList<Game> sameCompany = ObservableList.of([]);

  @observable
  Recomendations recomendedGames;

  @action
  Future<void> getRecomendedGames(int gameId) async {
    finishLoad = false;
    var response = await Dio()
        .post("https://api.igdb.com/v4/games",
            data:
                'where id = $gameId;fields name,franchises.games.name,franchises.games.cover.image_id, similar_games.cover.image_id, similar_games.name, involved_companies.company.published.cover.image_id, involved_companies.company.name, involved_companies.developer, involved_companies.company.published.name;', //$gameName
            options: Options(headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
              'Client-ID': env["CLIENT_ID"],
              'Authorization': env["AUTHORIZATION"],
            }))
        .then((value) => value.data);

    // print(response);

    recomendedGames = Recomendations.fromJson(response[0]);

    recomendedGames.involvedCompanies
        .where((element) => element.developer == true)
        .forEach((element) {
      if (element.company.published == null) return;
      element.company.published.forEach((game) {
        if (game.id == gameId) return;

        sameCompany.add(game);
      });
    });

    finishLoad = true;
  }
}