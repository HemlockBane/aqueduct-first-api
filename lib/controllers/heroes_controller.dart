import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

import 'package:first_api/models/hero.dart';

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

  // Refer to the aqueduct docs tutorial
  @Operation.get()
  Future<Response> getAllHeroes() async {
    // Create a query to be sent to the database
    final heroQuery = Query<Hero>(context);
    // Get all the instance types (in this case, heroes) from the database
//    final heroes = heroQuery.fetch();
//    return Response.ok(heroes);

    /// Must await the value of fetch or else the error below is thrown
    ///[Converting object to an encodable object failed: Instance of 'Future<List<Hero>>']

    final heroes = await heroQuery.fetch();
    return Response.ok(heroes);
  }

  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int heroId) async {
    // This query is a filter that filters the the contents of the
    //heroes table with the condition that the row index of the specific
    // hero must match the path variable
    final heroQuery = Query<Hero>(context)
      ..where((hero) {
        return hero.id;
      }).equalTo(heroId);

    // Return one hero from the table that fulfils the query condition
    final hero = await heroQuery.fetchOne();

    if (hero == null) {
      return Response.notFound();
    }
    return Response.ok(hero);
  }
}
