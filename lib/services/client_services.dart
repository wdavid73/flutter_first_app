import 'dart:convert';

import 'package:first_app/class/client.dart';
import 'package:first_app/services/services.dart';

class ClientService {
  RestClientService restClientService = RestClientService();
  // ignore: non_constant_identifier_names
  final PATH = '/clients/';

  Future<ClientResponse> getClients() async {
    var uri = '${PATH}';
    GenericResponse response = await restClientService.get(uri);
    return _clientsResponseFromJson(response.statusCode, response.message,
        (response.statusCode == 0) ? response.data : null);
  }

  Future<ClientResponse> getClient(String client_id) async {
    var uri = '${PATH}/${client_id}/';
    GenericResponse response = await restClientService.get(uri);
    return _clientResponseFromJson(response.statusCode, response.message,
        (response.statusCode == 0) ? response.data : null);
  }

  ClientResponse _clientResponseFromJson(
      int statusCode, String message, String json) {
    var clientResponse = new ClientResponse();
    clientResponse.statusCode = statusCode;
    clientResponse.message = message;
    clientResponse.clients = (json != null)
        ? (jsonDecode(json) as List)
            .map((client) => Client.fromJson(client))
            .toList()
        : [];
    return clientResponse;
  }

  ClientResponse _clientsResponseFromJson(
      int statusCode, String message, String json) {
    var clientResponse = new ClientResponse();
    clientResponse.statusCode = statusCode;
    clientResponse.message = message;
    clientResponse.clients = (json != null)
        ? (jsonDecode(json) as List)
            .map((client) => Client.fromJson(client))
            .toList()
        : [];
    return clientResponse;
  }
}
