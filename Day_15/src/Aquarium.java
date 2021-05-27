import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class Aquarium {

	/*
	 * 기본어항 4개 가변적임 어항은 리스트 물고기는 해당일자가 지나야 판매가능 완전 성장 후 3일 경과시 시망. 먹이는 하루 1번 사용 가능
	 * 전체 어항 적용 초기자금 300원 어항 추가 비용 1000원 먹이 개당 200원 는 보너스 금붕어 구매 100원 , 판매 150원, 성장
	 * 3일 잉어 구매 500원, 판매 1000원, 성장 7일 구피 구매 200원, 판매 350원 성장 5일 성장은 카운트로 표시 !!
	 */
	String[] fishkind = { "금붕어", "잉어", "구피" };
//	구매금액 100, 500, 200
//  판매금액 150, 1000, 350
//	성장일 3,7,5   
	int space = 4; // 초기어항 사이즈
	
	List<Integer> gold = new ArrayList<Integer>();
	List<Integer> silver = new ArrayList<Integer>();
	List<Integer> bronze = new ArrayList<Integer>();
	Scanner sc = new Scanner(System.in);
	int amount = 300; // 초기금액
	int aSize = gold.size() + silver.size() + bronze.size(); // 어항에 있는 물고기 개수

	public void run() {
		boolean flag = true;
		while (flag) {
			System.out.println(
					"메뉴를 선택하시오.(보유금액 :" + amount + ")" + "\n1.물고기구매\t2.물고기판매\t3.어항구매(10000원)\t4.먹이주기\t5.다음날 6.종료");
			switch (sc.nextLine()) {
			case "1":
				buy();
				break;
			case "2":
				sell();
				break;
			case "3":
				buys();
				break;
			case "4":
				meal();
				break;
			case "5":
				tmrw();
				break;
			case "6":
				flag = false;
				System.out.println("수족관 죽여버리고 싶다.");
				break;
			default:
				System.out.println("다시 입력하세유");
			}
		}
	}

	public void buy() {// 어항 사이즈 4이면 제한걸자
		// 고려 사항 물고기랑 어항개수 ,돈 부족할 때
		System.out.println("어떤 물고기를 구매하시겠습니가? \n" + "1.골드\t2.실버\t3.브론즈");
		switch (sc.nextLine()) {
		case "1":
			if (aSize <= space) {
				if (amount >= 100) {
					System.out.println("골드를 구매합니다");
					gold.add(3);
					space--;
					System.out.println("현재금액은" + (amount -= 100) + "원입니다.");
				} else {
					System.out.println("돈 벌어와 돈없어");
				}

			} else { 
				System.out.println("어항 개수 부족함");
			}
			break;
		case "2":
			if (aSize <= space) {
				if (amount >= 500) {
					System.out.println("실버를 구매합니다");
					silver.add(7);
					space--;
					System.out.println("현재금액은" + (amount -= 500) + "원입니다.");
				} else {
					System.out.println("돈 벌어와 돈없어");
				}

			} else { //
				System.out.println("어항 개수 부족함");
			}
			break;
		case "3":
			if (aSize <= space) {
				if (amount >= 200) {
					System.out.println("브론즈를 구매합니다");
					bronze.add(5);
					space--;
					System.out.println("현재금액은" + (amount -= 200) + "원입니다.");
				} else {
					System.out.println("돈 벌어와 돈없어");
				}

			} else { //
				System.out.println("어항 개수 부족함");
			}
			break;
		default:
			System.out.println("꺼져 수족관");

		}
		System.out.println("현재 갖고있는 골드의 개수 :"+ gold.size());
		System.out.println("현재 갖고있는 실버의 개수 :"+ silver.size());
		System.out.println("현재 갖고있는 골드의 개수 :"+ bronze.size());
	}

	public void sell() {
		System.out.println("어떤 물고기를 판매하시겠습니까? \n1.골드\t2.실버\t3.브론즈 ");
		String choice = sc.nextLine();

		switch (choice) {
		case "1":
			int goldcnt = 0;
			if (gold.size() > 0) {
				for (int i = 0; i < gold.size(); i++) {
					if (gold.get(i) <= 0) {
						gold.remove(i); // 판매한 물고기 안녕!!
						i--;
						space++; // 어항개수 늘어남
						goldcnt++;
					} else {
						System.out.println("판매가능한 골드가 없어요");
					}

				}
				System.out.println("현재금액은 " + (amount += 150*goldcnt) + "원입니다.");
			} else {
				System.out.println("판매가능한 골드가 없어요");
			}
			break;

		case "2":
			int silvercnt = 0;
			if (silver.size() > 0) {
				for (int i = 0; i < silver.size(); i++) {
					if (silver.get(i) <= 0) {
						silver.remove(i); // 판매한 물고기 안녕!!
						i--;
						space++; // 어항개수 늘어남
						silvercnt++;
					} else {
						System.out.println("판매가능한 실버가 없어요");
					}

					System.out.println("현재금액은 " + (amount += 1000*silvercnt) + "원입니다.");
				}
			} else {
				System.out.println("판매가능한 실버가 없어요");
			}
			break;

		case "3":
			int bronzecnt = 0;
			if (bronze.size() > 0) {
				for (int i = 0; i < bronze.size(); i++) {
					if (bronze.get(i) <= 0) {
						bronze.remove(i); // 판매한 물고기 안녕!!
						i--;
						space++; // 어항개수 늘어남
						bronzecnt++;
					} else {
						System.out.println("판매가능한 브론즈가 없어요");
					}
				}
				System.out.println("현재금액은 " + (amount += 10000*bronzecnt) + "원입니다.");
			} else {
				System.out.println("판매가능한 브론즈가 없어요");
			}
			break;
		default:
			System.out.println("꺼져 수족관");
		}
	}

	public void buys() { // 어항구매
		System.out.println("구매하고 싶으면 y를 눌러주세요");

		String buy = sc.nextLine();
		switch (buy) {
		case "y":
			if (amount >= 10000) {
				space++;
				System.out.println("어항을 구매하셔서 현재금액은 " + (amount -= 10000) + "원입니다.");
			} else {
				System.out.println("돈이 없어 어항을 못삽니다.");
			}
			break;
		}
	}

	public void meal() { // 식사 성장일수 1씩 줄어듭니다.
// 판매가능 한 갯수 구하기 0이나 -3
		int goldsell = 0;
		int silversell = 0;
		int bronzesell = 0;
		if (amount >= 200) {
			amount-=200;
			for (int i = 0; i < gold.size(); i++) {
				gold.set(i, gold.get(i) - 1);
				if (gold.get(i) <= -4) {
					gold.remove(i);
					i--;
					space++;
				}
				if(gold.get(i)<1 && gold.get(i)>=-3) {
					goldsell++;
				}
			}
			for (int i = 0; i < silver.size(); i++) {
				silver.set(i, silver.get(i) - 1);
				if (silver.get(i) <= -4) {
					silver.remove(i);
					i--;
					space++;
				}
				if(silver.get(i)<1 && silver.get(i)>=-3) {
					silversell++;
				}
			}
			for (int i = 0; i < bronze.size(); i++) {
				bronze.set(i, bronze.get(i) - 1);
				if (bronze.get(i) <= -4) {
					bronze.remove(i);
					i--;
					space++;
				
				}
				if(bronze.get(i)<1 && bronze.get(i)>=-3) {
					bronzesell++;
				}
			}
			
		} else {
			System.out.println("돈이 없어서 먹이를 못삽니다.");
		
		}
		System.out.println("현재 판매가능한 골드  :"+goldsell);
		System.out.println("현재 판매가능한 실버  :"+silversell);
		System.out.println("현재 판매가능한 브론즈  :"+bronzesell);
	
	}

	public void tmrw() {
		int goldsell = 0;
		int silversell = 0;
		int bronzesell = 0;
		for (int i = 0; i < gold.size(); i++) {
			gold.set(i, gold.get(i) - 1);
			if (gold.get(i) <= -4) {
				gold.remove(i);
				i--;
				space++;
			}
			if(gold.get(i)<1 && gold.get(i)>=-3) {
				goldsell++;
			}
		}
		for (int i = 0; i < silver.size(); i++) {
			silver.set(i, silver.get(i) - 1);
			if (silver.get(i) <= -4) {
				silver.remove(i);
				i--;
				space++;
			}
			if(silver.get(i)<1 && silver.get(i)>=-3) {
				silversell++;
			}
		}
		for (int i = 0; i < bronze.size(); i++) {
			bronze.set(i, bronze.get(i) - 1);
			if (bronze.get(i) <= -4) {
				bronze.remove(i);
				i--;
				space++;
			
			}
			if(bronze.get(i)<1 && bronze.get(i)>=-3) {
				bronzesell++;
			}
		}
		System.out.println("현재 판매가능한 골드  :"+goldsell);
		System.out.println("현재 판매가능한 실버  :"+silversell);
		System.out.println("현재 판매가능한 브론즈  :"+bronzesell);
	}
}
