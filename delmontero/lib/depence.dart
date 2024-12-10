class Depense {
  String nomDepence;
  int montantDepense;
  Depense(this.nomDepence, this.montantDepense);
  String get getNomDepence => nomDepence;
  set setNomDepence(String nomDepence) => this.nomDepence = nomDepence;
  int get getmontantDepense => montantDepense;
  set setmontantDepense(int montantDepense) =>
      this.montantDepense = montantDepense;
}
