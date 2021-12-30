import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class Help_Page extends StatefulWidget {
  const Help_Page({Key? key}) : super(key: key);

  @override
  _Help_PageState createState() => _Help_PageState();
}

// ignore: camel_case_types
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
        title: const Text("Agradecimentos e Ajuda",),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SizedBox(
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
              const SizedBox(
                height: 40,
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    "images/eladio.jpg",
                  ),
                ),
                title: const Center(
                  child: Text(
                    "Eladio Leal",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                subtitle: const Center(
                  child: Text("Json Helper"),
                ),
                onTap: () => _lunchlink("https://github.com/eladiolink"),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                leading: ClipOval(
                  child: Image.asset(
                    "images/claubert.jpg",
                  ),
                ),
                title: const Center(
                  // ignore: unnecessary_const
                  child: const Text(
                    "Claubert Vinicius",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                subtitle: const Center(
                  child: Text("Styler Helper"),
                ),
                onTap: () => _lunchlink("https://github.com/claubertamsd"),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Encontrou algum erro ou Bug me contate por aqui: ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('https://www.instagram.com/mraphael.py/'),
                      icon: const Icon(Icons.photo),
                      label: const Text("Instagram"),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('tel: 88988713731'),
                      icon: const Icon(Icons.phone),
                      label: const Text("Wpp ou Telefone"),
                    ),
                    TextButton.icon(
                      onPressed: () =>
                          _lunchlink('mailto:mraphael.py@gmail.com'),
                      icon: const Icon(Icons.mail),
                      label: const Text("Email"),
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
