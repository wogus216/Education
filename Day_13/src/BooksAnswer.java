import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class BooksAnswer {
	//다음 데이터에 맞추어 데이터를 입력받고 정렬 순서를 입력받아 정렬된 순서대로 출력하는 프로그램 구현
	//데이터 : 책번호, 책제목, 저자 발행일 출판사
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		boolean flag =true;
		//나는 books는 리스트이고 books안에는 해쉬맵book으로 담을거다. 비교를 위해 순차적으로 데이터타입이 담기는 리스트 사용
		List<HashMap<String, String>> books = new ArrayList<HashMap<String, String>>();
		while(flag) {
			System.out.println("1.추가\t2.정렬\t3.조회\t9.종료");
			String menu = sc.nextLine();
			
			switch(menu) {
			case "1":
				while(true) {
					try {
						//while문  돌 때마다 HashMap book 새로 탄생
						HashMap<String, String>book =new HashMap<String, String>();
						System.out.println("책번호를 입력하세요.");
						book.put("no", sc.nextLine());
						//String 값으로 받아서 Int로 변환해준다.
						Integer.parseInt(book.get("no"));
						System.out.println("첵제목을 입력해주세요");
						book.put("title", sc.nextLine());
						System.out.println("작성자을 입력해주세요");
						book.put("writer", sc.nextLine());
						System.out.println("발행일을 입력해주세요");
						book.put("date", sc.nextLine());
						System.out.println("출판사를 입력해주세요");
						book.put("company", sc.nextLine());
						
						books.add(book);
						break;
					}//try
					catch (Exception e) {//저 위에 스캐너지정한 값을 벗어난 타입을 적으면 catch 발생
						System.out.println("잘못입력하셨습니다.");
						e.printStackTrace();
					}//catch
					
				}//switch in while
				break;
			case "2": //정렬
				boolean sFlag =true;
				while(sFlag) {
					//book이 HashMap라 비교하는 temp는 같은 타입으로 만들어서 비교
					HashMap<String, String> temp; 
					System.out.println("1.오름차순\t2.내림차순");
					switch(sc.nextLine()) {
					case "1":
						for(int i =0; i < books.size()-1; i++) {
							for(int j = i+1; j< books.size(); j++) {
					//String으로 받는 books int로변환,books리스트 안에있는 0번째에서 키값 "no" 꺼내오기
								if(Integer.parseInt(books.get(i).get("no"))
										> Integer.parseInt(books.get(j).get("no"))) {
									temp=books.get(i);
									//books 안에 i번째와 books j번째 바꾼다.
									books.set(i, books.get(j));
									//books안에 j번째를 temp가 갖고있는 값을 넣어준다
									books.set(j, temp);
								} //if문
							}//두 번째 for문
						}//첫번째 for문
							sFlag = false;
							break;
						case "2":
							for (int i = 0; i < books.size() - 1; i++) {
								for (int j = i + 1; j < books.size(); j++) {
									if (Integer.parseInt(books.get(i).get("no")) 
											< Integer.parseInt(books.get(j).get("no"))) {
										temp = books.get(i);
										books.set(i, books.get(j));
										books.set(j, temp);}
							}//두번째 for문	
						}//첫번 째 for문
							sFlag = false;
							break;
						default : 
							System.out.println("잘못입력하셨습니다.");
					} //case 2안에 스위치
				} //case 2 안에 while
				break; // case 2 안에 while 브레이크 위해 사용
			
			case "3":
				System.out.println("책번호\t책제목\t저자\t발행일\t출판사 ");
				for(HashMap<String, String> book: books) {
					System.out.println(book.get("no")+"\t"+book.get("title")+"\t"+book.get("writer")+"\t"
							+ book.get("date") + "\t" + book.get("company") + "\t");
				} //case 3 in for문
				break;
			case "9":
				flag = false;
				System.out.println("종료합니다.");
				break;
				default:
					System.out.println("잘못입력했습니다.");
			}//switch
		
		}//while
	
	}//main
}//class
