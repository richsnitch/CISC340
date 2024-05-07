float data[] = {9.24, 1.15, 3.91, -2.30, 7.43, 5.79, -6.83, 3.14};
int size = 8;

/**
 * average is passed the base address of the array of floats and
 * its size.  It prompts the user for the number of elements from
 * the array to average, it then averages all the positive elements 
 * in that length, and prints the result.
 */
public static void averagePositive(float nums[], int size) {
    Scanner scan = new Scanner(System.in);

    System.out.println("How many should be averaged?");
    int n = scan.nextInt();
    int numPos = 0;
    if (n > size){   // don't average more than there are
        n = size;}

    float sum = 0.0;
    for(int i=0; i<n; i++){
        if(nums[i]>0){
            sum = sum + nums[i];
            numPos = numPos + 1;
        }
    }

    System.out.println("The average is " + (sum / numPos));
}
