
public class Test12 {
	public static void main(String[] args) {
		
		int[] arr = {1, 2, 3};
		
		System.out.println(arr[0]);
		
		arr[1] = 5;
		System.out.println(arr[1]);
		
		System.out.println(arr.length);
		//length은 몇 칸 가지고 있는 지 알려준다
	
		for(int i= 0; i< arr.length; i++) {
			System.out.println(arr[i]);
		}
		System.out.println("--------------------");
	
		int [] num = {3, 2, 1};
		int  temp = 0;
		//오름차순으로 정렬하시오.
		//if만으로 구현 해본 후 for문을 활용하여 구현
//		if(num[0]> num[1]) {
//			temp = num[0];
//			num[0] = num[1];
//			num[1] = temp;
//		}
//		if(num[0]> num[2]) {
//			temp = num[0];
//			num[0] = num[2];
//			num[2] = temp;
//		}
//		if(num[1]> num[2]) {
//			temp = num[1];
//			num[1] = num[2];
//			num[2] = temp;
//		}
		for(int i = 0; i<num.length-1; i++) {
			for(int j = i+1; j < num.length; j++) {
			if(num[i] > num[j]) {
				temp = num[i];
				num[i] = num[j];
				num[j] = temp;
				
			}
			}
		}
		//출력 3,5,7 한 줄씩
		for(int i =0 ; i < num.length; i++) {
			System.out.println(num[i]);
		
		}
	
	}
}
