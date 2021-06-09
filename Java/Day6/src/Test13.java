
public class Test13 {
//문자열 변환, 수열문제 찾아서 풀어보기
	public static void main(String[] args) {
		
		String s = "Hello World!!";
		
		//한줄주석
		/*
		 * 멀티라인 주석
		 * */
		/**
		 * 정보 주석
		 */
		// Hello World!! --> 문자열은 0 부터 시작!!
		// 0123456789101112
		//substring(값1) : 값 1 이상부터 자른다
		//substring(값1, 값2) : 값 1 이상 값 2 미만을 자른다.
		System.out.println(s.substring(3));
		System.out.println(s.substring(3, 4));
		//orl을 출력해 보시오
	
		System.out.println(s.substring(7, 10));
	
		//length(): 글자 수 
		System.out.println(s.length());
		
		//replace(값 1 , 값 2 ): 값 1을 모두 찾아 값 2로 변경한다.
		//replaceAll(값 1 , 값 2 ): 값 1을 모두 찾아 값 2로 변경한다.
		//replaceFirst(값 1 , 값 2 ): 값 1의 첫번째를 찾아 값 2로 변경한다.
		System.out.println(s.replace("l", "k"));
		System.out.println(s.replaceAll("l", "k"));
		System.out.println(s.replaceFirst("l", "k"));
		
		//indexOf(값) : 해당 값의 위치를 앞에서부터 찾아준다.
		//indexOf(값, 숫자) : 해당 값의 위치를 숫자 이상위치부터 찾아준다.
		//indexOf에서 찾고자 하는값이 없을 경우 -1. -1인 이유는 인덱스는 0 부터 이기 때문에 -1은 존재할 수 없는 수
		System.out.println(s.indexOf("l"));
		System.out.println(s.indexOf("l", 5));
		System.out.println(s.indexOf("x"));
		
		//lastIndexOf(값): 해당값의 위치를 뒤에서 부터 찾아준다.
		//lastIndexOf(값, 숫자): 해당값의 위치를 숫자 이하위치부터 찾아준다.
		System.out.println(s.lastIndexOf("l"));
		System.out.println(s.lastIndexOf("l", 5));
		
		//charAt(값): 값에 해당하는 인덱스의 문자를 돌려준다.
		System.out.println(s.charAt(1));
		
		// 문자열 값 비교 : equals를 사용한다.
		// equals(값) : 문자열의 내용에서 값을 가져와 주어진 값과 비교하여 결과를 질의형으로 돌려줌.
		System.out.println(s =="Hello World!!"); //사용금지 ==은 문자열에서 주소 비교이기 때문이다.
		System.out.println(s.equals("Hello World!!"));
		
		//trim() : 앞 뒤 공백제거
		System.out.println("   Hi~!     ".trim());
		
		//toLowerCase : 모두 소문자로 변경
		System.out.println(s.toLowerCase());
		//toUpperCase : 모두 대문자로 변경
		System.out.println(s.toUpperCase());
		
		s = "딸기,수박 ,참외";
		//split(값) : 값을 기준점으로 문자열을 자르고 배열로 변환한다.
		String[] arr = s.split(",");
		
		for(int i =0; i< arr.length; i++) {
			System.out.println(arr[i]);
		}
		
		System.out.println("--------------------");
		
		String[] n = {"JAVA", "save", "BUTTON"};
		String name = "";
		
		//작업, 최종적으로 반복문 사용
//		n[2]= n[2].toLowerCase();
//		name=n[0].toLowerCase()+n[1].replace("s", "S")+n[2].replace("b", "B"); 
		String temp;
		String temp2;
		for(int i =0 ; i <n.length; i++) {
				n[i]=n[i].toLowerCase();
			  if(i!=0) {
//				  n[i]= n[i].substring(0 , 1).toUpperCase() + n[i].substring(1);
				  n[i]= n[i].replaceFirst(n[i].substring(0 , 1), n[i].substring(0 , 1).toUpperCase());
			  }
			name+=n[i];
		}
		
		//출력부분
		System.out.println(name); //결과 :javaSaveButton
	
	}

}
