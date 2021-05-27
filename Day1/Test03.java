	
public class Test03 {
	public static void main(String[] args) {
		int a = 3;
		
//		if(a > 5) {
//			System.out.println("결과 : a는 5보다 크다");
//		} else {
//			System.out.println("else결과  : a는 5보다 작거나 같다.");
//		}
		
		int score= 95;
		
		// 성적을 출력. a : 90 ~ 100, b : 80 ~ 89, c : 70 ~ 79, d : 60 ~ 69, f: 나머지
		if(score >= 90  ) {
			System.out.println("성적은 A 입니다.");
		}
		else if(score >= 80 ) {
			System.out.println("성적은 B 입니다.");
		}
		else if(score >= 70) { 
			System.out.println("성적은 C 입니다.");
		}
		else if(score >= 60) {
			System.out.println("성적은 D 입니다.");
		} 
		else {
			System.out.println("성적은 F 입니다.");
		}
	}
}
