// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:cryptopouch/models/Crytocurrency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  List<CryptoCurrency> currency = [];
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    getMarkets();
  }

  void getMarkets() async {
    final coin = Uri.http(
      'api.coinlayer.com',
      '/live',
      {
        'access_key': '26f1b413e183ff8cd697fe94be0caf02',
      },
    );
    final icon = Uri.http(
      'api.coinlayer.com',
      '/list',
      {
        'access_key': '26f1b413e183ff8cd697fe94be0caf02',
      },
    );

    final response = await http.get(coin);
    final res = json.decode(response.body);
    final responseIcon = await http.get(icon);
    final resIcon = json.decode(responseIcon.body);
    List<CryptoCurrency> tempList = [];
    for (var element in res['rates'].entries) {
      String fullName = '';
      String icon = '';
      String exchangeRate = element.value.toStringAsFixed(6);
      String symbol = element.key.toString();
      fullName = resIcon['crypto'][symbol]['name_full'];
      icon = resIcon['crypto'][symbol]['icon_url'].toString();
      CryptoCurrency cryptoCurrency = CryptoCurrency(
        symbol: symbol,
        fullName: fullName,
        icon: icon,
        exchangeRate: exchangeRate,
      );
      tempList.add(cryptoCurrency);
    }
    setState(() {
      currency = tempList;
    });
    Timer(
      const Duration(minutes: 3),
      () {
        getMarkets();
      },
    );
  }

  @override
  void initState() {
    getMarkets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 47, 72),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 5,
            right: 5,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 130,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 154, 126, 236),
                      Color.fromARGB(255, 180, 124, 219),
                      Color.fromARGB(255, 203, 122, 207),
                      Color.fromARGB(255, 226, 120, 192),
                      Color.fromARGB(255, 246, 118, 179),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Welcome Back!",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Currency Dashboard",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshData,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: currency.length,
                    itemBuilder: (ctx, index) {
                      CryptoCurrency currentCrypto = currency[index];

                      return Container(
                        margin: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 5),
                        padding: const EdgeInsets.all(10),
                        // width: 100,
                        // height: 100,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 83, 93, 128),
                              Color.fromARGB(255, 68, 78, 113),
                              Color.fromARGB(255, 54, 64, 99),
                            ],
                          ),
                        ),
                        child: ListTile(
                          // onTap: (){},
                          shape: const CircleBorder(eccentricity: 0.9),
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            // backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(
                              currentCrypto.icon,
                            ), // want to get icon here
                          ),
                          title: Text(
                            currentCrypto.fullName,
                            style: const TextStyle(color: Colors.white),
                          ), // want to get full title here.
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                "\$ " +
                                    currentCrypto
                                        .exchangeRate, // want to get exchange rates here
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 244, 152),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
