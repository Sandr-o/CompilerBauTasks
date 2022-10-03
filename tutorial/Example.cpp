#include "Example1.h"
#include <string.h>

JNIEXPORT jint JNICALL Java_Example1_intMethodName(JNIEnv *env, jobject obj, jint num){
    return num * num;
}
JNIEXPORT jboolean  JNICALL  Java_Example1_booleanMethodName(JNIEnv *env, jobject obj, jboolean boolean){
    return !boolean;
}

JNIEXPORT jstring JNICALL Java_Example1_stringMethodName(JNIEnv *env, jobject obj, jstring string){
   const char *str = (*env)->GetStringUTFChars(env, string, 0);
   char cap[128]
   strcpy(cap, str);
   (*env)->ReleaseStringUTFChars(env, string, str);
   return (*env)->NewStringUTF(env, strupr(cap));
}

JNIEXPORT jint JNICALL Java_Example_intMethodName(JNIEnv *env, jobject obj, jintArray array){
    int i, sum = 0;
    jsize len = (*env)->GetArrayLength(env, array);
    jint *body = (*env)->GetIntArrayElements(env, array, 0);
    for(i= 0; i<len; i++) {
        sum += body[i];
    (*env)->ReleaseIntArrayElements(env, array, body, 0);
    return sum;
}
void main(){}