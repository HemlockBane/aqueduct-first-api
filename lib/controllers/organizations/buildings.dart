import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class BuildingsController extends ResourceController {
  final _buildings = [
    {'id': 1, 'name': 'S.H.I.E.L.D HQ'},
    {'id': 2, 'name': 'Avengers Tower'},
    {'id': 3, 'name': 'Hydra HQ'},
  ];

  @Operation.get()
  Future<Response> getAllBuildings({@Bind.query('name') String buildingsNameArg}) async {

    if(buildingsNameArg != null){
      print('not null');
    }
    return Response.ok(_buildings);
  }

  @Operation.get('id')
  Future<Response> getBuildingsByID(@Bind.path('id') int buildingsIdArg) async {
    print('id: $buildingsIdArg');

    final buildings = _buildings.firstWhere((buildings) {
      return buildings['id'] == buildingsIdArg;
    }, orElse: () {
      return null;
    });

    if(buildings == null){
      return Response.notFound();
    }


    return Response.ok(buildings);
  }
}
