import java.util.Arrays;

public class Day9Answer {
public static void main(String[] args) {
	
	//문제1  
	int dice6 = (int)Math.floor(Math.random() *6)+1;
	int dice12 = (int)Math.floor(Math.random() *12)+1;
	int dice20 = (int)Math.floor(Math.random() *20)+1;
	
	System.out.println("6면체"+ dice6);
	System.out.println("12면체"+ dice12);
	System.out.println("20면체"+ dice20);
	System.out.println("합계 : "+(dice6+dice12+dice20));
	
	//문제 2 로또번호 5번 생성 1부터 45까지 1번당 6개의 숫자. 중복없이 (회차별)
	
	int[ ] lotto = new int[6];
	for(int k = 0; k < 5; k++){
		for(int i= 0; i <6 ; i++) {
			lotto[i] = (int)Math.floor(Math.random()* 45)+1;
			
			for(int j =0; j< i; j++ ) {
				if(lotto[i] == lotto[j]) {
					i--;
					break;
				}
			}
		}
		Arrays.sort(lotto); //코딩테스트시  사용하지 말것
		System.out.println(Arrays.toString(lotto));
		}
		String s = ",";
		String k = "Kaydd";
//		for(int i = 0; i <6; i++) {
//			int temp = (int)Math.floor(Math.random()* 45)+1;
//			//",3,5,12,"  ",2," //앞에콤마의 중요성
//				if(s.indexOf(","+ temp+",") !=-1) { //indexof는  공부가 필요하다.
//												//값이 없는 경우 -1
//					i--;
//				} else { 
//					s += temp + ",";
//				}
//			}
//		System.out.println(s.substring(1, s.length() -1)); //처음과 마지막이 ,를 날리는 것
//		
		System.out.println(k.indexOf(3));
		System.out.println(k.indexOf('k'));
		
}
}
