import 'package:flutter/material.dart';
import 'package:flutter_jahzeelproject/screens/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  final double porcet;
  const Homescreen(this.porcet, {Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final textcont1 = TextEditingController();
  final textcont2 = TextEditingController();

  double restip = 0;

  void setDefaultValues(double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('percent %', value);
  }

  Future<double?> getDefaultValues() async {
    final prefs = await SharedPreferences.getInstance();
    final double percent = prefs.getDouble('percent %') ?? widget.porcet;

    return percent;
  }

  @override
  Widget build(BuildContext context) {
    getDefaultValues().then((value) => {textcont2.text = value.toString()});

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 218, 224, 226),
        appBar: AppBar(
            title: const Text("Calculation"),
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 29, 93, 115)),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 29, 93, 115),
                ),
                child: Text(
                  'Jahzeel Project', //´´´´
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Settings'),
                onTap: () {
                  final route = MaterialPageRoute(
                      builder: (context) => const SecondScreen());
                  Navigator.push(context, route);
                },
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: textcont1,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 29, 93, 115))),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: textcont2,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  labelText: 'Percentage % ',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              //agregue el const
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: Center(
                child: Text(
                  'Total tip:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 29, 93, 115))),
                    onPressed: () {
                      restip = (double.parse(textcont1.text) *
                              double.parse(textcont2.text)) /
                          100;
                      setDefaultValues(double.parse(textcont2.text));
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Add"),
                              content: Text("The result is: $restip"),
                            );
                          });
                    },
                    child: const Text("Calculate")),
              ),
            )
          ],
        ));
  }
}
