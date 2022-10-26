# Compilerbau - JNI <-> C++

Dieses Projekt wurde von Sandro Bühler und Sarah Hägele als Programmentwurf für das Fach Compilerbau verfasst. Aus einer simplen, in YML2 verfassten DSL kann ein JNI-Interface sowie eine Implementierung des Interface in Java generiert werden. Letztere kann unter Verwendung von `javac -h` nativen C++-Code in Java ausführen (Anmerkung: es wurde `javac` anstatt `javah` verwendet, da letzteres in neueren Versionen des JDK nicht mehr verfügbar ist und die relevanten Funktionalitäten quasi durch `javac` ersetzt wurden).

## Aufgabenteil a)
Enthalten im Verzeichnis `task-a`. 

Realisierung des JNI-Beispiels aus dem in der Aufgabenstellung bereitgestellten Tutorial.

## Aufgabenteil b)
Enthalten im Verzeichnis `task-b`. 

Implementierungen eines die vier im Tutorial behandelten Methoden enthaltenden Interfaces in Java und C++. In C++ wurde dies als abstrakte Klasse durch die Verwendung von `virtual`-Funktionen realisiert. Für die Java-Implementierung lag zunächst natürlich der Gedanke nahe, ein tatsächliches Java-Interface zu definieren. Dieses lässt allerdings keine `native`-Methoden zu, welche für die Verwendung der JNI später nötig sind, weshalb das Interface stattdessen als normale Klasse mit Methodensignaturen realisiert wurde.

## Aufgabenteil c)
Enhalten im Verzeichnis `task-c`.

Eine sprachenunabhängige Beschreibung eines Interface in YML2, welches die vier Methoden enthält. Die folgende Tabelle liefert eine Art Legende zur definierten DSL.

| Bezeichnung | Erklärung |
|---|---|
| entity | Art des Interface (z.B. Class, Interface etc.) |
| @name | Name der Entity/des Interface |
| nfunc | (Native) Methode/Funktion |
| @ftype | Rückgabetyp der nfunc |
| @fname | Name der nfunc |
| @ptype | Parametertyp der nfunc (für dieses Beispiel wird angenommen, dass alle Funktionen nur einen Parameter besitzen) |
| @pname | Name des Parameters |
| I | Integer-Datentyp |
| IA | Integer-Array-Datentyp |
| S | String-Datentyp |
| B | Boolean-Datentyp |

## Aufgabenteil d)
Enthalten im Verzeichnis `task-d`.

Mehrere Generatoren wurden implementiert, welche unter Verwendung von `yml2proc` aus der simplen DSL aus Aufgabenteil c) Code für verschiedene Anforderungen generieren können.

- `template_cpp.yml2`: generiert das C++-Interface aus der DSL.
- `gen_native_java.yml2`: generiert das Java-Interface aus der DSL.
- `class_gen.yml2`: generiert eine Java-Klasse mit einer main-Methode, welche ein das Interface implementierendes Objekt instanziiert und dessen native Methoden gemäß JNI-Definition aufruft, sodass darauf `javac -h` angewandt werden kann.

Das Shell-Script `JNI_Generator.sh` kann die Schritte zur Generierung des Java- und C++-Codes und die Ausführung der Methoden in Java weitestgehend automatisieren. Hierfür ist vorausgesetzt, dass die Umgebungsvariable `JAVA_HOME` gesetzt ist und auf eine valide JDK-Installation verweist. Das Script wurde unter Ubuntu entwickelt und getestet - eventuell müssten für andere Betriebssysteme Befehle oder Pfade im Script abgeändert werden.

Im Grunde führt das Script die folgenden Schritte aus:

1. Die Java-Implementierungen für das Interface (`NativeMethods.java`) und die ausführbare Klasse (`JNIGenerated.java`) werden unter Verwendung von `yml2proc` aus der DSL generiert.
2. Ein Header-File (`JNIGenerated.h`) wird durch den Befehl `javac -h` aus `JNIGenerated.java` generiert.
3. Ein leeres cpp-File wird generiert. An dieser Stelle wartet das Script auf Userinput. Der User muss die im Header-File enthaltenen Funktionsköpfe in die cpp-Datei übertragen und die Funktionen vollständig definieren (Bodys hinzufügen). Als Beispiel für ein solches vollständig definiertes cpp-File dient `SAMPLE_NativeMethods.cpp` (dieses kann auch direkt verwendet werden; hierfür muss es zu `NativeMethods.cpp` umbenannt werden und das leere vom Script generierte cpp-File muss entfernt werden).
4. Ist die C++-Implementierung der Funktionen erfolgt, kann der User im Script die Fortsetzung des Programms bestätigen.
5. Ist die Bestätigung erfolgt, wird mit Hilfe von g++ eine Shared Library namens `libjnigenerated.so` aus dem cpp-File generiert.
6. Die Java-Datei `JNIGenerated.java`, welche die main-Methode enthält, wird ausgeführt und die Ergebnisse der vier nativen Methodenaufrufe ausgegeben.

