/*
clients": [
    {
      "id": 2,
      "name": "user",
      "last_name": "one",
      "address": "cra23444",
      "phone": 123456789,
      "cellphone": 123456
    },
    {
      "id": 3,
      "name": "pruebas",
      "last_name": "Padilla",
      "address": "Carrera 3C # 49 E 61",
      "phone": 123456789,
      "cellphone": 12434567
    },

 */

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Client {
  int id;
  String name;
  String last_name;
  String address;
  int phone;
  int cellphone;

  Client({this.id, this.name, this.last_name, this.address, this.phone, this.cellphone});




  Client.fromJsonV2(List<dynamic> json){
    List<Client> listClients = [];
    for(final obj in json){
      Map<String , dynamic> currentElement = obj;
      Client client = Client(id : currentElement['id'],
          name : currentElement['name'],
          last_name : currentElement['last_name'],
          address : currentElement['address'],
          phone : currentElement['phone'],
          cellphone : currentElement['cellphone']);
      listClients.add(client);
    }
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id : json['id'],
      name : json['name'],
      last_name : json['last_name'],
      address : json['address'],
      phone : json['phone'],
      cellphone : json['cellphone'],
    );
  }
}


class ClientResponse2{
  List<Client> clients;

  ClientResponse2({this.clients});

  factory ClientResponse2.fromJson(Map<String, dynamic> json) {
    Client c;
    List<Client> clients = [];
    for(dynamic client in json["clients"]){
      c = Client(
        id : client['id'],
        name : client['name'],
        last_name : client['last_name'],
        address : client['address'],
        phone : client['phone'],
        cellphone : client['cellphone'],
      );
      clients.add(c);
    }
    return ClientResponse2(clients : clients);
  }
}

class ClientResponse {
  int statusCode;
  String message;
  List<Client> clients;

  ClientResponse({this.statusCode, this.message, this.clients});
}
