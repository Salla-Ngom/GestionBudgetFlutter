import 'package:delmontero/ajout_budget.dart';
import 'package:delmontero/depence.dart';
import 'package:delmontero/revenue.dart';
import 'package:flutter/material.dart';
import 'package:delmontero/ajout_revenue.dart';

final List<Depense> _depenses = [];
final List<Revenue> _revenues = [];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDGET',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Delmon(depenses: _depenses, revenus: _revenues),
    );
  }
}

class BudgetCard extends StatelessWidget {
  final String title;
  final String amount;

  const BudgetCard({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 150, // Largeur de la carte
        height: 100, // Hauteur de la carte
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: const BoxDecoration(
                color: Color(0xFF0C5E69), // Couleur du haut (Budget)
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8), // Espacement entre les sections
            Text(
              amount,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Delmon extends StatefulWidget {
  final List<Depense> depenses;
  final List<Revenue> revenus;
  const Delmon({super.key, required this.depenses, required this.revenus});
  @override
  State<Delmon> createState() => _DelmonState();
}

class _DelmonState extends State<Delmon> {
  int getTotalDepenses() {
    return widget.depenses
        .fold(0, (sum, depense) => sum + depense.getmontantDepense);
  }

  int getTotalRevenus() {
    return widget.revenus
        .fold(0, (sum, revenu) => sum + revenu.getMontantRevenue);
  }

  int getSolde() {
    return getTotalRevenus() - getTotalDepenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BUDGET", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, bottom: 10.0, right: 10.0),
                  child: BudgetCard(
                    title: "Revenus",
                    amount: "${getTotalRevenus()} F CFA",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, bottom: 10.0, right: 10.0),
                  child: BudgetCard(
                    title: "Dépenses",
                    amount: "${getTotalDepenses()} F CFA",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 10.0, bottom: 10.0, right: 10.0),
                  child: BudgetCard(
                    title: "Solde",
                    amount: "${getSolde()} F CFA",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Liste des dépenses",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          ),
          const SizedBox(height: 16),
          widget.depenses.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    const Text(
                      "Aucune dépense ajoutée.",
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ajoutbudget(
                                depenses: widget.depenses), // Passez la liste
                          ),
                        ).then((_) => setState(
                            () {})); // Mettre à jour l'écran après retour
                      },
                      icon: const Icon(Icons.add, color: Colors.green),
                    ),
                  ],
                ))
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Utiliser la largeur de l'écran
                      height: 500,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: DataTable(
                        headingRowHeight: 50,
                        columnSpacing: 16,
                        border: const TableBorder(
                          verticalInside: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          horizontalInside: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              "TITRE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "MONTANT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "ACTIONS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          ...widget.depenses.map(
                            (depense) => DataRow(
                              cells: [
                                DataCell(Text(depense.getNomDepence)),
                                DataCell(Text(
                                    "${depense.getmontantDepense.toString()} F CFA")),
                                DataCell(
                                  IconButton(
                                    onPressed: () {
                                      // Ajouter une boîte de dialogue de confirmation
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Confirmation"),
                                          content: const Text(
                                              "Voulez-vous vraiment supprimer cette dépense ?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Non"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.depenses
                                                      .remove(depense);
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Oui"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Row(
                                  children: [
                                    const Text(
                                      "AJOUTER DÉPENSE",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Ajoutbudget(
                                                depenses: widget
                                                    .depenses), // Passez la liste
                                          ),
                                        ).then((_) => setState(() {}));
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              const DataCell(SizedBox()), // Cellule vide
                              const DataCell(SizedBox()), // Cellule vide
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 16),
          const Text(
            "Liste des revenus",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow),
          ),
          const SizedBox(height: 16),
          widget.revenus.isEmpty
              ? Center(
                  child: Column(
                  children: [
                    const Text(
                      "Aucun revenu ajouté.",
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AjoutRevenue(
                                revenus: widget.revenus,
                              ),
                            ),
                          ).then((_) => setState(() {}));
                        },
                        icon: const Icon(Icons.add, color: Colors.green)),
                  ],
                ))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 800,
                      // height: MediaQuery.of(context).size.height *
                      // 0.6, // Hauteur dynamique
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: DataTable(
                        headingRowHeight: 50,
                        columnSpacing: 16,
                        border: const TableBorder(
                          verticalInside: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          horizontalInside: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              "TITRE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "MONTANT",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "ACTIONS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C5E69),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          ...widget.revenus.map(
                            (revenu) => DataRow(
                              cells: [
                                DataCell(Text(revenu.getnomRevenue)),
                                DataCell(Text(
                                    "${revenu.getMontantRevenue.toString()} F CFA")),
                                DataCell(
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.revenus.remove(revenu);
                                      });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                               Row(
  children: [
    Expanded(  // Permet au texte de prendre l'espace restant
      child: const Text(
        "AJOUTER REVENU",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    const SizedBox(width: 4),
    IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AjoutRevenue(
              revenus: widget.revenus,
            ),
          ),
        ).then((_) => setState(() {}));
      },
      icon: const Icon(Icons.add, color: Colors.green),
    ),
  ],
),
                              ),
                              const DataCell(SizedBox()), // Cellule vide
                              const DataCell(SizedBox()), // Cellule vide
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
