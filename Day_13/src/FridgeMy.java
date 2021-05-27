import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class FridgeMy {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		// 문제4 다음조건에 해당하는 냉장고 프로그램을 구현하시오.
		/*
		 * 	  조건1. 냉장고 총 크기는 50 조건
		 *   조건2. 냉장고에 넣을 수 있는 품목은 계란(크기 1, 유통기한 3일), 우유(크기3, 유통기한 5일),수박(크기 5,유통기한 7일)
		 *   조건3. 냉장고에 집어넣고 유통기한이 지날 경우 자동페기됨
		 *   조건4. 날짜는 다음날로 이동기능을 구현하여 한번에 1일씩 지나가게 구현 
		 *   조건5. 냉장고에 품목 추가 시 50의 크기를 넘게 될 경우 냉장고 보관 불가능 
		 *   조건6. 하루에 집어 넣을수있는 품목의 상한의 없음 조건 조건 
		 * 7. 현재 보관 품목과 유통기한을 확인 할 수 있는 조회기능 구현
		 */
		// 냉장고 총 크기는 50
			int size = 50;
			boolean flag= true;
			
			List<Integer>egg=new ArrayList<>();
			List<Integer>milk=new ArrayList<>();
			List<Integer>watermelon=new ArrayList<>();
			while(flag) {
				System.out.println("1.품목담기\t2.다음날\t3.상태체크\t4.종료");
				String menu=sc.nextLine();
				int fridge= (egg.size()*1)+(milk.size()*3)+(watermelon.size()*5);
				switch(menu) {
				
				case "1":
					System.out.println("무엇을 담으시겠습니까? 1.계란\t2.우유\t3.수박");
					String product=sc.nextLine();
					switch(product) {
					
					case "1":
					//비어있어야 넣을 수 있기에 먼저 냉장고 용량 체크를 if로 해줘야한다.
					if(fridge+1<=50) {
						egg.add(3); //유통기한
						System.out.println("계란 개수 : "+egg.size());
						System.out.println("냉장고 용량 : "+(fridge+1));
					}
					else {
						System.out.println("50을 넘어서 추가로 담을 수 없습니다.");
						flag=false;
					}
					break;
					
					case "2":
						
						if(fridge+3<=50) {
							milk.add(5);
							System.out.println("우유 개수 : "+milk.size());
							System.out.println("냉장고 용량 : "+(fridge+3));
						}
						else {
							System.out.println("50을 넘어서 추가로 담을 수 없습니다.");
							flag=false;
						}
						break;
					
					case "3":
					
						if(fridge+5<=50) {
							watermelon.add(7);
						System.out.println("수박 개수 : "+watermelon.size());
						System.out.println("냉장고 용량 : "+(fridge+5));
						
					}
						else {
							System.out.println("50을 넘어서 추가로 담을 수 없습니다.");
							flag=false;
					}
						break;
					}
					break;
				case "2": //유통기한
					System.out.println("다음날입니다.");
					for(int i =0; i < egg.size(); i++) {
					egg.set(i, egg.get(i)-1);
					System.out.println("계란남은 유통기한 :"+egg.get(i)+"일 남았습니다");
					if(egg.get(i)==0) {
						System.out.println("계란을 페기합니다.");
						egg.remove(i);
						i--;
					break;
					}
				}	
					for(int i =0; i < milk.size(); i++) {
						milk.set(i, milk.get(i)-1);
					System.out.println("우유남은 유통기한 : "+milk.get(i)+"일 남았습니다");
					
					if(milk.get(i)==0) {
						System.out.println("우유을 페기합니다.");
						milk.remove(i);
						i--;
					break;
					}
				}	
					for(int i =0; i < watermelon.size(); i++) {
						watermelon.set(i, watermelon.get(i)-1);
					System.out.println("우유남은 유통기한 : "+watermelon.get(i)+"일 남았습니다");
					
					if(watermelon.get(i)==0) {
						System.out.println("우유을 페기합니다.");
						watermelon.remove(i);
						i--;
					break;
					}
				}	
				break;
				case "3":
					System.out.println("냉장고 상태체크");
					System.out.println("egg 개수 확인"+egg.size());
					System.out.println("milk개수 확인"+milk.size());
					System.out.println("watermelon개수 확인"+watermelon.size());
					break;
				case "4":
					System.out.println("종료합니다");
					flag = false;
					break;
				default: 
					System.out.println("잘못 입력하셔습니다.");
				}
			}
			
	}
}
