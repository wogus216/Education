
public class Day8TestAnswer {

	public static void main(String[] args) {
		//문제 2. 1~ 100 사이의 4배수 개수와 합을 구하시오.
		//개수와 합은 담을 변수가 두개 필요
		int cnt = 0; //개수
		int sum = 0; // 합
		
		for(int i = 1; i<=100; i++) {
			if(i % 4 == 0) {
				cnt++;
				sum +=i;
			}
	}
		System.out.println("개수 :" + cnt+ ",합 :"+ sum );
		System.out.println("------------------------");
		//문제 3 54321초를 시간으로 제시
		String res ="";
		int val= 54321;
		// 1분 = 60초, 1시간 = 60분  1시간 = 60*60초= 3600초
		//시간
		if(val / 3600 >0) {//3599 부터 나누면 0보다 작다.
			res += val / 3600 + "시간";
			val %= 3600;
		}
		//분
		if(val / 60 >0) {
			res += val / 60 + "분";
			val %= 60;
			//분
			if(val >0) {
				res += val  + "초";
				}
		System.out.println(res);
			}
		System.out.println("------------------------");
		
		//문제1. 28,19, 87, 66, 45, 6, 79, 30, 96, 33 중 57에 가장 가까운수 
			//보관하는 게 제일 중요
		int[] arr= {28,19, 87, 66, 45, 6, 79, 30, 96, 33};
		int t = 57;
		//가까운수 = 대상과의 차이가 가장 작다.
		//인덱스 방식 쓰면서 차이를 비교해보자
		int low = 0; // 차이가  제일 작은 인덱스. 초기값은 배열의 첫인덱스 0
		
		for(int i = 1; i < arr.length; i++) {
			int lowRes = 57 - arr[low]; // 인덱스쪽 차이
			int nowRes = 57 - arr[i]; // 현재쪽 차이
			if(lowRes < 0) {
				lowRes *= -1;
			}
			if(nowRes < 0) {
				nowRes *= -1;
			}
			if(lowRes > nowRes) { //보관중인 인덱스 쪽의 차이가 더 큰 경우
				 low = i;
			}
		}
			System.out.println(arr[low]);
			//문제1. 28,19, 87, 66, 45, 6, 79, 30, 96, 33 중 57에 가장 가까운수 
		//w작은 값 처리
			int lowVal = arr[0]; // 차이가  제일 작은 값. 초기값은  배열의 첫번째 값
			
			for(int i = 1; i < arr.length; i++) {
				int lowRes = 57 - lowVal; // 인덱스쪽 차이
				int nowRes = 57 - arr[i]; // 현재쪽 차이
				if(lowRes < 0) {
					lowRes *= -1;
				}
				if(nowRes < 0) {
					nowRes *= -1;
				}
				if(lowRes > nowRes) { //보관중인 인덱스 쪽의 차이가 더 큰 경우
					 lowVal = arr[i];
				}
			}
				System.out.println(lowVal);
			
			
			
		}
}
