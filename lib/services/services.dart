import 'dart:async';
import 'dart:convert';

import 'package:first_app/class/client.dart';
import 'package:first_app/services/urls_rest_api.dart';
import 'package:http/http.dart' as http;

class RestClientService {
  final _headers = {'Content-Type': 'application/json'};

  Future<GenericResponse> get(String path) async {
    try {
      print(BASE + path);
      final response = await http.get(BASE + path, headers: _headers);
      if (response.statusCode == 200) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
            1,
            "Consulte la conexión de datos o wifi de su dispositivo, no es posible conectarse con el servidor.",
            null);
      } else {
        return _genericResponseFromJson(
            1,
            'Error interno. Contacte con los desarrolladores. Detalles: ${e.toString()}',
            null);
      }
    }
  }

  Future<GenericResponse> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        BASE + path,
        headers: _headers,
        body: jsonEncode(<String, dynamic>{
          'name': data["name"],
          'last_name': data["last_name"],
          'cellphone': data["cellphone"],
          'address': data["address"],
          'phone': data["phone"],
        }),
      );
      if (response.statusCode == 201) {
        return _genericResponseFromJson(0, "", response.body);
      } else {
        return _genericResponseFromJson(1, response.body, null);
      }
    } catch (e) {
      if (e.toString().contains("No route to host") ||
          e.toString().contains("No address associated with hostname") ||
          e.toString().contains("Connection refused") ||
          e.toString().contains("Network is unreachable")) {
        return _genericResponseFromJson(
            1,
            "Consulte la conexión de datos o wifi de su dispositivo, no es posible conectarse con el servidor.",
            null);
      } else {
        return _genericResponseFromJson(
            1,
            'Error interno. Contacte con los desarrolladores. Detalles: ${e.toString()}',
            null);
      }
    }
  }

  GenericResponse _genericResponseFromJson(
      int statusCode, String message, dynamic data) {
    var genericResponse = new GenericResponse();
    genericResponse.statusCode = statusCode;
    genericResponse.message = message;
    genericResponse.data = data;
    return genericResponse;
  }

  List<Client> parseClients(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Client>((json) => Client.fromJson(json)).toList();
  }

  Future<List<Client>> fetchClient2(path) async {
    final response = await http.get(BASE + path);
    if (response.statusCode == 200) {
      return parseClients(response.body);
    } else {
      throw Exception('Unable to fetch products from the REST API');
    }
  }

  Future<ClientResponse2> fetchClient(path) async {
    final response = await http.get(BASE + path);

    if (response.statusCode == 200) {
      //print(jsonDecode(response.body)["clients"]);
      // If the server did return a 200 OK response,
      // then parse the JSON.

      //print(ClientResponse2.fromJson(jsonDecode(response.body)));
      return ClientResponse2.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load clients');
    }
  }
}

class GenericResponse {
  int statusCode;
  String message;
  dynamic data;
  GenericResponse({this.statusCode, this.message, this.data});
}
