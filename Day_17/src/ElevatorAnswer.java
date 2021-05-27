import java.util.Scanner;

public class ElevatorAnswer {
	/*
	 * 주제 : 엘리베이터 구현

	- 조건 -

	엘리베이터는 4명이 탑승이 가능하며, 총 3개 층으로 이루어져있음.

	탑승객은 목표 층을 입력하여 해당 층이 되면, 자동으로 내리게 구현.

	엘리베이터는 무조건 올라갔다가 내려가는 형태로 이동.
	 */
	public static void main(String[] args) {

		int[] ele = { 0, 0, 0, 0 }; // 엘리베이터

		int stair = 1; // 층

		boolean state = true;

		Scanner sc = new Scanner(System.in);

		while (true) {

			System.out.println("엘리베이터 상태[현재층 : " + stair + "]");

			for (int hope : ele) {

				if (hope != 0) {

					System.out.print("[" + hope + "]"); // 탑승 상태 표시

				} else {

					System.out.print("[ ]");

				}

			}

			System.out.println();

			System.out.println("행동을 입력하세요.");

			System.out.println("1.이동 2.탑승 9.종료");

			String input = sc.nextLine();

			if (input.equals("1")) {

				if (state) {

					stair++;

					if (stair == 3) {// 3층

						state = false; // 작동그만

					}

				} else {

					stair--;

					if (stair == 1) {

						state = true;

					}

				}

				for (int i = 0; i < ele.length; i++) {

					if (ele[i] == stair) {

						ele[i] = 0; //내린 사람 초기화

					}

				}

			} else if (input.equals("2")) {

				while (true) {

					System.out.println("어디에 탑승하시겠습니까?[취소 : 9]");

					for (int i = 0; i < ele.length; i++) {

						if (ele[i] != 0) {

							System.out.print("[불가능]");

						} else {

							System.out.print("[" + i + "]");

						}

					}

					System.out.println();

					input = sc.nextLine();

					try {

						int pos = Integer.parseInt(input);

						if (ele[pos] == 0) {

							while (true) {

								System.out.println("몇층으로 가시겠습니까?[현재층 : " + stair + "]");

								input = sc.nextLine();

								try {

									int hope = Integer.parseInt(input);

									if (hope > 0 && hope < 4 && hope != stair) {

										ele[pos] = hope;

										break;

									} else {

										System.out.println("갈 수 없는 층입니다.");

									}

								} catch (Exception e) {

									System.out.println("잘못입력하셨습니다.");

								}

							}

						}

						break;

					} catch (Exception e) {

						System.out.println("잘못입력하셨습니다.");

					}

				}

			} else if (input.equals("9")) {

				System.out.println("엘리베이터 운행을 종료합니다.");

				break;

			} else {

				System.out.println("잘못입력하셨습니다.");

			}

		}

		sc.close();

	}
}
