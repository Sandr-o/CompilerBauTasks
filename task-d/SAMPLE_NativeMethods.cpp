#include "NativeMethods.h"
#include <iostream>
#include <jni.h>
#include <cstring>
#include <cctype>
using namespace std;
/*
 * Class:     Example1
 * Method:    intMethodName
 * Signature: (I)I
 */

JNIEXPORT jint JNICALL Java_NativeMethods_intMethodName (JNIEnv *env, jobject obj, jint num) {
  return num * num;

}

/*
 * Class:     Example1
 * Method:    booleanMethodName
 * Signature: (Z)Z
 */
JNIEXPORT jboolean JNICALL Java_NativeMethods_boolMethodName (JNIEnv *env, jobject obj, jboolean boolean) {
    return !boolean;
  }

/*
 * Class:     Example1
 * Method:    stringMethodName
 * Signature: (Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_NativeMethods_stringMethodName (JNIEnv *env, jobject obj, jstring string) {
   const char* str = env->GetStringUTFChars(string, nullptr);
   char  *charArr = new char[env->GetStringUTFLength(string)];
   strcpy(charArr, str);
   env->ReleaseStringUTFChars(string, str);
   for (int x=0; x<strlen(charArr); x++)
        charArr[x] = toupper(charArr[x]);
   auto retVal = env->NewStringUTF(charArr);
   delete[] charArr;
   return retVal;

  }

/*
 * Class:     Example1
 * Method:    intArryMethodeName
 * Signature: ([I)I
 */
JNIEXPORT jint JNICALL Java_NativeMethods_intArrayMethodName (JNIEnv *env, jobject obj, jintArray array) {
   jint sum = 0;

   jsize length = env->GetArrayLength(array);
   jint *data = env->GetIntArrayElements(array,0);
   

   for (jsize i = 0; i < length; i++) {
      sum += data[i];
   } 
  env->ReleaseIntArrayElements(array, data, 0);
  return sum;
   
  }