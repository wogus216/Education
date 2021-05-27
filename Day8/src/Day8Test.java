
public class Day8Test {

	public static void main(String[] args) {
		//2번
		int count =0;
		int sum=0;
		for(int i=1; i <= 100; i++) {
			if(i % 4 ==0) {
				count++;
				sum+=i;
			}
			
		}
		System.out.println(count);
		System.out.println(sum);
	System.out.println("---------------------");
//57이랑 빼서 차이 값 가장 작은 값을  찾으면 될듯하다	
	int lownum = 57;
	int resultA=0;
	int resultB=lownum;  //최소값
	int resulti= 0;
	int[] nums = {28, 19, 87, 66, 45,6,79,30,96,33};
		for(int i =0; i <nums.length; i++) {
			if(lownum>nums[i]) {
				resultA=lownum-nums[i];
				
			} else {
				resultA=nums[i]-lownum;
			}
			
			if(resultB>resultA) {
				resultB=resultA;
				resulti=nums[i];
			} 
	}
		System.out.println(resulti);
	System.out.println("-------------------------");
	//문제3
	int time = 3599;
	int h = 0;
	int m = 0;
	int s =0;
	int result= time;
				h=time/3600;
				time=time%3600;
				m=time/60;
				time=time%60;
				s=time/1;
			
System.out.println("결과 : "+result+"초 : "+h+"시간 "+m+"분 "+s+"초" );
	}
}
