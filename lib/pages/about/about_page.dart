import 'package:flutter/cupertino.dart';

class AboutPage extends StatelessWidget {
  static const String routeUri = '/about';

  static MapEntry<String, WidgetBuilder> makeRoute() => MapEntry(
        routeUri,
        (_) => const AboutPage(),
      );

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Impressum / Datenschutz'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                Text.rich(
                  TextSpan(
                    text: 'Impressum',
                    style: TextStyle(
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '''
Betreiber der App und verantwortlich für den Inhalt gemäß § 5 TMG:

    Daniela Rogge c/o familiarise
    Sachsensiedlung 5 | 45481 Mülheim
    kontakt@familiarise.de
            ''',
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Datenschutz',
                    style: TextStyle(
                      color: CupertinoColors.darkBackgroundGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: '''
Verantwortlicher gemäß Art. 4 Nr. 7 der europäischen Datenschutz-Grundverordnung (DSGVO) ist

     Stefan Ostermayr c/o familiarise
     Langkofelweg 14 | 86316 Friedberg
     datenschutz@familiarise.de

Bei der Nutzung der familiarise-App werden personenbezogene Daten erfasst.
Als personenbezogene Daten gelten:
* Profilnamen (frei wählbar)
* Statustexte/-informationen der Benutzer

Durch die Installation und erstmalige Ausführung der familiarise-App wird eine zufällige Geräte-ID erzeugt.
Die Geräte-ID stellt ein pseudonymisiertes Datum dar.

Die Datenübermittlung zwischen der familiarise-App und dem familiarise-Server erfolgt verschlüsselt mittels HTTPS.

Die Löschung der personenbezogenen Daten muss durch den Nutzer selbsttätig durch die Funktion "Fam-Group verlassen" erfolgen.

Push-Berechtigungen in den Apps
Die familiarise-App nutzt Push-Services der Betriebssystemhersteller. Dies sind Kurzmitteilungen,
die auf dem Gerätedisplay des Nutzers angezeigt werden können und mit denen dieser aktiv
über Nachrichten, Statusänderungen, Gruppenaktivitäten und Inaktivität informiert wird.

Im Fall der Nutzung der Push-Services wird ein FCM-Token von Google Firebase sowie ein Device-Token von Apple bzw. eine Registration-ID von Google zugeteilt.
Es handelt sich hierbei nur um verschlüsselte, anonymisierte Geräte-IDs. Der Zweck der Verwendung ist allein die Erbringung
der Push-Services. Ein Rückschluss auf den einzelnen Nutzer ist durch den Betreiber der familiarise-App nicht möglich.
Der Push-Service kann über das Betriebssystem Ihres Smartphones abgeschaltet werden.


Datenschutzrechte der betroffenen Person
Bei Verarbeitung personenbezogener Daten stehen den betroffenen Personen folgende Datenschutzrechte zu:

* das Recht, jederzeit Auskunft über die Verarbeitung ihrer personenbezogenen Daten zu erhalten (Art. 15 DSGVO),
* das Recht auf Berichtigung unrichtiger Daten oder Vervollständigung lückenhafter Daten (Art. 16 DSGVO),
* das Recht, Daten nach den gesetzlichen Vorgaben löschen oder in der Verarbeitung einschränken zu lassen (z.B. bei Widerruf ihrer Einwilligung oder unrechtmäßiger Verarbeitung) (Art. 17, 18 DSGVO),
* das Recht, bei einer auf Einwilligung beruhenden Datenverarbeitung ihre Einwilligung jederzeit mit Wirkung für die Zukunft zu widerrufen (Art. 7 Abs. 3 DSGVO),
* das Recht auf Datenübertragbarkeit (der Nutzer kann eine Übersicht seiner Daten in einem elektronischen Format zur Verfügung gestellt bekommen) (Art. 20 DSGVO),
* das Recht auf Widerspruch gegen die Datenverarbeitung (Art. 21 DSGVO)
* das Recht, zu allen mit der Verarbeitung ihrer personenbezogenen Daten in Zusammenhang stehenden Anliegen den Verantwortlichen für den Datenschutz zu kontaktieren (Art. 38 Abs. 4 DSGVO) und
* das Recht, sich bei der zuständigen Aufsichtsbehörde für den Datenschutz zu beschweren, (Die Bundesbeauftragte für den Datenschutz und die Informationsfreiheit, Husarenstr. 30 - 53117 Bonn, +49 (0)228 997799-0, E-Mail: poststelle@bfdi.bund.de, https://www.bfdi.bund.de/) (Art. 77 Abs. 1 DSGVO).


Stand und Änderungen der Datenschutzerklärung
Diese Datenschutzerklärung hat den Stand vom 26. April 2021.

Da durch neue Technologien und die ständige Weiterentwicklung der App Änderungen an ihrer Datenschutzerklärung vorgenommen werden können, wird empfohlen, sich die Datenschutzerklärung in regelmäßigen Abständen wieder durchzulesen.

                    ''',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
