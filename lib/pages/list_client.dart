import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:first_app/class/client.dart';
import 'package:first_app/pages/ButtonsCrid.dart';
import 'package:first_app/pages/sign_up.dart';
import 'package:first_app/services/client_services.dart';
import 'package:first_app/services/services.dart';
import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/circle.dart';
import 'package:first_app/widgets/client_card.dart';
import 'package:first_app/widgets/icon_container.dart';
import 'package:flutter/material.dart';

class ListClients extends StatefulWidget {
  ListClients({Key key}) : super(key: key);

  @override
  _ListClientsState createState() => _ListClientsState();
}

class _ListClientsState extends State<ListClients> {
  ClientService clientService = ClientService();
  RestClientService restClientService = RestClientService();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  List<Client> clients = [];
  int _selectedDestination = 0;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getClients();
    super.initState();
  }

  void _getClients() {
    restClientService.fetchClient("/clients/").then((data) {
      setState(() {
        clients = data.clients;
      });
    });
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ButtonsCrid()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de Clientes",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
            minWidth: responsive.wp(5),
            onPressed: () => print("favorite"),
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert)
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    IconContainer(
                      size: responsive.wp(20),
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: responsive.dp(5.5),
                      ),
                    )
                  ],
                )),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: _selectedDestination == 0 ? Colors.pinkAccent : null,
              ),
              title: Text(
                'List Clients',
                style: TextStyle(
                  color: _selectedDestination == 0 ? Colors.pinkAccent : null,
                ),
              ),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: Icon(
                Icons.delete,
                color: _selectedDestination == 1 ? Colors.pinkAccent : null,
              ),
              title: Text(
                'Buttons Crid',
                style: TextStyle(
                  color: _selectedDestination == 1 ? Colors.pinkAccent : null,
                ),
              ),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: Icon(
                Icons.label,
                color: _selectedDestination == 2 ? Colors.pinkAccent : null,
              ),
              title: Text(
                'Item 3',
                style: TextStyle(
                  color: _selectedDestination == 2 ? Colors.pinkAccent : null,
                ),
              ),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Label',
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.bookmark,
                color: _selectedDestination == 3 ? Colors.pinkAccent : null,
              ),
              title: Text(
                'Item A',
                style: TextStyle(
                  color: _selectedDestination == 3 ? Colors.pinkAccent : null,
                ),
              ),
              selected: _selectedDestination == 3,
              onTap: () => selectDestination(3),
            ),
          ],
        ),
      ),
      body: Container(
          child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -pinkSize * 0.4,
            right: -pinkSize * 0.2,
            child: Circle(
              size: pinkSize,
              colors: [
                Colors.pink,
                Colors.pinkAccent,
              ],
            ),
          ),
          Positioned(
            top: -orangeSize * 0.55,
            left: -orangeSize * 0.15,
            child: Circle(
              size: orangeSize,
              colors: [
                Colors.deepOrange,
                Colors.deepOrangeAccent,
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: responsive.height * 0.75,
                child: (clients.length == 0)
                    ? Center(child: CircularProgressIndicator())
                    : GridView.count(
                        crossAxisCount: responsive.isTablet ? 5 : 1,
                        children: List.generate(clients.length, (index) {
                          return ClientCardWidget(client: clients[index]);
                        })),
              ),
            ],
          )
        ],
      )),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment.bottomRight,
          ringColor: Colors.deepOrangeAccent,
          ringDiameter: 500.0,
          ringWidth: 150.0,
          fabSize: 64,
          fabElevation: 8,
          fabIconBorder: CircleBorder(),
          fabColor: Colors.white,
          fabOpenIcon: Icon(Icons.menu, color: Colors.pinkAccent),
          fabCloseIcon: Icon(Icons.close, color: Colors.pink),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.person_add, size: 35, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
                fabKey.currentState.close();
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.person_add, size: 35, color: Colors.white),
            ),
            RawMaterialButton(
              onPressed: () => {
                setState(() {
                  clients = [];
                }),
                _getClients(),
                fabKey.currentState.close(),
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('A SnackBar has been shown.'),
                  duration: Duration(seconds: 10),
                  backgroundColor: Colors.pinkAccent,
                  elevation: 5,
                  action: SnackBarAction(
                    textColor: Colors.white,
                    onPressed: () {
                      print("snackbar action");
                    },
                    label: 'Action Snackbar',
                  ),
                ))
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(Icons.refresh, size: 35, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
