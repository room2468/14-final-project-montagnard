import 'package:flutter/material.dart';
import 'package:gudang_kopi/model/item_kategori.dart';

class EntryKategori extends StatefulWidget {
  final Kategori kategori;
  EntryKategori(this.kategori);
  @override
  EntryKategoriState createState() => EntryKategoriState(this.kategori);
}

//class controller
class EntryKategoriState extends State<EntryKategori> {
  Kategori kategori;
  EntryKategoriState(this.kategori);
  TextEditingController beratKarungController = TextEditingController();
  TextEditingController kualitasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (kategori != null) {
      beratKarungController.text = kategori.beratKarung;
      kualitasController.text = kategori.kualitas;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: kategori == null ? Text('Tambah') : Text('Ubah'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: beratKarungController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Berat Karung',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kualitasController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kualitas',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (kategori == null) {
                            // tambah data
                            kategori = Kategori(
                                beratKarungController.text,
                                kualitasController.text,
                                );
                          } else {
                            // ubah data
                            kategori.beratKarung = beratKarungController.text;
                            kategori.kualitas = kualitasController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(
                            context,
                            kategori,
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(
                              context); //untuk meromove layar dari tumpukan
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
