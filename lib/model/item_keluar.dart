class Keluar {
  int _id;
  String _jenisKopi;
  int _jumlah;
  int _idKategori;

  int get id => _id;
  String get jenisKopi => this._jenisKopi;
  get jumlah => this._jumlah;
  get idKategori => this._idKategori;

  set merkBeras(String value) => this._jenisKopi = value;
  set jumlah(value) => this._jumlah = value;
  set idKategori(value) => this._idKategori = value;

// konstruktor versi 1
  Keluar(this._jenisKopi, this._jumlah, this._idKategori);
// konstruktor versi 2: konversi dari Map ke Item
  Keluar.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._jenisKopi = map['jenisKopi'];
    this._jumlah = map['jumlah'];
    this._idKategori = map['idKategori'];
  }
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['jenisKopi'] = this._jenisKopi;
    map['jumlah'] = this._jumlah;
    map['idKategori'] = this._idKategori;
    return map;
  }
}
