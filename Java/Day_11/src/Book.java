

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;


public class Book {

	public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
		//난이도 중
//		3. 다음 데이터 맞추어 데이터를 입력받고 정렬 순서를 입력받아 정렬된 순서대로 출력하는 프로그램을 구현하시오.
			//데이터 : 책번호, 책 제목, 저자, 발행일, 출판사
	
	List<HashMap<String, String>> book	
	= new ArrayList<HashMap<String, String>>();
	boolean flag = true;
	while(flag) {
		HashMap<String, String> data = new HashMap<String, String>();

		System.out.println("문제 3번을 진행하세요");		
		System.out.println("1. 책입력\t2.책  정렬\t3.정렬\t5.종료");
			String input = sc.nextLine();
			switch(input) {
			
			case "1" :
			System.out.println("책번호를 입력해주세요");
			int booknum=sc.nextInt();
			sc.nextLine();
			data.put("책번호",Integer.toString(booknum));
			
			System.out.println("책이름를 입력해주세요");
			String bookname=sc.nextLine();
			data.put("책이름",bookname);
			
			
			System.out.println("책 저자를 입력해주세요");
			String writer=sc.nextLine();
			data.put("저자",writer);
	
			
			System.out.println("책 발행일을 입력해주세요");
			int date=sc.nextInt();
			sc.nextLine();
			data.put("발행일",Integer.toString(date));
			
			System.out.println("출판사를 입력해주세요");
			String company=sc.nextLine();
			data.put("출판사",company);
	
			
			book.add(data);
			break;
			
			case "2":
				HashMap<String, String> temp ;
				System.out.println("1.오름차순\t 2.내림차순");
			String input2 = sc.nextLine();
			switch(input2) {
			
			case "1": //오름차순
				for(int i=0; i<book.size()-1; i++) {
					for(int j =i+1; j<book.size(); j++) {
				//"책번호가 스트링이라서 비교를 위해 인트로 형변환		
			if(Integer.parseInt(book.get(i).get("책번호")) > Integer.parseInt(book.get(j).get("책번호"))) {
							temp = book.get(i);
							book.set(i, book.get(j));
							book.set(j, temp);
					}
				}
			}		
				break;
			case "2": //내림차순
				for(int i=0; i<book.size()-1; i++) {
					for(int j =i+1; j<book.size(); j++) {
				//"책번호가 스트링이라서 비교를 위해 인트로 형변환		
			if(Integer.parseInt(book.get(i).get("책번호")) < Integer.parseInt(book.get(j).get("책번호"))) {
							temp = book.get(i);
							book.set(i, book.get(j));
							book.set(j, temp);
						}
					}
				}
				break;
			}		
			break;
			
			case "3":
				System.out.println("순번 정렬");
			for(HashMap<String, String> name : book) {
				System.out.println(name.get("책이름")+"\t"+name.get("책번호")+"\t"
					+name.get("저자")+"\t"+name.get("발행일")+"\t"+name.get("출판사"));
				}
			break;
			
			case "5":
				System.out.println("종료합니다.");
				flag=false;
				break;
			default:
				System.out.println("잘못입력하셨습니다.");
			}
			
		}
	}
}
