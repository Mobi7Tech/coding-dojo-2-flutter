import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teste/cat_photos.dart';

import 'package:http/http.dart' as http;

class DogPage extends StatefulWidget {
  const DogPage({Key? key}) : super(key: key);
  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
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

    final dog = await fetchDog();

    setState(() {
      isLoading = false;
    });

    final jBody = json.decode(dog.body);

    if (jBody['status'] == "success") {
      setState(() {
        image = jBody['message'];
      });
    }
  }

  Future<http.Response> fetchDog() {
    return http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DOG'),
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
                                    builder: (context) => const CatPage(),
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
