import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class ElevatorAS {
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
	int pos=-1;
	public void run() {
		boolean flag = true;
		
		while(flag) {
			System.out.println("엘리베이터에 가 열립니다. (현재 탑승인원 : "+cnt+"명)");
			System.out.println("1.탑승\t2.이동\t5.종료");
			String menu = sc.nextLine();
			switch(menu) {
			case "1": get();
					break;
			case "2": move();
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

		if (cnt >3) {
			System.out.println("탑승인원이 초과했습니다.");
		} else {
			if (now >= 0) {
				System.out.println("어디로 가시겠습니까?  현재" + (now + 1) + "층입니다.");
				for (int i = 0; i < floor.length; i++) {
					if (now != i) {
						System.out.println((i + 1) + "." + (i + 1) + "층");
					}
				}
				String choice = sc.nextLine();
				int input = Integer.parseInt(choice) - 1;
				
				if (input == now) {
					System.out.println("현재층수입니니다 다시 눌러주세요");
				} else if (input > 2) {
					System.out.println("잘못된 층수를 입력했습니다. 다시눌러주세요");
				} else {
					a.put("floor", input);
					elevator.add(a);
					cnt++;
				}

			}
		}
}//get메소드 종료
	
	public void move() {//자동으로 3층 찍으면 내려오기
		if(now ==0 || now==2) {
			pos*=-1;
		}
		now+=pos;
		if(cnt>=0) {
			if(now>0) {
			System.out.println("현재 "+(now+1)+"층에 도착했습니다.");
			for(int i = elevator.size()-1; i>=0; i--) {
				if(elevator.get(i).get("floor")==now) {
					elevator.remove(i);
					cnt--;
				}
			}
		}else {
			
			System.out.println("탑승해 있는 사람이 없습니다. 현재"+(now+1)+"층입니다.");
		}
	}		
	
	}//move메소드 종료
	

}//클래스 종료
