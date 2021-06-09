import java.util.Scanner;

public class SubwayP {
	String[] station = {"장승백이", "연신내", "강남", "양재", "평택"};
	int now  = 0;
	// 인덱스 값에 절대 나올 수 없는 숫자 -1, 지하철에서 -1 빈자리를 나타내는 숫자
	int[][] trail = {{-1, -1, -1, -1},
					{-1, -1, -1, -1},
					{-1, -1, -1, -1},
					{-1, -1, -1, -1}};
		
	int pos = -1;
	Scanner sc = new Scanner(System.in);
	
	public void run() {
		boolean flag =true;
		
		while(flag) {
			System.out.println("=================================");
			System.out.println("현재역은"+ station[now]+ "입니다.");
			System.out.println("=================================");
			System.out.println("메뉴를 선택하세요.");
			System.out.println("1.탑승 2.상세보기 3.이동 9.종료");
			
			switch(sc.nextLine()) {
			case "1": join(); //탑승
					 break;
			case "2" : status(); //상태
					break;
			case "3": move(); //이동
					break;
			case "9": flag = false;
				System.out.println("열차운행을 종료합니다");
				break;
				default : System.out.println("잘못입력하셨습니다.");
			
			}
		}
	}
		
		public void join() { //탑승메소드
			int imp = 0; //탑승 한 승객수
			System.out.println("---탑승 가능 현황----");
			//trail.length 열차 길이 4칸
			for(int i =0; i < trail.length; i++) {
				System.out.print((i +1 )+ "호차 : ");
				//cehckTrail은 빈자리 확인
				if(checkTrail(i) > 0) {
					System.out.println("가능");
				} else { 
					System.out.println("불가능");
					imp++;
				} 
			}
		// 탑승한 승객수 == 열차 자리 4자리 같다는 말은 빈칸이 없다는 이야기
			if(imp == trail.length) {
				System.out.println("탑승 가능 열차가 없습니다.");
				
			} else {
				System.out.println("어느 열차에 탑승하시겠습니까?");
				
				for(int i = 0; i < trail.length; i++) {
					System.out.print((i + 1) + "." + (i + 1 )+ "호차");
				}
				System.out.println();
				
				String input = sc.nextLine();
				//탑승 호수 결정하는 input
				int t = Integer.parseInt(input) -1;
				if(checkTrail(t) > 0) {//조건성립 한다면 빈자리가 있다.
					System.out.println("목적지를 선택해주세요");
					for(int i=  0; i < station.length; i++) {
						if(now != i) {//목적지 선택을 위한 보기
							System.out.print((i + 1) + "."+ station[i]+ " ");
						}
					}
				System.out.println();
				//목적지를 선택하는 input 2
				String input2= sc.nextLine();
				int s = Integer.parseInt(input2) -1;
				
				if(s == now) {
					System.out.println("목적지로 현재역은 안됩니다.");
				} else { //input 에서 입력한 호차 만 체크
					for(int i = 0; i < trail[t].length; i++) {
						if(trail[t][i] == -1) {
							trail[t][i] = s;
							break;
						}
					}
				} 
			} else { //빈자리 없는 조건
				System.out.println("탑승이 불가능합니다");
			}
		}
	}
		
		
		public void status() {
			System.out.println("-------열차현황-------");
			for(int i = 0; i < trail.length; i++) {
				System.out.println((i + 1 )+ "호차 : ");
				//i의 호차 안에 있는 값들을 꺼내 int j에 초기화 j 
				for(int j : trail[i]) {
					if( j > -1) { //목적지가 있다면 -1보다 무조건 큼
						System.out.print("["+ station[j]+ "]");
					}
				}
				System.out.println();
			}
		}

		public void move() {
			
			if(now == station.length -1 || now ==0) {
				pos*= -1;
			}
			
			
			now+=pos;
			int cnt = 0; //하차 한 사람 카운트
			for(int i =0; i < trail.length; i++) {
				for(int j = 0; j < trail[i].length; j++) {//호차 안에 값
					if(trail[i][j] == now) { //목적지와 현재위치가 같으면 하차
						cnt++;
						trail[i][j] = -1; //다시 빈자리로 초기화
					}
				}
			}
			
			if(cnt > 0) {
				System.out.println(cnt +"명이 하차하였습니다.");
			}
		}
		//빈자리 확인 메소드
		public int checkTrail(int num) {
			int cnt = 0;
			
			for(int target : trail[num]) {
				if(target == -1) {
					cnt++;
				}
			}
				return cnt;
		}
}
