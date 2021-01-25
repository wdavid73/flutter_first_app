import 'package:first_app/class/client.dart';
import 'package:first_app/utils/resposive.dart';
import 'package:first_app/widgets/circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClientDetails extends StatefulWidget {
  final Client client;

  ClientDetails({Key key, this.client}) : super(key: key);

  @override
  _ClientDetailsState createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Person',
      style: optionStyle,
    ),
    Text(
      'Index 2: Phone',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);
    String _name = widget.client.name;
    String _lastname = widget.client.last_name;
    String _address = widget.client.address;
    String _cellphone = widget.client.cellphone.toString();
    String _phone = widget.client.phone.toString();

    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Client Details",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: responsive.height,
        color: Colors.white,
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
            Positioned(
              top: pinkSize * 0.35,
              child: Card(
                shadowColor: Colors.black45,
                child: Column(
                  children: [
                    // IconContainer(
                    //   size: responsive.wp(35),
                    // ),
                    Image.asset(
                      'assets/logo_negro_confma.png',
                      width: responsive.width * 0.8,
                    ),
                    SizedBox(
                      height: responsive.hp(3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Nombre Completo : ${_name} ${_lastname}",

                        // ${client.name.toUpperCase()} ${client.last_name.toUpperCase()}
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: responsive.dp(2.5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Telefono : ${_phone} \n"
                        "Celular : ${_cellphone}",
                        //${client.phone.toString()} \n
                        //${client.cellphone.toString()}
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: responsive.dp(2.5)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Direccion : ${_address}", //${client.address}
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: responsive.dp(2.5)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: responsive.dp(25),
              child: Container(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: "Person",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: "Phone",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
