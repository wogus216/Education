

import java.util.Scanner;

public class SubwayService {
	/* 역은  총 5개로 순환열차임
	 * 차량은 총 4 차량, 각차량 당 탑승인원은 4명
	 *  탑승 시 목적지 지정. 목적지 도착시 자동하차
	 *  이동 시 1개역씩 이동
	 */
	String[] station = {"장승백이","연신내","강남","양재","평택"};
	int now = 0;
	//첫번째 배열 세로 두번째 배열 가로!!! -1은 빈자리를 의미하고 -1은 나올 수 없는 숫자
	int[][] trail = {{-1, -1, -1, -1},
					 {-1, -1, -1, -1},
					 {-1, -1, -1, -1},
					 {-1, -1, -1, -1}};
	int pos = -1; //방향전환을 위한 숫자
	Scanner sc = new Scanner(System.in);
	
	public void run() {
		boolean r = true;
		
		while (r) {
			System.out.println("=================================");
			System.out.println("현재역은 " + station[now] + "입니다.");
			System.out.println("=================================");
			System.out.println("메뉴를 선택하세요.");
			System.out.println("1.탑승 2.상세보기 3.이동 9.종료");
			
			switch(sc.nextLine()) {
			
			case "1" : join();
					   break;
			case "2" : status();
						break;
			case "3" : move();
						break;
			case "9" : r = false;
					   System.out.println("열차운행을 종료합니다.");
					   break;
			default : System.out.println("잘못입력하였습니다.");
			}
		}
	}

	public void join() {
		int imp = 0; //탑승 불가능한 열차수 카운트
		System.out.println("---- 탑승가능 현황 ----");
		
		for(int i = 0 ; i < trail.length ; i++) { //0부터 3까지  확인
			System.out.print((i + 1) + "호차 : ");
			if(checkTrail(i) > 0) { //지하철 호수 별로 빈칸이 있으면 탑승가능
				System.out.println("가능");
			} else {
				System.out.println("불가능");
				imp++; 
			}
		}
		
		if(imp == trail.length) {
			System.out.println("탑승가능 열차가 없습니다.");
		} else {
			System.out.println("어느 열차에 탑승하시겠습니까?");
			
			for(int i = 0 ; i < trail.length ; i++) {
				System.out.print((i + 1) + "." + (i + 1) + "호차 ");
			}
			System.out.println();
			
			String input = sc.nextLine();
			int t = Integer.parseInt(input) - 1;
			if(checkTrail(t) > 0) { //빈자리가 있으면 탑승가능
				System.out.println("목적지를 선택해 주세요.");
				for(int i = 0 ; i < station.length ; i++) {
					if(now != i) {//현재위치가 아니라면
						System.out.print((i + 1) + "." + station[i] + " ");
					}
				}
				
				System.out.println();
				String input2 = sc.nextLine();
				int s = Integer.parseInt(input2) - 1;
				
				if(s == now) {
					System.out.println("목적지로 현재역은 안됩니다.");
				} else {
					for(int i = 0 ; i < trail[t].length ; i++) {
						if(trail[t][i] == -1) { 
							trail[t][i] = s;
							break;
						}
					}
				}
				
			} else {
				System.out.println("탑승이 불가능합니다.");
			}
			
		}
	}
	
	public void status() {
		System.out.println("---- 열차 현황 ----");
		
		for(int i = 0 ; i < trail.length ; i++) {
			System.out.print((i + 1) + "호차 : ");
			for(int j : trail[i]) {
				if(j > -1) {
					System.out.print("[" + station[j] + "]");
				}
			}
			System.out.println();
		}
	}

	public void move() {
		
		if(now == station.length - 1 || now == 0) {
			pos *= -1;
		}
		
		now += pos;
		
		int cnt = 0;
		for(int i = 0 ; i < trail.length ; i++) {
			for(int j = 0 ; j < trail[i].length ; j++) {
				if(trail[i][j] == now) {//목적지와 현재위치가 같으면 하차
					cnt++; //하차 카운트
					trail[i][j] = -1;
				}
			}
		}
		
		if(cnt > 0) {
			System.out.println(cnt + "명이 하차하였습니다.");
		}
	}
	
	public int checkTrail(int num) {
		int cnt = 0; //빈자리 카운트
				//지하철 호수 별로 빈자리 확인
		for(int target : trail[num]) {
			if(target == -1) {
				cnt++;
			}
		}
		
		return cnt; //빈자리 개수로 리턴
	}
}
