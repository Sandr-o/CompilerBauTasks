#!/bin/bash
echo $'\033[0;33m======================='
echo '==== JNI GENERATOR ===='
echo $'=======================\033[0m'
echo $'by Sandro Bühler & Sarah Hägele\n\n'

echo $'\nThis little Script generates some JNI-compatible Java-Code and executes C++-Code within Java via the Java Native Interface (JNI).'
sleep 2

echo $'\n\033[0;33m==== Step 1: Generating NativeMethods.java...\033[0m'
yml2proc -y gen_native_java.yml2 dsl.yml2 >> NativeMethods.java
sleep 1
echo "Yay! NativeMethods.java generated!"

echo $'\n\033[0;33m==== Step 2: Generating JNIGenerated.java...\033[0m'
yml2proc -y class_gen.yml2 dsl.yml2 >> JNIGenerated.java
sleep 1
echo "Yay! JNIGenerated.java generated!"

echo $'\n\033[0;33m==== Step 3: Generating Header-File from JNIGenerated.java...\033[0m'
javac -h . JNIGenerated.java
sleep 1
echo "Yay! Header-File generated!"

echo $'\n\033[0;33m==== Step 4: Generating .cpp file to edit.\033[0m If you wish for an empty .cpp file to be generated, press [c]. Press any other key to skip this step and proceed to the next step.'
read answer
if [ "$answer" != "${answer#[Cc]}" ] ;then 
    echo $'\nAlright, generating a .cpp file...'
    touch NativeMethods.cpp
else
    echo $'\nAs you wish, skipping .cpp file generation...'
fi
sleep 1

echo $'\n\033[0;31mIMPORTANT!\033[0m Waiting for User to provide function implementations in the generated NativeMethods.cpp file (or an own provided version of NativeMethods.cpp - note that the file must have this exact name!).\nSimply copy the provided function declarations from NativeMethods.h into NativeMethods.cpp, add necessary imports and make the functions do some fun things with the input!\n\033[0;31mPress [c] to continue when done!\033[0m'
read answer

if [ "$answer" != "${answer#[Cc]}" ] ;then 
    echo "Great, let's continue!"
    echo $'\n\033[0;33m==== Step 5: Generating shared library libjnigenerated...\033[0m'
    g++ -fPIC -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" -shared -o libjnigenerated.so NativeMethods.cpp
    sleep 1
    echo "Yay! Shared library generated!"
    
    echo $'\n\033[0;33m==== Step 6: Executing NativeMethods.java... here are your results:\033[0m'

    java -Djava.library.path=. JNIGenerated
    sleep 1
else
    echo $'\n\033[0;31mInvalid command!\033[0m Sorry, but you killed it! Bye!'
    exit
fi

echo $'\nAnd that is it! Pretty cool, huh? Thanks for using this little script!'