// lib/main.dart - versi akhir dengan Provider
import 'pages/halaman_set_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/keranjang_model.dart';
import 'pages/halaman_keranjang.dart';
import 'pages/halaman_produk.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => KeranjangModel(),
      child: const AplikasiKantin(),
    ),
  );
}

class AplikasiKantin extends StatelessWidget {
  const AplikasiKantin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kantin Kampus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const KerangkaUtama(),
    );
  }
}

class KerangkaUtama extends StatefulWidget {
  const KerangkaUtama({super.key});

  @override
  State<KerangkaUtama> createState() => _KerangkaUtamaState();
}

class _KerangkaUtamaState extends State<KerangkaUtama> {
  // State lokal: tetap menggunakan setState()
  int _indeks = 0;

  static const _halaman = [
    HalamanProduk(),
    HalamanKeranjang(),
  ];

  @override
  Widget build(BuildContext context) {
    // Membaca totalItem dari Provider.
    // Widget akan rebuild jika totalItem berubah.
    final totalItem = context.select<KeranjangModel, int>(
      (model) => model.totalItem,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _indeks == 0
              ? 'Menu Kantin'
              : 'Keranjang ($totalItem)',
        ),
      ),

      // IndexedStack membuat setiap halaman tetap hidup.
      body: IndexedStack(
        index: _indeks,
        children: _halaman,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _indeks,
        onDestinationSelected: (nilaiBaru) {
          setState(() {
            _indeks = nilaiBaru;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}