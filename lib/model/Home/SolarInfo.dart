class SolarInfo{
  String Panelsnb;
  String Paneleffiency;
  String PanelWatt;
  String PanelArea;

  SolarInfo(
      {required this.Panelsnb, required this.Paneleffiency, required this.PanelWatt, required this.PanelArea});

  factory SolarInfo.fromJson(Map<String, dynamic> json) {
    return SolarInfo(
      Panelsnb: json["Panelsnb"],
      Paneleffiency: json["Paneleffiency"],
      PanelWatt: json["PanelWatt"],
      PanelArea: json["PanelArea"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Panelsnb": this.Panelsnb,
      "Paneleffiency": this.Paneleffiency,
      "PanelWatt": this.PanelWatt,
      "PanelArea": this.PanelArea,
    };
  }
}