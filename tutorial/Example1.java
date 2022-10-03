public class Example1
{
    public native int intMethodName(int n);
    public native boolean booleanMethodName(boolean bool);
    public native String stringMethodName(String text);
    public native int intArrayMethodName(int[] intArray);

    public static void main(String [] args){
        System.loadLibrary("Example1");
        Example1 example = new Example1();

        int square = example.intMethodName(5);
        boolean bool = example.booleanMethodName(true);
        String text = example.stringMethodName("Hello World");
        int sum = example.intArrayMethodName(new int[]{1,1,2,3,5,8,13} );

        System.out.println("intMethodName" + square);
        System.out.println("booleanMethodName" + bool);
        System.out.println("stringMethodName" + text);
        System.out.println("intArrayMethodName" + sum);
    }
}