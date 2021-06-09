import java.util.Scanner;

public class DiceAnswer {

	public static void main(String[] args) {
		//스캐너
		//1.원하는 주사위 와 주사위 개수를 입력 받아 그결과를 확인하는 프로그램을 구현하시오.
		Scanner sc = new Scanner(System.in);
		boolean flag =  true;
		while(flag) {
			System.out.println("1.시작 \t2.종료");
			String menu = sc.nextLine();
			
			switch(menu) {
			case "1":
				int dice ;
				int cnt ;
				//주사위 종류입력
				while(true) {
					System.out.println("주사위 종류를 입력하세요.(숫자만 입력하세요.)");
					try {//인트로 형변환
						dice = Integer.parseInt(sc.nextLine());
						break;
					} catch (Exception e) { //숫자아니면 캐치 발동
						e.printStackTrace();
						}
				}
				//주사위 개수 입력
				while(true) {
					System.out.println("주사위 개수를 입력하세요.(숫자만 입력하세요.)");
					try {
						cnt= Integer.parseInt(sc.nextLine());
						break;
					} catch (Exception e) {//숫자아니면 캐치
						e.printStackTrace();
						}
				}
				for(int i= 0; i < cnt; i++) {
					System.out.println((int)(Math.floor(Math.random()* dice))+1);
				}
				break;
				case "2": 
					flag=false;
					System.out.println("종료합니다.");
				break;
				default : 
					System.out.println("잘못입력했습니다.");
				
			}
		}
	}
}
