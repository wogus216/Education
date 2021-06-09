import java.util.Scanner;

public class Car {
	/* 자동차 
	 * 조건 : 자동차는 4명이 탑승 가능하며, 현재 속도를 가지고 있음, 최고 속도는 150까지이다.
	 * 
	 * 좌석별로 타는 기능 과 내리는 기능 엑셀 과 브레이크로 속도를조절한다. 속도는 10씩 증가 및 감소 가능하다.
	 * 
	 * 운전자가 없을 경우 엑셀 사용 안됨, 속도가 0이 아니면 탑승자가 내릴 수 없다.
	 * 
	 * 주행 중 탑승 불가능
	 */
	
	
	int[] car = {-1,-1,-1,-1}; //차
	int now = 0; //현재속도
	//속도는 150을 넘기면 안된다.
	int pos = -1;
	int speed = 0;
	Scanner sc = new Scanner(System.in);
	public void run() {
		boolean flag =true;
		while(flag) {
			System.out.println("1.탑승 \t2.이동\t3.상태확인\5.종료");
			String menu = sc.nextLine();
			switch(menu) {
			
			case "1": ride_off();
						break;
			case "2": move();
			break;
			case "3": status();
						break;
			case "5": flag=false;
					System.out.println("운행을 종료합니다.");
					break;
					default:
						System.out.println("값을 잘못입력하셨습니다.");
			}
		}
	}
		public void ride_off() {
		
			int cnt =0; //탑승한 사람 카운트
			System.out.println("1.타기\t2.내리기");
			String choice= sc.nextLine();
			switch(choice) {
			case "1": //ride
			
			if(now == 0) {//속도가 0 탑승 가능
				System.out.println("탑승 가능합니다.\n 탑승하시겠습니까?");
				for(int i=0; i<car.length; i++) { //빈자리 확인
					if(car[i] == -1) {// -1이면 빈자리
						car[i] = 1; //1은 차량 탑승
						cnt++;
					
						break;
					}else {//탑승한 사람 카운트
						if(cnt >=4) { //차량
							System.out.println("차량 만원입니다. 더이상 탑승 불가합니다.");
						} else {
							System.out.print("차량 탑승 가능합니다.");
						System.out.println("총 탑승자 : "+cnt);
					}
				}
			}
		}	
			else { //속도가 0아님, 운전자 유뮤 파악
				if(car[0] ==-1) {
					System.out.println("운전자가 없습니다. 먼저 탑승 부탁드립니다.");
				} else {
					
					System.out.println("브레이크를 밟아 주세요,현재속도"+now+"입니다. 먼저 줄여주세요");
				}
			}
			break;
			
			case "2": //off
				if(car[0]==1) { //운전자 있음
					if(now==0) {//운전자 있고, 속도가 0 이어야 가능
						if(cnt>0) {
							for(int i = car.length-1; i<car.length; i--) {
								car[i]= -1; //다시 빈자리
								cnt--;
								break;
							}
						}else {
							System.out.println("탑승한 사람이 없습니다.");
						}
					}else { //속도가 제로가 아니라 브레이크 필수
						System.out.println("현재속도 :"+ now+"입니다.");
						System.out.println("브레이크로 속도를 줄여주세요");
					}
				}else {
					System.out.println("운전자가 없습니다. 그럼 안달리고 있겠네요");
				}
				break;
				default:
					System.out.println("잘못입력하셨습니다.");
			}
		}
		public void move(){ //엑셀과 브레이크 조절,먼저 운전자 유무파악
			System.out.println("1.엑셀\t2.브레이크\t3.종료");
			String put =sc.nextLine();
			boolean sFlag=true;
			while(sFlag) {
				
			
			switch(put) {
			case "1": //엑셀
			if(car[0]==1) { //운전자 유무
				if( now<=150) { //엑셀을 밟아야함
					now+=10;
					System.out.println("현재속도 :"+ now+"입니다.");
					break;
					}
					else {
					System.out.println("속도가 150이 넘었습니다. 브레이크로 줄여합니다.");
					now-=10;
					System.out.println("현재속도 :"+ now+"입니다.");
					break;
				} 
			}else {
				System.out.println("운전자가 없습니다.");
			}
			break;
			
			case "2": //브레이크
				if(car[0]==1) {
					if(now>0) {
						System.out.println("속도를 줄입니다.");
						now-=10;
					}else {
						System.out.print("차가 멈춰 있습니다.\n이동하시려면 엑셀을 밟아 주세요");
					}
				
				}else {
					System.out.println("운전자가 없습니다.");
				}
				break;
			case "3": //종료
					sFlag = false;
					System.out.println("엑셀_브레이크 종료");
				default:
					System.out.println("잘못입력하셨습니다.");
				}
			}
		}
		public void status() {
			
		}
}
