import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../model/dbhelper.dart';
import '../model/item_keluar.dart';
import 'entrykeluar.dart';


class Keluar1 extends StatefulWidget {
  @override
  Keluar1State createState() => Keluar1State();
}

class Keluar1State extends State<Keluar1> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Keluar> keluarList;

  @override
  void initState() {
    super.initState();
    updateListView();
  }
  @override
  Widget build(BuildContext context) {
    if (keluarList == null) {
      keluarList = List<Keluar>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kopi Keluar'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        //button untuk menambah beras keluar
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
                    if (item != null) {
                      //TODO 2 Panggil Fungsi untuk Insert ke DB
                      int result = await dbHelper.insertKeluar(item);//-----------------------------
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

  Future<Keluar> navigateToEntryForm(BuildContext context, Keluar keluar) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryKeluar(keluar);//--------------------------------------------------
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
              this.keluarList[index].jenisKopi,//---------------------------------------
              style: textStyle,
            ),
            //mencetak hasil pengisian form
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Jenis Kopi   : ' + this.keluarList[index].jenisKopi),
              Text('Jumlah   : ' + this.keluarList[index].jumlah.toString()),
              Text('ID Kategori   : ' + this.keluarList[index].idKategori.toString()),
            ]),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int id = this.keluarList[index].id; // get id from sqlite database
                await dbHelper.deleteKategori(id); // delete by id from table
                keluarList.removeAt(index); // delete by index from list
                updateListView();
              },
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.keluarList[index]);
              //TODO 4 Panggil Fungsi untuk Edit data
              if (item != null) {
                int result = await dbHelper.updateKeluar(item);//-----------------------------------
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
      Future<List<Keluar>> itemListFuture = dbHelper.getItemListKeluar();//-------------------------------
      itemListFuture.then((itemList) {
        setState(() {
          this.keluarList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
