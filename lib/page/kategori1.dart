import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gudang_kopi/model/dbhelper.dart';
import 'package:gudang_kopi/model/item_kategori.dart';
import 'package:gudang_kopi/page/entrykategori.dart';
import 'package:sqflite/sqflite.dart';

class Kategori1 extends StatefulWidget {
  @override
  Kategori1State createState() => Kategori1State();
}

class Kategori1State extends State<Kategori1> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Kategori> kategoriList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (kategoriList == null) {
      kategoriList = List<Kategori>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Kopi'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        //button untuk menambah kategori
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                RaisedButton(
                  child: Text("Tambah Kategori"),
                  onPressed: () async {
                    var item = await navigateToEntryForm(context, null);
                    if (item != null) {
                      //TODO 2 Panggil Fungsi untuk Insert ke DB
                      int result = await dbHelper.insertKategori(item);
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

  Future<Kategori> navigateToEntryForm(
      BuildContext context, Kategori kategori) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryKategori(
          kategori); //--------------------------------------------------
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
              this
                  .kategoriList[index]
                  .beratKarung + " KG", //---------------------------------------
              style: textStyle,
            ),
            //mencetak hasil pengisian form
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Id Kategori   : ' + this.kategoriList[index].id.toString()),
              Text('Berat Karung   : ' + this.kategoriList[index].beratKarung.toString() + ' Kg'),
              Text('Kualitas   : ' + this.kategoriList[index].kualitas.toString()),
            ]),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int id =
                    this.kategoriList[index].id; // get id from sqlite database
                await dbHelper.deleteKategori(id); // delete by id from table
                kategoriList.removeAt(index); // delete by index from list
                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.kategoriList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              if (item != null) {
                int result = await dbHelper.updateKategori(item);
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
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Kategori>> itemListFuture = dbHelper.getItemListKategori();
      itemListFuture.then((itemList) {
        setState(() {
          this.kategoriList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}