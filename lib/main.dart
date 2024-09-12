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

  final thresholdWidth = 700;
  final maxEntre = 850;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= thresholdWidth) {
            return _buildWideLayout(context);
          } else {
            return _buildNarrowLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    double ss = MediaQuery.of(context).size.width;
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
              _buildLocationButton(ss), // Agrandir ce bouton
              _buildButtonsRow(
                  ss), // Distribuer les boutons WhatsApp et Appeler dans une rangée
              _buildImageSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    double ss = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orangeAccent, Colors.amber, Colors.brown],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Left side for content
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    //const SizedBox(height: 30),
                    _buildLocationButton(ss),
                    //const SizedBox(height: 20),
                    _buildButtonsRow(ss),
                  ],
                ),
              ),
            ),
            // Right side for image
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildImageSection(context),
              ),
            ),
          ],
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

  Widget _buildLocationButton(double ss) {
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

  Widget _buildCallButton(double w) {
    bool entre = w >= thresholdWidth && w < maxEntre;
    return ElevatedButton.icon(
      onPressed: () => MapUtils.makePhoneCall(),
      icon: const Icon(Icons.call, color: Colors.white),
      label: Text(
        "Appeler",
        style: TextStyle(
          fontSize: entre ? 13 : 18,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: !entre
            ? const EdgeInsets.symmetric(horizontal: 30, vertical: 15)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }

  Widget _buildWhatsAppButton(double w) {
    bool entre = w >= thresholdWidth && w < maxEntre;
    return ElevatedButton.icon(
      onPressed: () => MapUtils.openWhatsApp(),
      icon: SvgPicture.asset(
        'assets/images/whatsapp.svg',
        color: Colors.white,
        width: 24,
        height: 24,
      ),
      label: Text(
        "WhatsApp",
        style: TextStyle(
          fontSize: entre ? 13 : 18,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: entre
            ? null
            : const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }

  Widget _buildButtonsRow(double w) {
    bool entre = w >= thresholdWidth && w < maxEntre;
    return Padding(
      padding: entre
          ? const EdgeInsets.symmetric(horizontal: 5.0)
          : const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWhatsAppButton(w),
          _buildCallButton(w),
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
          width: screenSize.width < thresholdWidth
              ? screenSize.width * 0.85
              : screenSize.width * 1.4,
          height: screenSize.width < thresholdWidth
              ? screenSize.height * 0.3
              : screenSize.height * 0.75,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
