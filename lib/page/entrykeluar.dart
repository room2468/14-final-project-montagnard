import 'package:flutter/material.dart';
import 'package:gudang_kopi/model/item_keluar.dart';

class EntryKeluar extends StatefulWidget {
  final Keluar keluar;
  EntryKeluar(this.keluar);
  @override
  EntryKeluarState createState() => EntryKeluarState(this.keluar);
}

//class controller
class EntryKeluarState extends State<EntryKeluar> {
  Keluar keluar;
  EntryKeluarState(this.keluar);
  TextEditingController jenisKopiController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController idKategoriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (keluar != null) {
      jenisKopiController.text = keluar.jenisKopi;
      jumlahController.text = keluar.jumlah;
      idKategoriController.text = keluar.idKategori;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: keluar == null ? Text('Tambah') : Text('Ubah'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: jenisKopiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kopi',
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
                  controller: jumlahController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Jumlah',
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
                  controller: idKategoriController,
                  keyboardType: TextInputType.text,
                  decoration : InputDecoration(
                    labelText: 'ID Kategori',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
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
                          if (keluar == null) {
                            // tambah data
                            keluar = Keluar(
                              jenisKopiController.text,
                              int.parse(jumlahController.text),
                              int.parse(idKategoriController.text),
                            );
                          } else {
                            // ubah data
                            keluar.jenisKopi = jenisKopiController.text;
                            keluar.jumlah = int.parse(jumlahController.text);
                            keluar.idKategori = int.parse(idKategoriController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(
                            context,
                            keluar,
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