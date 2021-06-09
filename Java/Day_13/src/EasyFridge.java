import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class EasyFridge {

	public static void main(String[] args) {
		int size = 50;
		List<Integer> egg = new ArrayList<Integer>();
		List<Integer> milk = new ArrayList<Integer>();
		List<Integer> waterMelon = new ArrayList<Integer>();
		boolean flag = true;
		Scanner sc = new Scanner(System.in);
		while (flag) {
			System.out.println("1.넣기\t2.상태확인\t3.다음날\t4.종료");

			switch (sc.nextLine()) {
			case "1":
				// 냉장고 보관 사이즈
				int pSize = egg.size() * 1 + milk.size() * 3 + waterMelon.size() * 5;
				System.out.println("1.계란(크기 : 1, 유통기한 : 3)\t2.우유(크기 : 3, 유통기한 : 5)\t3.수박(크기 : 5, 유통기한 : 7)");
				switch (sc.nextLine()) {
				case "1":
					if (pSize + 1 <= size) {
						egg.add(3);
					} else {
						System.out.println("냉장고가 다찼음.");
					}
					break;
				case "2":
					if (pSize + 3 <= size) {
						milk.add(5);
					} else {
						System.out.println("냉장고가 다찼음.");
					}
					break;
				case "3":
					if (pSize + 5 <= size) {
						waterMelon.add(7);
					} else {
						System.out.println("냉장고가 다찼음.");
					}
					break;
				}
				break;
			case "2":
				System.out.println("냉장고 상태");
				System.out.println("-----------------");
				for (int i = 0; i < egg.size(); i++) {
					System.out.println("계란(" + egg.get(i) + "일남음)");
				}
				for (int i = 0; i < milk.size(); i++) {
					System.out.println("우유(" + milk.get(i) + "일남음)");
				}
				for (int i = 0; i < waterMelon.size(); i++) {
					System.out.println("수박(" + waterMelon.get(i) + "일남음)");
				}
				break;
			case "3":
				for (int i = 0; i < egg.size(); i++) {
					egg.set(i, egg.get(i) - 1);

					if (egg.get(i) == 0) {
						egg.remove(i);
						i--;
					}
				}
				for (int i = 0; i < milk.size(); i++) {
					milk.set(i, milk.get(i) - 1);

					if (milk.get(i) == 0) {
						milk.remove(i);
						i--;
					}
				}
				for (int i = 0; i < waterMelon.size(); i++) {
					waterMelon.set(i, waterMelon.get(i) - 1);

					if (waterMelon.get(i) == 0) {
						waterMelon.remove(i);
						i--;
					}
				}
				break;
			case "4":
				System.out.println("종료합니다.");
				flag = false;
				break;
			default:
				System.out.println("잘못 입력하셨습니다.");
			}
		}
	}

}
