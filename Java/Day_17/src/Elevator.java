import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class Elevator {
/*
 * 주제 : 엘리베이터 구현

- 조건 -

엘리베이터는 4명이 탑승이 가능하며, 총 3개 층으로 이루어져있음.

탑승객은 목표 층을 입력하여 해당 층이 되면, 자동으로 내리게 구현.

엘리베이터는 무조건 올라갔다가 내려가는 형태로 이동.
 */
	Scanner sc= new Scanner(System.in);
	List<HashMap<String, Integer>> elevator = new ArrayList<HashMap<String, Integer>>();

	int[] floor = {1,2,3};
	int cnt = 0; //탑승인원
	int now =0; //현재위치
	public void run() {
		boolean flag = true;
		
		while(flag) {
			System.out.println("엘리베이터에 가 열립니다. (현재 탑승인원 : "+cnt+"명)");
			System.out.println("1.탑승\t2.내리기\t3.올라가기\t4.내려가기\t5.종료");
			String menu = sc.nextLine();
			switch(menu) {
			case "1": get();
					break;
			case "2": off();
					break;
			case "3": up();
					break;
			case "4": down();
					break;
			case "5": flag= false;
				System.out.println("엘레베이터 운행 정지합니다.");
					break;
					default:
						System.out.println("잘못입력하셨어유 ");
					
			}
			
		}
	}//run 메소드 종료

	public void get() {
		HashMap<String, Integer> a = new HashMap<String, Integer>();
		
		if(cnt<4 ) {
			for(int i = 0; i< floor.length; i++) {
				System.out.println("탑승 가능 합니다. 현재 "+floor[i]+"층입니다. 올라가시는층수를 눌러주세요");
				System.out.println(("1번."+floor[0]+"층"));
				System.out.println(("2번."+floor[1]+"층"));
				System.out.println(("3번."+floor[2]+"층"));
				
				String choice=sc.nextLine();
				int input = Integer.parseInt(choice)-1;
		
				if(now !=input) {
					System.out.println(floor[input]+"층을 누르셨습니다.");
					a.put("floor", input);
					elevator.add(a);
					cnt++;
				
					break;
					}
				else {
					System.out.println("현재 누르신 층수에 있습니다 다시 눌러주세요");
				}
			}
		}
		else {
			System.out.println("탑승인원을 초과했습니다. 내려주세요");
		}
		System.out.println("현재 탑승인원 : "+cnt+"명");
	}//get 메소드 종료
	
	
	public void off() { //목적지 하차
		if(cnt>0) {
			for(int i =0; i<elevator.size(); i++) {
				if(elevator.get(i).get("floor")==now) {
					System.out.println(" 누르신 "+(now+1)+"층에  도착하셨습니다. 하차해주세요");
					elevator.remove(i);
					i--;
					cnt--;
				}else {
					System.out.println("누르신 층수가 아닙니다. 기다려주세요");
				}
			}
		}else {
			System.out.println("탑승인원이 없습니다.");
		}
			
	}//down 메소드
	
	public void up() {
		if(now<=3) {
			now++;
			System.out.println("현재  "+(now+1)+"층입니다.");
		}else {
			System.out.println("더 이상 올라갈 층입없습니다.");
		}
	} //up메소드
	
	public void down() {
		if(now>0) {
			now--;
			System.out.println("현재  "+(now+1)+"층입니다.");
		}else {
			System.out.println("더 이상 내려갈 층이없습니다.");
		}
	} //up메소드
}//클래스 종료
