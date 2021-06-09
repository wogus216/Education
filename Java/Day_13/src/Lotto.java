import java.util.Arrays;
import java.util.Scanner;

public class Lotto {

	public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
	boolean flag = true;
	while(flag) {
		System.out.println("1.시작\t2.종료");
		String menu = sc.nextLine();
		
		switch(menu) {
		case "1":
			int cnt = 0;
			//로또 개수 입력
			while(true) {
				System.out.println("로또 개수를 입력하세요. (숫자만 입력하세요)");
			try {
				cnt = Integer.parseInt(sc.nextLine());
				break;
			}catch (Exception e) {
				e.printStackTrace();
				}
			}
			
			int[] lotto= new int[6];
		for(int k = 0 ; k< cnt;  k++) {	
			for(int i = 0; i < lotto.length; i++) {
				//로또번호 추력
				lotto[i]= (int)Math.floor(Math.random()*10)+1;
				
				for(int j = 0; j < i ; j++) {
					//중복값 체크
					if(lotto[i]==lotto[j]) {
						i--;
						break; //불필요한 실행 횟수 제거
						}
					}
				}
			//오름차순 정렬
			Arrays.sort(lotto);
			//로또 번호  toString 으로 출력
			System.out.println(Arrays.toString(lotto));
		}
			break;
		case "2":
			//while문 종료 만들기
			flag = false;
			System.out.println("종료합니다.");
			break;
			
			default:
				System.out.println("잘못입력했습니다.+");
					
			}
		}
	}
}
