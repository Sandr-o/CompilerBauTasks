JNI JAVA <-> C++

1. implement native methods
2. create with "javac -h . <file>.java --> creates a header file
3. copy generated methods from header file in a new cpp file
4. define something to do something with the input 
5. compile and link

g++ -c -fPIC -I${JAVA_HOME}/include -I${JAVA_HOME}/include/linux JNITutorial.cpp -o libtest.o

6. create shared library

g++ -shared -fPIC -o libtest.so libtest.o -lc

7. run programm

java -Djava.library.path=. HelloJNI


--------------------------------------
javac -h . HelloJNI.java
g++ -fPIC -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/linux" -shared -o libhello.so HelloJNI.cpp
java -Djava.library.path=. HelloJNI