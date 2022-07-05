import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:teste/nationalize.dart';

class CatPage extends StatefulWidget {
  const CatPage({Key? key}) : super(key: key);
  @override
  State<CatPage> createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  String? image;

  bool isLoading = false;

  @override
  void initState() {
    callPhoto();
    super.initState();
  }

  void callPhoto() async {
    setState(() {
      isLoading = true;
    });

    final cat = await fetchCat();

    setState(() {
      isLoading = false;
    });

    final jBody = json.decode(cat.body);

    setState(() {
      image = jBody['file'];
    });
  }

  Future<http.Response> fetchCat() {
    return http.get(Uri.parse('https://aws.random.cat/meow'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CAT'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NationalizePage(),
                                  ),
                                );
                              },
                              child: const Text('PROXIMA PAGINA'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: !isLoading
                              ? () {
                                  callPhoto();
                                }
                              : null,
                          child: const Text('CARREGAR'),
                        ),
                        image != null
                            ? Image(
                                image: NetworkImage(image!),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
