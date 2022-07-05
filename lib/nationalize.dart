import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Nationalize {
  Nationalize(this.name, this.country);

  String name;
  List<Country> country;

  factory Nationalize.fromJson(Map<String, dynamic> json) => Nationalize(
        json['name'],
        (json['country'] as List).map((e) => Country.fromJson(e)).toList(),
      );
}

class Country {
  Country(this.countryId, this.probability);

  String countryId;
  double probability;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        json['country_id'],
        json['probability'],
      );
}

class NationalizePage extends StatefulWidget {
  const NationalizePage({Key? key}) : super(key: key);
  @override
  State<NationalizePage> createState() => _NationalizePageState();
}

class _NationalizePageState extends State<NationalizePage> {
  bool isLoading = false;

  String? nome;

  Nationalize? infoNationalize;

  void callNationalize() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isLoading = true;
    });
    final info = await fetchNationalize();
    final jBody = json.decode(info.body);
    setState(() {
      infoNationalize = Nationalize.fromJson(jBody);
      isLoading = false;
    });
  }

  Future<http.Response> fetchNationalize() {
    return http.get(Uri.parse('https://api.nationalize.io/?name=$nome'));
  }

  toPercent(double a) {
    var b = a * 100;
    return b.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NACIONALIDADE'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'NOME',
                ),
                onChanged: (String value) => {
                  setState(() {
                    nome = value;
                  }),
                },
              ),
              ElevatedButton(
                onPressed: nome != null && !isLoading
                    ? () {
                        callNationalize();
                      }
                    : null,
                child: const Text('CONSULTAR'),
              ),
              isLoading ? const CircularProgressIndicator() : Container(),
              infoNationalize != null && !isLoading
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Nome: '),
                            Text(infoNationalize!.name),
                          ],
                        ),
                        const Text('Probabilidades:'),
                      ],
                    )
                  : Container(),
              infoNationalize != null && !isLoading
                  ? Expanded(
                      child: ListView(
                        children: infoNationalize!.country
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.countryId),
                                    Text('${toPercent(e.probability)}%'),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
