import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
public class subway2 {
	public static void main(String[] args) {
		// 크기가 고정이면 배열을 쓰는게 좋다. 크기가 유동적인 친구들은 리스트를 쓰는게 좋다.
		Scanner scan= new Scanner(System.in);
		String[] stop = {"장승배기", "연신내", "강남", "양재", "평택"};
		List<HashMap<String,String>> b = new ArrayList<HashMap<String,String>>();
		int now =0;
		int direction =1;
		int person = 0;
		boolean bFlag = true;
		while(bFlag) {
			System.out.println("1.탑승 \t 2.다음역 \t 3. 현재상황(현재 역과 탑승 인원) \t 4.종료");
			switch(scan.nextLine()) {
				case "1" :
					boolean sFlag = true;
					while(sFlag) {
						System.out.println("목적지를 선택하시오. ");
						System.out.println("1. 장승배기 2.연신내  3.강남   4. 양재  5. 평택 6. 더이상 없음");
						HashMap<String,String> p = new HashMap<String,String>();
						switch(scan.nextLine()) {
							case "1":
								person++;
								p.put("목적지", "장승배기");
								b.add(p);
								break;
							case "2":
								person++;
								p.put("목적지", "연신내");
								b.add(p);
								break;
							case "3":
								person++;
								p.put("목적지", "강남");
								b.add(p);
								break;
							case "4":
								person++;
								p.put("목적지", "양재");
								b.add(p);
								break;
							case "5":
								person++;
								p.put("목적지", "평택");
								b.add(p);
								break;
							case "6" :
								sFlag = false;
								break;
							default : 
								System.out.println("잘못입력하셨습니다.");
								break;
						}
					}
					break;
				case "2" :
					if(now ==stop.length -1 || now == 0) { // 다음 역으로 가고 0또는 4이면 방향이 바뀐다. 
						direction *= -1;
					}
					now += (direction *-1); 
					
					for(int i =0; i<b.size(); i++) { 
						if(stop[now].equals(b.get(i).get("목적지"))) {
							b.remove(i);
							person--;
							i--;
						}
					}
					break;
				case "3" :
					System.out.println("현재 역은 : " + stop[now]+"현재 탑승 인원은 " + person);
					break;
				case "4" :
					System.out.println("운행을 중단합니다.");
					bFlag = false;
					break;
			}
		}
	}
}
