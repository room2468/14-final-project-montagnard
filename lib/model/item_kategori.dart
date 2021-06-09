class Kategori {
  int _id;
  String _beratKarung;
  String _kualitas;

  int get id => _id;
  String get beratKarung => this._beratKarung;
  String get kualitas => this._kualitas;

  set beratKarung(String value) => this._beratKarung = value;
  set kualitas(String value) => this._kualitas = value;
  
// konstruktor versi 1
  Kategori(this._beratKarung, this._kualitas);
// konstruktor versi 2: konversi dari Map ke Item
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._beratKarung = map['beratKarung'];
    this._kualitas = map['kualitas'];
  }
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['beratKarung'] = this._beratKarung;
    map['kualitas'] = this._kualitas;
    return map;
    
  }
}
