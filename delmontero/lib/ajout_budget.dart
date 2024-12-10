import 'package:delmontero/depence.dart';
import 'package:flutter/material.dart';

class Ajoutbudget extends StatelessWidget {
  final List<Depense> depenses;
  const Ajoutbudget({super.key, required this.depenses});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: Pagebudget(depenses: depenses),
    );
  }
}

class Pagebudget extends StatefulWidget {
  final List<Depense> depenses;
  const Pagebudget({super.key, required this.depenses});
  @override
  State<Pagebudget> createState() => _PagebudgetState();
}

class _PagebudgetState extends State<Pagebudget> {
  final TextEditingController _nomDepence = TextEditingController();
  final TextEditingController _montant = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 1000, // Largeur du formulaire
            height: 300, // Hauteur du formulaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                    child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Ajout depense",
                      style: TextStyle(color: Color(0xFF0C5E69)),
                    ),
                    const SizedBox(height: 50),
                    const Text("Titre"),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nomDepence,
                      decoration: const InputDecoration(
                        labelText: 'Depense',
                        hintText: 'Entrez le nom',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text("montant"),
                    TextField(
                      controller: _montant,
                      decoration: const InputDecoration(
                        labelText: 'Montant du depense',
                        hintText: 'Entrez le montant',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          String depenseNom = _nomDepence.text;
                          int? montant = int.tryParse(_montant.text);

                          if (montant != null && depenseNom.isNotEmpty) {
                            // Ajouter la dépense
                            widget.depenses.add(Depense(depenseNom, montant));
                            Navigator.pop(
                                context); // Retour à l'écran précédent
                          }
                        });
                      },
                      child: const Text("Valider"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          fixedSize: const Size(600, 50),
                          shape: const RoundedRectangleBorder()),
                    ),
                  ],
                )),
              ],
            )));
  }
}
