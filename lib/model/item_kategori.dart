class Kategori {
  int _id;
  String _brtKarung;
  String _kualitas;

  int get id => _id;
  String get brtKarung => this._brtKarung;
  String get kualitas => this._kualitas;

  set brtKarung(String value) => this._brtKarung = value;
  set kualitas(String value) => this._kualitas = value;
  
// konstruktor versi 1
  Kategori(this._brtKarung, this._kualitas);
// konstruktor versi 2: konversi dari Map ke Item
  Kategori.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._brtKarung = map['brtKarung'];
    this._kualitas = map['kualitas'];
  }
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['brtKarung'] = this._brtKarung;
    map['kualitas'] = this._kualitas;
    return map;
    
  }
}
