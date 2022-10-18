public class Example1 {
    static{
        System.loadLibrary("example");
    }
    public static void main(String[] args){
        NativeMethods nm = new NativeMethods();

        int square  = nm.intMethodName(5);
        boolean bool = nm.booleanMethodName(true);
        String text = nm.stringMethodName("JAVA");
        int sum = nm.intArryMethodeName(new int []{1,1,2,3,5,8,13} );

        System.out.println("intMethodName: " + square);
        System.out.println("booleanMethodName: " + bool);
        System.out.println("stringMethodName: " + text);
        System.out.println("intArrayMethodName: " + sum);
    }
}
