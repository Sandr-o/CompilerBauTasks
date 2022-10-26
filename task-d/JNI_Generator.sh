#!/bin/bash
echo "======================="
echo "==== JNI GENERATOR ===="
echo "======================="
echo $'by Sandro Bühler & Sarah Hägele\n\n'

echo $'\nThis little Script generates some JNI-compatible Java-Code and executes C++-Code within Java via the Java Native Interface (JNI).'
sleep 2

echo $'\n==== Step 1: Generating NativeMethods.java...'
yml2proc -y gen_native_java.yml2 dsl.yml2 >> NativeMethods.java
sleep 1
echo "Yay! NativeMethods.java generated!"

echo $'\n==== Step 2: Generating JNIGenerated.java...'
yml2proc -y class_gen.yml2 dsl.yml2 >> JNIGenerated.java
sleep 1
echo "Yay! JNIGenerated.java generated!"

echo $'\n==== Step 3: Generating Header-File from JNIGenerated.java...'
javac -h . JNIGenerated.java
sleep 1
echo "Yay! Header-File generated!"

echo $'\n==== Step 4: Generating .cpp file to edit...'
touch NativeMethods.cpp
sleep 4
clear

echo 'IMPORTANT! Waiting for User to provide function implementations in NativeMethods.cpp. Press [c] to continue when done!'
read answer

if [ "$answer" != "${answer#[Cc]}" ] ;then 
    echo "Great, let's continue!"
    echo $'\n==== Step 5: Generating shared library libjnigenerated...'
    g++ -fPIC -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" -shared -o libjnigenerated.so NativeMethods.cpp
    sleep 1
    echo "Yay! Shared library generated!"
    
    echo $'\n==== Step 6: Executing NativeMethods.java... here are your results:'

    java -Djava.library.path=. JNIGenerated
    sleep 1
else
    echo $'\nInvalid command! You killed it! Bye!'
    exit
fi

echo $'\nAnd that is it! Pretty cool, huh? Thanks for using this little script!'