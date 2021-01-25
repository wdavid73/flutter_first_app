import 'package:first_app/class/client.dart';
import 'package:first_app/pages/client_details.dart';
import 'package:first_app/services/client_services.dart';
import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientCardWidget extends StatefulWidget {
  final Client client;

  ClientCardWidget({Key key, this.client}) : super(key: key);
  @override
  _ClientCardWidgetState createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends State<ClientCardWidget> {
  double _width;
  bool loading = false;

  Client client;

  ClientService clientService = new ClientService();

  @override
  // ignore: must_call_super
  void initState() {
    client = widget.client;
    loading = false;
    print(client.address);
  }

  void _getClients() {
    setState(() {
      loading = true;
    });
    clientService.getClient(client.id.toString()).then((value) {
      if (value.statusCode == 0) {
        setState(() {
          print(value.clients);
          client = value.clients as Client;
          loading = false;
        });
      } else {
        MessageWidget.error(
            context, "Ha ocurrido un error. Detalles: " + value.message, 4);
      }
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Approve',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        //color: (status == 1) ? Colors.deepOrange : Colors.pinkAccent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.redAccent],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          child: Column(
            children: [
              Image.asset('assets/logo_blanco_confma.png'),
              ListTile(
                title: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Nombre Completo : ${client.name.toUpperCase()} ${client.last_name.toUpperCase()}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: client.address != null
                    ? Text(
                        "Direccion : ${client.address}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2),
                        ),
                      )
                    : Text(
                        "don't have address",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontStyle: FontStyle.italic),
                      ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientDetails(client: client),
                          ));
                    },
                    minWidth: responsive.width * 0.4,
                    color: Colors.deepOrange,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    child: Text("Show Details"),
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    onPressed: () {
                      this._showMyDialog();
                    },
                    minWidth: responsive.width * 0.4,
                    color: Colors.deepOrange,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30),
                    ),
                    child: Text("Show Alert Dialog"),
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
