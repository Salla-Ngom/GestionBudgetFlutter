import 'package:delmontero/revenue.dart';
import 'package:flutter/material.dart';

class AjoutRevenue extends StatelessWidget {
  final List<Revenue> revenus;
  const AjoutRevenue({super.key, required this.revenus});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Ajout Revenu')),
      body: MaPageAjout(revenus: revenus),
    );
  }
}

class MaPageAjout extends StatefulWidget {
  final List<Revenue> revenus;
  const MaPageAjout({super.key, required this.revenus});

  @override
  State<MaPageAjout> createState() => _MaPageAjoutState();
}

class _MaPageAjoutState extends State<MaPageAjout> {
  final TextEditingController _nomRevenu = TextEditingController();
  final TextEditingController _montantRevenu = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 1000, // Largeur du formulaire
            height: 300, // Hauteur du formulaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Form(
            child: Column(
          children: [
            const Text(
                      "Ajout revenu",
                      style: TextStyle(color: Color(0xFF0C5E69)),
                    ),
                    const SizedBox(height: 50),
            TextField(
              controller: _nomRevenu,
              decoration: const InputDecoration(
                label: Text("Nom Revenu"),
                hintText: "Nom revenu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _montantRevenu,
              decoration: const InputDecoration(
                  label: Text("Montant"),
                  hintText: "montant revenu",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    String revenuNom = _nomRevenu.text;
                    int? montantR = int.tryParse(_montantRevenu.text);
                    if (montantR != null && revenuNom.isNotEmpty) {
                      widget.revenus.add(Revenue(revenuNom, montantR));
                      Navigator.pop(context); // Retour à l'écran précédent
                    }
                  });
                },
                child: const Text("Valider"),
                style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          fixedSize: const Size(600, 50),
                          shape: const RoundedRectangleBorder())),
          ],
        ))
              ]),)
      
      ],
    ));
  }
}
