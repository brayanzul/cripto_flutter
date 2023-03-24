import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cripto_flutter/model/user_model.dart';
import 'package:cripto_flutter/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              "Logout", 
              style: TextStyle(color: Colors.white),
            ),
            onPressed: (){
              logout(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: const SafeArea(
        child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: TotalBalance(),
          ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 75,
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         ButtonWidget(text: 'Deposit', onTap: () {}, active: true),
          //         ButtonWidget(text: 'Wallet', onTap: () {}, active: true),
          //         ButtonWidget(text: 'Withdraw', onTap: () {}, active: true),
          //       ],
          //     ),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: MediaQuery.of(context).size.height / 1.3,
          //     child: ListView.builder(
          //       itemCount: coinList.length,
          //       itemBuilder: (context, index) {
          //         return SingleChildScrollView(
          //           child: CoinCard(
          //             name: coinList[index].name, 
          //             symbol: coinList[index].symbol, 
          //             image: coinList[index].image, 
          //             price: coinList[index].price.toDouble(),  
          //             change: coinList[index].change.toDouble(), 
          //             changePercentage: coinList[index].changePercentage.toDouble(), 
          //             rank: coinList[index].rank.toInt(),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
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
