import java.util.Scanner;

public class Dice {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		boolean flag = true;
		while(flag) {
			System.out.println("1.시작\t2.종료");
			String menu = sc.nextLine();
			
			switch(menu) {
			case "1":
				int dice ;
				int cnt;
				//주사위 종류 입력
			while(true) {
				System.out.println("주사위 종류를 입력하세요. (숫자만 가능)");
				try {//인트로 형변환
					 dice = Integer.parseInt(sc.nextLine());
					 break;
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			//주사위 개수 입력
			while(true) {
				System.out.println("주사위 개수를 입력하세요. (숫자만 가능)");
				try {
					cnt = Integer.parseInt(sc.nextLine());
					break;
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			break;
			
			case "2":
				flag = false;
				System.out.println("종료합니다.");
				break;
			default:
				System.out.println("잘못입력했습니다.");
			}
		}

	}

}
