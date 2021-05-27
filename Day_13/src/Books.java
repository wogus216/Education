import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class Books {

	public static void main(String[] args) {
		 Scanner sc = new Scanner(System.in);
		 boolean flag= true;
		 List<HashMap<String, String>> books = new ArrayList<HashMap<String,String>>();
		while(flag) {
			System.out.println("1.추가\t2.정렬 \t3.조회\t9.종료");
			String menu = sc.nextLine();
			
			switch(menu) {
			case "1":
				while(true) {
					try {
						//while문 돌 때 마다 HashMap 타입 book탄생
						HashMap<String, String>book = new HashMap<String, String>();
						System.out.println("책번호를 입력하세요");
						book.put("no", sc.nextLine());
						//String 값으로 받아서 Int로 변환해준다.
						Integer.parseInt(book.get("no"));
						System.out.println("책제목을 입력해주세요");
						book.put("title", sc.nextLine());
						System.out.println("작성자를 입력해주세요");
						book.put("writer", sc.nextLine());
						System.out.println("발행일을 입력해주세요");
						book.put("date", sc.nextLine());
						System.out.println("출판사를 입력해주세요");
						book.put("company", sc.nextLine());
						
						books.add(book);
						//try문 끝나면 꼭  break; 사용
						break;
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println("잘못입력하셨습니다.");
						e.printStackTrace();
					}//catch
				}
				break;
			case "2":
				boolean sflag = true;
				while(sflag) {
				//book이 HashMap이기에 비교하는 temp도 같은 타입으로 만들어서비교
				 HashMap<String, String>temp;
				System.out.println("1.오름차순 \t2.내림차순");
					switch(sc.nextLine()) {
					case "1":
						for(int i =0; i < books.size()-1; i++) {
							for(int j =0; j <books.size(); j++) {
			//String으로 받는 books int로 변환 books 리스트 안에 있는 0번째 에서 키값 꺼내오기
				//내림차순으로 조건문 반대로 
				if(Integer.parseInt(books.get(i).get("no"))>
					Integer.parseInt(books.get(j).get("no"))){
						temp = books.get(i);
						books.set(i, books.get(j));
						books.set(j, temp);
							}
						 }
					 }
						sflag= false;
						break;
				case "2":
					for(int i = 0; i < books.size() -1; i++) {
						for(int j = i+1; j < books.size(); j++) {
							if (Integer.parseInt(books.get(i).get("no")) 
								< Integer.parseInt(books.get(j).get("no"))) {
								temp = books.get(i);
								books.set(i, books.get(j));
								books.set(j, temp);}
						}//두번째 for문	
					}//첫번 째 for문
						sflag = false;
						break;
					default : 
						System.out.println("잘못입력하셨습니다.");
							}
						}
				break;
				
			case "3":
				System.out.println("책번호\t책제목\t저자\t발행일\t출판사");
			for(HashMap<String, String> book: books) {
				System.out.println(book.get("no")+" "+book.get("title")+" "+book.get("writer")+" "
				+book.get("date")+" "+book.get("company"));
				}
				break;
			case "9":
				flag = false;
				System.out.println("종료합니다.");
				break;
				default:
					System.out.println("잘못입력했습니다.");
			}
		}
	}
}
