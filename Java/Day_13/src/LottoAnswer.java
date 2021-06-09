import java.util.Arrays;
import java.util.Scanner;

public class LottoAnswer {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		boolean flag = true;
		while(flag) {
			System.out.println("1.시작\t2.종료");
			String menu = sc.nextLine();
			
			switch(menu) {
			case "1" :
				int cnt = 0;
				//로또 개수 입력
				while (true) {
					System.out.println("로또 개수를 입력하세요. (숫자만 입력하세요.)");
					try {
						cnt= Integer.parseInt(sc.nextLine());
						break;
					} catch(Exception e) {
						e.printStackTrace();
					}
				}
				
				int[] lotto= new int [6];
				for(int i = 0; i < cnt; i++) {
					for(int k = 0; k < 6; k++) {
						//로또 번호 출력
						lotto[k] = (int)Math.floor(Math.random()*6)+1;
					
						for(int j = 0; j < k ; j++) {
							//중복 값 체크
							if(lotto[k] == lotto[j]) {
								k--;
								break;
							}
						}
					}
					//오름 차순 정렬
					Arrays.sort(lotto);
					//로또 번호 toString으로 출력
					System.out.println(Arrays.toString(lotto));
				}
				break;
			case "2":
				//while문 종료 만들기
				flag = false;
				System.out.println("종료합니다.");
				break;
			
			default: 
			//디풜트 1번이나 2번 아닌 숫자 입력시 발생
				System.out.println("잘못 입력했습니다.");
			}
		}
		
	}

}
