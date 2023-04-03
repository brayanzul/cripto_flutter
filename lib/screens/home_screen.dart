import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_flutter/model/user_model.dart';
import 'package:cripto_flutter/screens/login_screen.dart';
import 'package:cripto_flutter/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../design/coin_card.dart';
import '../model/coins.dart';
import '../widgets/button_widget.dart';
import '../widgets/total_balance.dart';


class HomeScreen extends StatefulWidget {   
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(const Duration(seconds: 10), ((timer) => fetchCoin()));
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) => {
      loggedInUser = UserModel.fromMap(value.data()),
      setState(() {}),
    });
  }

  // @override
  // void dispose() {
    
  //   super.dispose();
  // }

  Future<List<Coin>> fetchCoin() async {
  coinList = [];
    final response = await http.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h'));
    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if(values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if(values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception("Failed to load, try again");
    }
  }

  // @override
  // void initState() {
  //   fetchCoin();
  //   Timer.periodic(const Duration(seconds: 10), ((timer) => fetchCoin()));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
        actions: [
          //const Icon(Icons.close_outlined),
          ActionChip(
            backgroundColor: Colors.red,
            label: const Text(
              "Buscar Cripto", 
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SearchPage())
              );
            },
          ),
          const SizedBox(
            width: 15,
          ),
          ActionChip(
            backgroundColor: Colors.red,
            label: const Text(
              "Logout", 
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              logout(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: TotalBalance(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(text: 'Deposit', onTap: () {}, active: true),
                  ButtonWidget(text: 'Wallet', onTap: () {}, active: true),
                  ButtonWidget(text: 'Withdraw', onTap: () {}, active: true),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                itemCount: coinList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: CoinCard(
                      name: coinList[index].name, 
                      symbol: coinList[index].symbol, 
                      image: coinList[index].image, 
                      price: coinList[index].price.toDouble(),  
                      change: coinList[index].change.toDouble(), 
                      changePercentage: coinList[index].changePercentage.toDouble(), 
                      rank: coinList[index].rank.toInt(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Welcome"),
    //     centerTitle: true,
    //     actions: [
    //       //const Icon(Icons.close_outlined),
    //       ActionChip(
    //         backgroundColor: Colors.red,
    //         label: const Text(
    //           "Logout", 
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         onPressed: (){
    //           logout(context);
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           SizedBox(
    //             height: 150,
    //             child: Image.asset(
    //               "assets/Crypto.png",
    //               fit: BoxFit.contain,
    //             ),
    //           ),
    //           const Text(
    //             "Welcome Back",
    //             style: TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold
    //             ),
    //           ),
    //           const SizedBox(height: 10),
    //           Text(
    //             "${loggedInUser.firstName} ${loggedInUser.secondName}",
    //             style: const TextStyle(
    //               color: Colors.black54,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //           Text(
    //             "${loggedInUser.email}",
    //             style: const TextStyle(
    //               color: Colors.black54,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 15,
    //           ),
    //           // ActionChip(
    //           //   label: const Text("Logout"),
    //           //   onPressed: (){
    //           //     logout(context);
    //           //   },
    //           // )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

}
