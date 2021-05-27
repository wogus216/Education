import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class ProblemDice_Lotto {

	public static void main(String[] args) {
	Scanner sc = new Scanner(System.in); 
	//1.원하는 주사위 와 주사위 개수를 입력 받아 그결과를 확인하는 프로그램을 구현하시오.
	System.out.println("원하는 주사위를 입력해주세요");
	int dicenum= sc.nextInt();
	System.out.println("주사위는 "+dicenum+"면체입니다");
	
	System.out.println("원하는 주사위개수를 입력해주세요");
	int cnt=sc.nextInt();
	System.out.println("주사위는"+cnt+"번굴려야 합니다.");
	
	for(int i = 0; i<cnt; i++) {
//		int dice=(int) Math.floor(Math.random()*dicenum)+1;
		int dice=(int) (Math.random()*dicenum)+1;
		System.out.println(dice);
	}
	System.out.println("--------------------------");
	
	
	
	//2. 원하는 개수를 입력받고 그 개수 만큼 로또 번호를 생성하는 프로그램을 구현하시오.
	System.out.println("원하는 로또 횟수");
	int times =sc.nextInt(); //횟수
	int[] lotto =new int[6]; //로또 번호 생성
	
		for(int k =0; k<times; k++) {
		for(int i = 0; i<lotto.length; i++) {
			lotto[i]=(int)(Math.random()*6)+1;
			for(int j =0; j <i; j++) {
				if(lotto[i]==lotto[j]) {
					i--;
				}
			}
		}
		System.out.println("로또 번호는"+lotto[0]+","+lotto[1]+","+lotto[2]+","+lotto[3]+","+lotto[4]+","+lotto[5]);
		}
	}
}
