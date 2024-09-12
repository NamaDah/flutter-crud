import 'dart:async';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:myapp/addpage.dart';
import 'package:myapp/detailpage.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});


  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {
  late Future<List<dynamic>> _futureData;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    _futureData = getData(); // Fetch data initially


    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        _futureData = getData(); // Refresh the data
      });
    });
  }


  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }


  Future<List<dynamic>> getData() async {
    var url = Uri.parse('https://adipramanacomputer.com/apiphp/getdata.php');
    var response = await http.get(url);


    if (response.statusCode == 200) {
      return List<dynamic>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: const Text(
          "Halaman Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
          print("tambah data");
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tooltip: 'Tambah Data',
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(list: snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}


class ItemList extends StatelessWidget {
  final List? list;
  const ItemList({Key? key, this.list}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return Container(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(list: list, index: i),
              ),
            ),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              //colors
              color: Colors.white,
              shadowColor: Colors.blue,
              child: ListTile(
                title: Text(
                  list![i]['item_name'],
                ),
                leading: Icon(
                  Icons.widgets,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
