import 'dart:async';

import 'package:aqueduct/aqueduct.dart';

class OrganizationsController extends ResourceController {
  final _organizations = [
    {'id': 1, 'name': 'S.H.I.E.L.D'},
    {'id': 2, 'name': 'Avengers'},
    {'id': 3, 'name': 'Hydra'},
  ];

  @Operation.get()
  Future<Response> getAllOrganizations({@Bind.query('name') String organizationNameArg}) async {

    if(organizationNameArg != null){
      print('not null');
    }
    return Response.ok(_organizations);
  }

  @Operation.get('id')
  Future<Response> getOrganizationByID(@Bind.path('id') int organizationIdArg) async {
    print('id: $organizationIdArg');

    final organization = _organizations.firstWhere((organization) {
      return organization['id'] == organizationIdArg;
    }, orElse: () {
      return null;
    });

    if(organization == null){
      return Response.notFound();
    }


    return Response.ok(organization);
  }
}
