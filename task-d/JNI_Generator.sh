#!/bin/bash
echo "This is a generator to ..."

echo "generating NativeMethods.java..."
python3 yml2proc -y gen_native_java.yml2 dsl.yml2 >> NativeMethods.java
echo "NativeMethods.java generated!"

echo "\ngenerating JNIGenerated.java..."
python3 yml2proc -y class_gen.yml2 dsl.yml2 >> JNIGenerated.java
echo "JNIGenerated.java generated!"

echo "Generating Header-Files from JNIGenerated.java"
javac -h . JNIGenerated.java
echo "Generating .cpp file to edit"
touch NativeMethods.cpp
sleep 4
clear

echo 'Waiting for editing NativeMethods.cpp - Press [c] to continue!'
read answer

if [ "$answer" != "${answer#[Cc]}" ] ;then # this grammar (the #[] operator) means that the variable $answer where any Y or y in 1st position will be dropped if they exist.
    echo Yes
    echo "Generating library from "
    g++ -fPIC -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" -shared -o libjnigenerated.so NativeMethods.cpp

    echo "executing Java-File"

    java -Djava.library.path=. JNIGenerated
else
    echo No
    exit
fi





