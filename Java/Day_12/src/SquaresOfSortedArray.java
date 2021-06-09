import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SquaresOfSortedArray {
	public static void main(String[] args) {
		double temp=0;

		int[] nums= {-4,-1,0,3,10};
		List<Double> after= new ArrayList<Double>();
		for(int i =0; i<nums.length; i++) {
			after.add(Math.abs(Math.pow(nums[i], 2)));
		}
		for(int i =0; i<nums.length-1; i++) {
			for(int j=i+1; j<nums.length; j++) {
				if(after.get(i)>after.get(j)) {
					temp=after.get(i);
				}
			}
		}
	}

}
