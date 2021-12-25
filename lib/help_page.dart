import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class Help_Page extends StatefulWidget {
  const Help_Page({Key? key}) : super(key: key);

  @override
  _Help_PageState createState() => _Help_PageState();
}

class _Help_PageState extends State<Help_Page> {
  void _lunchlink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agradecimentos e Ajuda",),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Text(
                  "Obrigado pela Ajuda",
                  style: GoogleFonts.pacifico(
                    fontSize: 30
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    "images/eladio.jpg",
                  ),
                ),
                title: Center(
                  child: Text(
                    "Eladio Leal",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                subtitle: Center(
                  child: Text("Json Helper"),
                ),
                onTap: () => _lunchlink("https://github.com/eladiolink"),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    "images/claubert.jpg",
                  ),
                ),
                title: Center(
                  child: Text(
                    "Claubert Vinicius",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                subtitle: Center(
                  child: Text("Styler Helper"),
                ),
                onTap: () => _lunchlink("https://github.com/claubertamsd"),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Encontrou algum erro ou Bug me contate por aqui: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('https://www.instagram.com/mraphael.py/'),
                      icon: Icon(Icons.photo),
                      label: Text("Instagram"),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('tel: 88988713731'),
                      icon: Icon(Icons.phone),
                      label: Text("Wpp ou Telefone"),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('mailto:mraphael.py@gmail.com'),
                      icon: Icon(Icons.mail),
                      label: Text("Email"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
