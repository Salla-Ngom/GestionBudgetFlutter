class Revenue {
  String nomRevenue;
  int montantRevenue;
  Revenue(this.nomRevenue, this.montantRevenue);
  String get getnomRevenue => nomRevenue;
  set setNomRevenue(String nomRevenue) => this.nomRevenue = nomRevenue;
  int get getMontantRevenue => montantRevenue;
  set setMontantRevenue(int montantRevenue) =>
      this.montantRevenue = montantRevenue;
}
