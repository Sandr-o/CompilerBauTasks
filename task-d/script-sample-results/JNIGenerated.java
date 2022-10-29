    public class JNIGenerated {
        static{
            System.loadLibrary("jnigenerated");
        }
        public static void main(String[] args){
            NativeMethods nm = new NativeMethods();

            int square = nm.intMethodName(5);
            System.out.println("intMethodName: "+ square);
    
            boolean b = nm.booleanMethodName(true);
            System.out.println("booleanMethodName: "+ b);
    
            String text = nm.stringMethodName("java");
            System.out.println("stringMethodName: "+ text);
    
            int sum = nm.intArrayMethodName(new int []{1,1,2,3,5,8,13});
            System.out.println("intArrayMethodName: "+ sum);
    
        }
    }


