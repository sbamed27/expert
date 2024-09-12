import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const MyHomePage(),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap() async {
    String googleUrl = 'https://maps.app.goo.gl/vRo3ufGPcP7nWX6QA';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  static Future<void> openWhatsApp() async {
    var whatsappUrl =
        'whatsapp://send?phone=+213799233144&text=Bonjour, j\'aimerais vous contacter.';
    var whatsappWebUrl =
        'https://wa.me/+213799233144?text=Bonjour, j\'aimerais vous contacter.';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      // Ouvre l'application WhatsApp si disponible
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication, // Utilisation du mode externe
      );
    } else if (await canLaunchUrl(Uri.parse(whatsappWebUrl))) {
      // Ouvre WhatsApp Web si l'application n'est pas disponible
      await launchUrl(
        Uri.parse(whatsappWebUrl),
        mode: LaunchMode.externalApplication, // Utilisation du mode externe
      );
    } else {
      throw 'Could not open WhatsApp.';
    }
  }

  static Future<void> makePhoneCall() async {
    const phoneUrl = 'tel:0799233144'; // Remplace par ton numéro de téléphone
    if (await canLaunchUrl(Uri.parse(phoneUrl))) {
      await launchUrl(Uri.parse(phoneUrl));
    } else {
      throw 'Could not place the call.';
    }
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return _buildWideLayout(context);
          } else {
            return _buildNarrowLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.amber, Colors.brown],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildHeader(),
              _buildLocationButton(), // Agrandir ce bouton
              _buildButtonsRow(), // Distribuer les boutons WhatsApp et Appeler dans une rangée
              _buildImageSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.amber, Colors.brown],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildLocationButton(), // Agrandir ce bouton aussi en mode wide
              const SizedBox(height: 20),
              _buildButtonsRow(), // Distribuer les boutons dans une rangée
              const SizedBox(height: 40),
              _buildImageSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CHIBOUB MAHMOUD",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Votre Expert Agrée",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Près de chez vous",
            style: TextStyle(
              color: Colors.brown,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Colors.brown,
            thickness: 1.5,
            indent: 40,
            endIndent: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationButton() {
    return ElevatedButton.icon(
      onPressed: () => MapUtils.openMap(),
      icon: const Icon(Icons.location_on, color: Colors.white),
      label: const Text(
        "Obtenir la localisation",
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(
            horizontal: 50, vertical: 20), // Augmenter la taille du bouton
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
      ),
    );
  }

  Widget _buildCallButton() {
    return ElevatedButton.icon(
      onPressed: () => MapUtils.makePhoneCall(),
      icon: const Icon(Icons.call, color: Colors.white),
      label: const Text(
        "Appeler",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }

  Widget _buildWhatsAppButton() {
    return ElevatedButton.icon(
      onPressed: () => MapUtils.openWhatsApp(),
      icon: SvgPicture.asset(
        'assets/images/whatsapp.svg',
        color: Colors.white,
        width: 24,
        height: 24,
      ),
      label: const Text(
        "WhatsApp",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWhatsAppButton(),
          _buildCallButton(),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          "assets/images/interface.jpg",
          width: screenSize.width * 0.85,
          height: screenSize.height * 0.3,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
