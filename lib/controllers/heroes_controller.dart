import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class HeroesController extends Controller{
  final _heroes = [
    {'id': 11, 'name': 'Captain America'},
    {'id': 12, 'name': 'Iron Man'},
    {'id': 13, 'name': 'War Machine'},
    {'id': 14, 'name': 'Thor'},
    {'id': 11, 'name': 'Hawkeye'}
  ];

  @override
  Future<RequestOrResponse> handle(Request request) async {


    print(request.path.variables);
//    if(request.path.variables.containsKey('id')){
//      final id = int.parse(request.path.variables[]);
//    }

    return Response.ok(_heroes);
  }
}