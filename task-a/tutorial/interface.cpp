#include <string>
using namespace std;
class Interface {
   public:
      // pure virtual function
      virtual int intMethodName(int n) = 0;
      virtual bool booleanMethodName(bool b) = 0;
      virtual string stringMethodName(string text) = 0;
      virtual int intArrayMethodName(int intArray[]) = 0;
};
