public class SawinNum{
   public static void main(String[] args) {
      //get input values for a, b from user
      Scanner scan = new Scanner(System.in);
      System.out.print("Enter a positive integer value: ");
      int a;
      a = scan.nextInt();
      System.out.print("Enter a positive integer value: ");
      int b;
      b = scan.nextInt();
      System.out.println("Sawin number for "+a+", "+b+" is " + sawinNum(a,b));
   }
   
   public static int sawinNum(int x, int y) {
      int result;
      System.out.println("Computing Sawin Numbers "+x+","+y);
      if (x == 0){
         result = y + 1;
      }else if (y == 0){
         result = sawinNum(x-1, 1);
      }else{ 
         result = sawinNum(x-1, sawinNum(x, y-1));
      }
      return result;
   } 
}
