
public class Day9Test {

	public static void main(String[] args) {
		//문제 1. 주사위 6면체(1~6), 12면체(1~12), 20(1~20)면체의 굴린 값을 구하시오.
		//이따가 bean 으로 처리
		int six=(int) ((Math.random()*6)+1); //주사위 6면체
		int twelve= (int) (Math.floor(Math.random()*12)+1); //주사위 12면체
		int twenty=(int) Math.floor(Math.random()*20)+1; //주사위 20면체
	System.out.println("주사위 3개 의 합 :"+(six+twelve+twenty));
	//문제 2. 로또번호 5번 생성. 1번당 6개의 숫자 중복없이..중복체크..
	
	int[] lotto=new int [6]; //로또 번호 담은 배열변수
	int[] temp =new int [6];//비교를 위한 
	temp[0]=lotto[0];
	
	for(int times= 0; times<lotto.length-1; times++) {
	
		lotto[0]=(int) Math.floor(Math.random()*45)+1; //1번
		
		for(int i =1; i<lotto.length; i++) {
		
		lotto[i]=(int) Math.floor(Math.random()*45)+1;
		temp[i]=lotto[i];
		
		for(int j=0; j<i; j++) {
			if(lotto[i]==temp[j]) {
				i--;
				}
			}
		}
//	
	System.out.println("로또 "+(times+1)+" 회차 :"+lotto[0]+","+lotto[1]+","+lotto[2]+","+lotto[3]+","+lotto[4]+","+lotto[5]);
}
	}
}
