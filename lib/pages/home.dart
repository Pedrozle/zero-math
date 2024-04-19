import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeromath/components/my_button.dart';
import 'package:zeromath/pages/graphic.dart';
import 'package:zeromath/pages/info.dart';
import 'package:zeromath/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget changeThemeButton() {
    var icon = Provider.of<ThemeProvider>(context).themeData.brightness ==
            Brightness.light
        ? Icons.mode_night
        : Icons.sunny;
    return IconButton(
        onPressed: Provider.of<ThemeProvider>(context).toggleTheme,
        icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/homepage.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0))),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Zero de Funções",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ButtonComponent(
                        radius: 10,
                        onClick: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InfoPage()),
                              )
                            },
                        label: "O que é?")
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonComponent(
                            radius: 10,
                            onClick: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GraphicPage()),
                                  )
                                },
                            label: "Iniciar"),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      changeThemeButton()
                    ],
                  ))
            ],
          )),
    );
  }
}
