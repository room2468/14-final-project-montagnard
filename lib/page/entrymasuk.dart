import 'package:flutter/material.dart';
import 'package:gudang_kopi/model/item_masuk.dart';

class EntryMasuk extends StatefulWidget {
  final Masuk masuk;
  EntryMasuk(this.masuk);
  @override
  EntryMasukState createState() => EntryMasukState(this.masuk);
}

//class controller
class EntryMasukState extends State<EntryMasuk> {
  Masuk masuk;
  EntryMasukState(this.masuk);
  TextEditingController jenisKopiController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController idKategoriController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (masuk != null) {
      jenisKopiController.text = masuk.jenisKopi;
      jumlahController.text = masuk.jumlah;
      idKategoriController.text = masuk.idKategori;
    }
    //ubah
    return Scaffold(
        appBar: AppBar(
          title: masuk == null ? Text('Tambah') : Text('Ubah'),
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
                  decoration: InputDecoration(
                    labelText: 'ID Kategori',
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
                          if (masuk == null) {
                            // tambah data
                            masuk = Masuk(
                              jenisKopiController.text,
                              int.parse(jumlahController.text),
                              int.parse(idKategoriController.text),
                            );
                          } else {
                            // ubah data
                            masuk.jenisKopi = jenisKopiController.text;
                            masuk.jumlah = int.parse(jumlahController.text);
                            masuk.idKategori = int.parse(idKategoriController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(
                            context,
                            masuk,
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