import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

public class BookMy {

	public static void main(String[] args) {
		//난이도 중
//		3. 다음 데이터 맞추어 데이터를 입력받고 정렬 순서를 입력받아 정렬된 순서대로 출력하는 프로그램을 구현하시오.
			//데이터 : 책번호, 책 제목, 저자, 발행일, 출판사
	
		Scanner sc= new Scanner(System.in);
		
		List<HashMap<String, String>> book	= new ArrayList<HashMap<String, String>>();
	while(true) {
	
	HashMap<String, String> data = new HashMap<String, String>();
	
	System.out.println("문제 3번을 진행하세요");		
	System.out.println("1. 계속\t5.종료");
	int input = sc.nextInt();

	if(input==5) {
		System.out.println("종료되었습니다.");
			break;		
			} 
	
	else {
		
	System.out.println("책번호를 입력해주세요");
	int booknum=sc.nextInt();
	data.put("책번호",Integer.toString(booknum));
	sc.nextLine();
	
	
	System.out.println("책이름를 입력해주세요");
	data.put("책이름",sc.nextLine());
	
	System.out.println("책 저자를 입력해주세요");
	data.put("저자",sc.nextLine());
	
	System.out.println("책 발행일을 입력해주세요");
	int date=sc.nextInt();
	data.put("발행일",Integer.toString(date));
	sc.nextLine();
	
	System.out.println("출판사를 입력해주세요");
	data.put("출판사",sc.nextLine());
	
	book.add(data);
	}
	HashMap<String,String> temp;
	
	for(int i =0; i<book.size()-1; i++) {
		for(int j =i+1; j<book.size(); j++) {
			if(Integer.parseInt(book.get(i).get("책번호"))>Integer.parseInt(book.get(j).get("책번호"))) {
				temp= book.get(i);
				book.set(i, book.get(j));
				book.set(j, temp);
			}
		}
	}
//	for(HashMap<String, String> result : book) {
//		System.out.println(result.get("책번호")+"\t"+result.get("책이름")+"\t"+result.get("저자")+"\t"
//				+result.get("발행일")+"\t"+result.get("출판사"));		
//			}
	for(int i= 0; i<book.size(); i++) {
		System.out.println(book.get(i));
	}
	}
	
	

		
	}
}
