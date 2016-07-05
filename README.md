# Online TV Recorder / otrkey Dekode, Schnitt, Umwandeln in h264 für Playstation, iPhone, iPad, MacOS, Android

Docker Image mit allen Komponenten um otrkey Dateien von http://onlinetvrecorder.com zu bearbeiten.
Ziel ist eine möglichst automatische Bearbeitung.

Komponenten:
	
* Easydekoder
* multicut_light
* ffmpeg

Abhängigkeiten:

* avidemux 2.5.6
* Ubuntu 14.04
* angepasstes multicut_light um avidemux ohne Nachfragen laufen zu lassen

## Usage

### Batch - Dekodieren, Schneiden, Umwandeln in h264, Aufräumen

* Man benötigt Docker: https://www.docker.com/products/docker-toolbox#/resources (Dies ist die zZ des Schreibens stabile 1.11 Version, Bleeding Edge ist 1.12)
* Man muss dem Programm einige Angaben mitgeben
** email: Die E-Mail Adresse die man bei www.onlinetvrecorder.com zum Einloggen nutzt
** password: Das Passwort zum Einloggen bei www.onlinetvrecorder.com
** cutlistAtUrl: Die "Persönliche Server-URL" von http://cutlist.at (Nach Registrierung oben rechts im Menü)
** Das Verzeichnis in dem sich die .otrkey Dateien befinden (hier: _~/Downloads:_)
* _docker run -e "email=bla@fasel.de" -e "password=geheim" -e "cutlistAtUrl=http://cutlist.at/user/h52hm126h" -v ~/Downloads:/otr develcab/otr_


### Manuell

	Man kann das Image auch manuell benutzen wenn man zB garnicht umwandeln möchte.
	Hierbei muss man nur den Ordner spezifizieren in dem man arbeiten möchte (hier _~/Downloads_)
	
	_docker run -ti -v ~/Downloads:/otr develcab/otr bash_
	
	Man kann _otrdecoder_, _multicut.sh_, _avidemux_ und _ffmpeg_ auf der Kommandozeile nutzen.
	Nano, curl und wget sind auch installiert.
	
	Ganz wichtig: Änderungen die man in einem laufenden Container vornimmt (also Software installieren, Einstellungen
	im System vornehmen usw.) werden nicht dauerhaft gespeichert.
	Wenn man den Container stoppt und wieder startet sind Änderungen weg.
	
	
## Docker?

	http://www.heise.de/developer/artikel/Anwendungen-mit-Docker-transportabel-machen-2127220.html
	
* Läuft auf Mac, Linux, Windows
* Läuft auf Ubuntu 16, obwohl nur 14 drin ist
* Läuft auf (stärkeren) NAS Laufwerken (Synology, Qnap, ...)

	Die Lauffähigkeit auf einem, noch zu kaufenden, NAS ist hier für mich Ausschlag gebend.
	
	Außerdem habe ich bei der Entwicklung des Images wegen avidemux mehrere Ubuntu Versionen ausprobiert 
	bevor ich die richtige Version hatte.
	Hätte ich viermal ein neues System in einer VM installiert wäre es wesentlich aufwendiger als 
	die erste Zeile des _Dockerfile_ von _FROM ubuntu:16.04_ zu _FROM ubuntu:14.04_ usw. zu ändern.
	
	Eigentlich ist das ein Paradebeispiel Pro Container.


# HowTo build the project

* Required: Docker >1.11
* Goto folder _src/main/docker_
* _docker build -t develcab/otr ._


## Customize

	Ich denke die meisten wollen den Batch Modus, aber brauchen vielleicht die Umwandlung des Videos für iPad und Playstation nicht,
	oder wollen andere Video Einstellungen usw.
	
	Dazu gibt es 
	
	* .multicut_light.rc - hier sind die Einstellungen für Multicut hinterlegt.
	** Wenn man zB lieber gefragt werden will wie das File nach dem Schneiden heißen soll, kann man hier die Zeile: 
		_avidemuxOptions="--force-smart" ergänzen und überschreibt damit meine Änderungen und erhält den Multicut Original
		Zustand
	* auto.sh
	** Dieses Skript wird im Automatischen Modus ausgeführt
	** Hier findet sich in der obersten convert function die Einstellungen für ffmpeg
	** Unten kann man die einzelnen Blöcke des Ablaufs erkennen
	** Man kann zB die Zeilen unter _# cleanup_ ändern wenn man einige Zwischenschritte behalten möchte
	* Dockerfile
	** Mit dem Dockerfile wird das Image gebaut, hier steht also welche Version wovon genutzt wird
	** Wenn man zB lieber ein anderes Schnitt-Script nutzen will könnte man hier den Download ergänzen
	
	