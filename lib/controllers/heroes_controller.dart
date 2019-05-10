import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class HeroesController extends ResourceController {
  HeroesController(this.context);


  ManagedContext context;


  final _heroes = [
    {'id': 11, 'name': 'Captain America'},
    {'id': 12, 'name': 'Iron Man'},
    {'id': 13, 'name': 'War Machine'},
    {'id': 14, 'name': 'Thor'},
    {'id': 15, 'name': 'Hawkeye'}
  ];

  @Operation.get()
  Future<Response> getAllHeroes() async {
    return Response.ok(_heroes);
  }

  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int heroID) async {
    //final id = int.parse(request.path.variables['id']);
    // Query the heroes map. If there is a match, return the result
    // Else, return null
    final hero = _heroes.firstWhere((hero) {return hero['id'] == heroID;}, orElse: () {return null;},);
    // Throw HTTP 404 error if no resource matches the query
    if (hero == null) {
      return Response.notFound();
    }

    return Response.ok(hero);
  }
}
