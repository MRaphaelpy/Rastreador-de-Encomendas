import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track/src/pages/help_page.dart';
import 'package:track/src/pages/inicial_page.dart';

class ThemesController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, model, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(), // Provide light theme.
            darkTheme: ThemeData.light(), // Provide dark theme.
            themeMode: model.mode, // Decides which theme to show.
            home: Scaffold(
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset("images/pinguin.jpg")),
                      decoration: const BoxDecoration(color: Colors.purple),
                      accountName: null,
                      accountEmail: null,
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text("Agradecimentos e Ajuda"),
                      subtitle: const Text(
                          "Pessoas que ajudaram, Links uteis e Ajuda"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Help_Page(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                title: const Text("Rastreamento"),
                centerTitle: true,
                backgroundColor: Colors.purple,
                actions: [
                  IconButton(
                    onPressed: () {
                      model.toggleMode();
                    },
                    icon: Icon(Icons.dark_mode),
                  ),
                ],
              ),
              body: InicialPage(),
            ),
          );
        },
      ),
    );
  }
}

//model.toggleMode();
class ThemeModel with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
