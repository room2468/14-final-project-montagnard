import 'package:flutter/material.dart';
import 'package:gudang_kopi/model/dbhelper.dart';
import 'package:gudang_kopi/model/item_masuk.dart';
import 'package:gudang_kopi/page/entrymasuk.dart';
import 'package:sqflite/sqflite.dart';

class Masuk1 extends StatefulWidget {
  @override
  Masuk1State createState() => Masuk1State();
}

class Masuk1State extends State<Masuk1> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Masuk> masukList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (masukList == null) {
      masukList = List<Masuk>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kopi Masuk'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        //button untuk menambah kopi masuk
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                RaisedButton(
                  child: Text("Tambah Data"),
                  onPressed: () async {
                    var item = await navigateToEntryForm(context, null);
                    if (item != null) {//TODO 2 Panggil Fungsi untuk Insert ke DB
                      int result = await dbHelper.insertMasuk(item);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<Masuk> navigateToEntryForm(BuildContext context, Masuk masuk) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryMasuk(masuk);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.masukList[index].jenisKopi,//---------------------------------------
              style: textStyle,
            ),
            //mencetak hasil pengisian form
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Jenis Kopi   : ' + this.masukList[index].jenisKopi),
              Text('Jumlah   : ' + this.masukList[index].jumlah.toString()),
              Text('ID Kategori   : ' + this.masukList[index].idKategori.toString()),
            ]),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {//TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int id = this.masukList[index].id; // get id from sqlite database
                await dbHelper.deleteKategori(id); // delete by id from table
                masukList.removeAt(index); // delete by index from list
                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.masukList[index]);//TODO 4 Panggil Fungsi untuk Edit data
              if (item != null) {
                int result = await dbHelper.updateMasuk(item);
                if (result > 0) {
                  updateListView();
                }
              }
            },
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {//TODO 1 Select data dari DB
      Future<List<Masuk>> itemListFuture = dbHelper.getItemListMasuk();
      itemListFuture.then((itemList) {
        setState(() {
          this.masukList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}