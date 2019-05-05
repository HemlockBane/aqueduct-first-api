import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class HeroesController extends Controller {
  final _heroes = [
    {'id': 11, 'name': 'Captain America'},
    {'id': 12, 'name': 'Iron Man'},
    {'id': 13, 'name': 'War Machine'},
    {'id': 14, 'name': 'Thor'},
    {'id': 15, 'name': 'Hawkeye'}
  ];

  @override
  Future<RequestOrResponse> handle(Request request) async {
    // The field called variables is a map
    // If a request path has variables (indicated by the :variable syntax),
    // the matching segments for the path variables will be stored in the map.

    print(request.path.variables); // print the path variables if there are any

    // If the path has a variable called id, check if the resource exists
    if (request.path.variables.containsKey('id')) {
      final id = int.parse(request.path.variables['id']);
      // Query the heroes map. If there is a match, return the result
      // Else, return null
      final hero = _heroes.firstWhere(
        (hero) {
          return hero['id'] == id;
        },
        orElse: () {
          return null;
        },
      );
      // Throw HTTP 404 error if no resource matches the query
      if (hero == null) {
        return Response.notFound();
      }

      return Response.ok(hero);
    }

    if (request.path.variables.containsKey('name')) {
      final name = request.path.variables['name'];
      // Query the heroes map. If there is a match, return the result
      // Else, return null
      final hero = _heroes.firstWhere(
            (hero) {
          return hero['name'] == name;
        },
        orElse: () {
          return null;
        },
      );
      // Throw HTTP 404 error if no resource matches the query
      if (hero == null) {
        return Response.notFound();
      }

      return Response.ok(hero);
    }


    return Response.ok(_heroes);
  }
}
