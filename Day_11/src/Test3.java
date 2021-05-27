import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class Test3 {

	public static void main(String[] args) {
	
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
	for(HashMap<String, String> result : book) {
		System.out.println(result.get("책번호")+"\t"+result.get("책이름")+"\t"+result.get("저자")+"\t"
				+result.get("발행일")+"\t"+result.get("출판사"));		
			}
		}

	Object[] arr=book.toArray();
	for(int i=0; i<arr.length; i++) {
		System.out.println(arr[i]);
	}
System.out.println(Arrays.toString(arr));
	
	Object temp =0;
	for(int j=0; j<arr.length-1; j++ ) {
		for(int k=j+1; k<arr.length; k++) {
			if(arr[j].equals(arr[k])){
				temp= arr[j];
				arr[j]=arr[k];
				arr[k]=temp;
			}
		}
	}
		System.out.println(arr);
	}
}
