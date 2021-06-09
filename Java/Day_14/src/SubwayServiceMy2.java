import java.util.Scanner;
import java.util.function.IntPredicate;

public class SubwayServiceMy2 {
	String[] station = {"장승백이","연신내","강남","양재","평택"};
	int now = 0; //현재위치
	int [][] trail = 	{{-1,-1,-1,-1}, //trail 0호
						{-1,-1,-1,-1}, // trail 1호
						{-1,-1,-1,-1}, // trail 2호
						{-1,-1,-1,-1}}; // trail 3호
	
	int pos = -1;
	Scanner sc = new Scanner(System.in);
	
	public void run() {
		boolean flag = true;
		
		while(flag) {
			System.out.println("=================================");
			System.out.println("현재역은"+ station[now]+ "입니다.");
			System.out.println("=================================");
			System.out.println("메뉴를 선택하세요.");
			System.out.println("1.탑승 2.상세보기 3.이동 9.종료");
			
			switch(sc.nextLine()) {
			case "1": join();//탑승
					break;
			case "2": status();//상태보기
					break;
			case "3": move();
					break;
			case "9": flag=false;
					System.out.println("열차운행을 종료합니다."); //종료
					break;
					default:
						System.out.println("잘못입력하셨습니다.");
			
				
			}
		}
	}
	public void join() {
		int imp = 0; //탑승한 승객 카운트
		System.out.println("====탑승 가능 현황=====");
		//trail.length은 4칸
		for(int i = 0; i < trail.length; i++) {
			System.out.println((i+1)+ "호차  :");
			if(checkTrail(i)> 0 ) {//빈자리가 있다, 탑승가능
				System.out.println("가능");
			} else {
				System.out.println("불가능");
				imp++;
			}
		}
		if(imp == trail.length) {
			System.out.println("탑승가능한 열차가 없습니다.");
		} else {
			System.out.println("어느열차에 탑승하시겠습니까?");
			
			for(int i= 0; i < trail.length; i++) {
				System.out.print((i+ 1)+"."+(i +1)+ "호차");
				} 
			System.out.println();
			
			String input = sc.nextLine();
			//지하철호차도 0부터 시작하기 때문에 -1해줘야한다.
			int t = Integer.parseInt(input)-1; //열차선택
			if(checkTrail(t)> 0 ) {
				System.out.println("목적지를 선택해주세요");
				for(int i= 0; i< station.length; i++) {
					if(now != i) { 
						System.out.print((i+1)+"."+station[i]+" ");
						
					}
				}
			
			System.out.println();
			String input2 = sc.nextLine();
			int s = Integer.parseInt(input2)-1;
			
			if(s == now) {
				System.out.println("목적지로 현재역은 안됩니다.");
			}else {
				for(int i= 0; i< trail[t].length; i++) {
					if(trail[t][i] == -1) {
						trail[t][i] = s;
						break; //한번에 한명씩
					}
				}
			}
			
			} else {
				System.out.println("탑승이 불가능 합니다.");
			}
		}
	}
		public void status() {
			System.out.println("열차현황");
			//장승배기 0,연신내 1, 강남 2, 양재 3 평택 4
			for(int i =0; i< trail.length; i++) {
				System.out.println((i+1)+ "호차 :");
				for(int j : trail[i]) {
					//목적지가 있는 승객은 무조건 -1보다 크다.
					if(j< -1) {
					System.out.print("["+station[j]+"]");
					}
				}
				System.out.println();
			}
		}
	public void move() {
		if(now == station.length-1 || now ==0) {
			pos*= -1; // now 0일때 pos는 -1 곱한결과 1
					// now 4일때  pos는 1 곱한결과 -1
		}
		now += pos;
		
		int cnt = 0;
		for(int i =0; i< trail.length; i++) {
			for(int j =0; j< trail[i].length; j++) {
				if(trail[i][j] == now) {
					cnt++;//배열의 값과 현재위치가 같은면 하차
					trail[i][j] = -1; //내려서 다시 빈자리 표시
				}
			}
		}
		if(cnt > 0) {
			System.out.println(cnt + "명 하차하였습니다.");
		}
	}
	
	
	
	public int checkTrail(int num) { //빈자리 개수 카운트 메소드
		int cnt = 0;
		for(int target : trail[num]) {
			if(target == -1) {
				cnt++; //빈자리 개수 카운트
			}
		}
			return cnt;
	}



}		
