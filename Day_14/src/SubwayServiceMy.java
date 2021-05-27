import java.util.Scanner;

public class SubwayServiceMy {
	String[] station = {"장승백이","연신내","강남","양재","평택"};
	int now = 0;
	// 인덱스 값에 절대 나올 수 없는 숫자 -1, 지하철에서 -1은 비어있는 숫자다.
	int [][] trail = 	{{-1, -1, -1, -1},
						{-1, -1, -1, -1},
						{-1, -1, -1, -1},
						{-1, -1, -1, -1}};  //16칸
	int pos = -1;
	Scanner sc = new Scanner(System.in);
	
	public void run() {
		boolean flag =true;
		
		while (flag) {
			System.out.println("=================================");
			System.out.println("현재역은"+ station[now]+ "입니다.");
			System.out.println("=================================");
			System.out.println("메뉴를 선택하세요.");
			System.out.println("1.탑승 2.상세보기 3.이동 9.종료");
			
			switch(sc.nextLine()) {
			case "1" : join(); //탑승
						break;
			case "2" : status(); //상세보기
						break;
			case "3" : move(); //이동
						break;
			case "9" : flag = false;
						System.out.println("열차운행을 종료합니다."); //종료
						break;
						default : System.out.println("잘못입력하셨습니다.");
			}
		}
	}
	
	public void join() {
		int imp = 0;  //빈자리가 없는 개수
		System.out.println("-----탑승 가능 현황-----");
		//trail.length는 1차원 배열 trail 길이 4칸이다.
		for(int i = 0; i < trail.length; i++) {
			System.out.print((i + 1) + "호차 : ");
			if(checkTrail(i) > 0) { //빈자리 >0 즉, 빈자리가 있다는 얘기
				System.out.println("가능");
			} else {
				System.out.println("불가능");
				imp++; //빈자리가 없을 때  1씩 올라간다.
			}
		}
		//imp 와 trail.length길이 같다는 뜻은 4==4란 뜻인데 자리가 4자리이기때문에 빈자리가 없다는 말이다.
		if(imp == trail.length) { //빈자리없는 개수 == 지하철 자리 4칸 즉, 빈자리가 없다. 
			System.out.println("탑승가능 열차가 없습니다.");
		} else { //빈자리가 비어있는 경우
			System.out.println("어느 열차에 탑승하시겠습니까?");
			
			for(int i = 0; i < trail.length; i++) {
				System.out.print((i+1)+ "."+ (i+1)+ "호차");
			}
			System.out.println();
			
			String input = sc.nextLine();
			int t = Integer.parseInt(input) -1; //지하철호차 도 0부터 시작하기 때문에 -1해줘야 내가 원하는 호차 선택가능 
			if(checkTrail(t)> 0) { //빈자리개수 >0  
				System.out.println("목적지를 선택해 주세요");
				for(int i = 0; i <station.length; i++) {
					if(now != i) { //현재위치와 목적지가 다르면 조건 성립, 같은 위치면 조건문이 false이다.
						System.out.print((i+1) + "." + station[i]+ " ");
					}
				}
				
				System.out.println();
				String input2 = sc.nextLine(); //목적지 설정
				int s = Integer.parseInt(input2)-1;  
				
				if(s == now) {
					System.out.println("목적지로 현재역은 안됩니다.");
				} else {
					for(int i= 0; i < trail[t].length; i++) {
						if(trail[t][i] == -1) {
							trail[t][i] = s;
							break; //한번에 한명씩 탑승 그래서 break;를 걸어줘야한다.
						}
					}
				}
			} else {
				System.out.println("탑승이 불가합니다.");
			}
		}
		
	}
			public void status() {
				System.out.println("------열차현황------");
				//장승백이 =0 연신내 =1 강남=2 양재 =3 평택=4
				for(int i= 0; i < trail.length; i++) {
					System.out.println((i+1) + "호차 : ");
					for(int j : trail[i]) {
						if(j > -1) {
							System.out.print("["+ station[j] + "]");
						}
					}
					System.out.println();
				}
			}
			public void move() {
				
				if(now == station.length -1 || now ==0) {
					pos*= -1; // now 0일때 pos는 -1  곱한결과 1
				}				// now 4일때 pos는 1 그래서 곱한결과 -1
				
				now += pos;
				//장승백이 =0 연신내 =1 강남=2 양재 =3 평택=4
				int cnt = 0;
				for(int i = 0; i< trail.length; i++) {
					for(int j =0; j < trail[i].length; j++) {
						if(trail[i][j] == now) {
							cnt++; //배열속의 값이 역의 인덱스 값과 같으면 하차
							trail[i][j] = -1; //내려서 다시 빈자리 -1
						}
					}
				}
				
				if(cnt > 0) {
					System.out.println(cnt + "명이 하차하였습니다.");
				}
			}
			//checkTrail은 빈자리 개수
			public int checkTrail(int num) {
				int cnt = 0;
				
				for(int target : trail[num]) {
					if(target == -1) { //-1 카운트, 즉 빈자리 개수 카운트
						cnt++;
					}
				}
				
				return cnt;
			}
}
