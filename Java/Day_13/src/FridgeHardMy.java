import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class FridgeHardMy {
	public static void main(String[] args) {
	int fSize = 50; // 냉장고 사이즈
	
	String[] product = { "계란","우유","수박"};
	int[] pSize = {1, 3 ,5};//크기
	int[] pDay = {3, 5, 7}; //유통기한
	
	List<HashMap<String, Integer>> fridge =new ArrayList<HashMap<String, Integer>>();
	
	boolean flag = true;
	Scanner sc = new Scanner(System.in);
	while(flag) {
		System.out.println("1.넣기\t2.상태확인\t3.다음날\t4.종료");
		
		switch(sc.nextLine()) {
		case "1":
			boolean iFlag = true;
			while(iFlag) {
				//상품의 크기,유통기한을 다 보여줌
				for(int i= 0; i< product.length; i++) {// product.length 길이는 3
					System.out.println((i+ 1)+ "."+ product[i]
							+"(크기 :	"+pSize[i]	
							+ ", 유통기한 : "+pDay[i]+ ")\t");
				}
				System.out.println();
				try {
		
					int num = sc.nextInt();
					sc.nextLine();
					
					int sum =0; //크기 총합
					
					for(int i = 0; i< fridge.size(); i++) {
						sum += pSize[fridge.get(i).get("no")];
					}
					
					if(sum + pSize[num -1] <= 50) {
						HashMap<String, Integer> p =new HashMap<String, Integer>();
						p.put("no", num-1); //크기
						p.put("day", pDay[num-1]); //유통기한
					
						fridge.add(p); //냉장고에 크기, 유통기한 담는다.
					} else { 
						System.out.println("냉장고 크기를 벗어났습니다.(현재 : " 
														+ sum + "/" + fSize + ")");
					}
				
					iFlag = false;
				} catch(Exception e ) {
					System.out.println("잘못입력하셨습니다.");
					e.printStackTrace();
				}
				
			}
		
			
			break;
		case "2":
			System.out.println("냉장고 상태");
			System.out.println("==================");
			for(int i = 0; i < fridge.size(); i++) {
				System.out.println(product[fridge.get(i).get("no")]
						+"("+ fridge.get(i).get("day")+ "일남음)");
			}
			break;
		case "3": //다음날
			for(int i= 0; i < fridge.size(); i++) {
				fridge.get(i).put("day", fridge.get(i).get("day")-1);
				
				if(fridge.get(i).get("day") == 0) {
					fridge.remove(i);
					i--; // 리스트 형식의 i번째 fridge가 제거 되면 바로 위에 있던, 내려오기에 그것을 검사하기 위해서 i--를 해줘야한다.
				}
			}
			break;
		case "4":
			System.out.println("종료합니다");
			flag = false;
			break;
			default :
				System.out.println("잘못 입력하셨습니다.");
		
		}
	}
	
}
}
