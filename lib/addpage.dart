import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/homepage.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});


  @override
  State<AddPage> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  //function add data
  Future<void> _addData(
      String item_code, String item_name, int price, int stock) async {
    String url = "https://adipramanacomputer.com/apiphp/add.php";


    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'item_code': item_code,
          'item_name': item_name,
          'price': price,
          'stock': stock,
        }),
      );


      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');


      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Data added successfully');
      } else {
        print('Failed to add data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  //variabel form
  TextEditingController itemCodeController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemStockController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(
            top: 62.0,
            left: 12.0,
            right: 12.0,
            bottom: 12.0,
          ),
          children: [
            Container(
              height: 50.0,
              child: TextField(
                controller: itemCodeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Item Code',
                  hintText: 'Item Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: itemNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'Item Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: itemPriceController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50.0,
              child: TextField(
                controller: itemStockController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Stock',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (itemNameController.text.isEmpty ||
                    itemPriceController.text.isEmpty ||
                    itemStockController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')));
                } else {
                  // Mengonversi nilai dari text ke int menggunakan int.parse()
                  int price = int.parse(itemPriceController.text.trim());
                  int stock = int.parse(itemStockController.text.trim());


                  _addData(itemCodeController.text.trim(),
                      itemNameController.text.trim(), price, stock);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }
              },
              child: const Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}   

