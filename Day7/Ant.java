
public class Ant {

	public static void main(String[] args) {
	
/*
 * 1.첫줄은 그냥 출력
 * 2.같은 숫자일 경우 카운트 증가 
 * 3.다른 숫자일 경우 숫자 + 카운트 누적
 * 3-1 숫자카운트 초기화
 * 4.누적완료 후 출력
 * 4-1 누적값을 대상에 할당
 * 나머지 초기화
 *  * 구현 힌트 1 확인 대상이 변경되면 안됨.
 * 구현 힌트 2 substring,charAt,indexOf 선택활용
 */
//수열생성
		String s ="1";
		int count = 1;
		String nu ="";
		
		System.out.println(1);
		for(int j = 0; j < 10; j++) {
			nu ="";
			count =1; //모든 반복에서 누적되는 변수들은 초기화 되어야 한다.
			String[] arr = s.split(""); //각 자리 수의 숫자를 비교하기 위해 배열을 지정하여 자리 수들을 독립시킨다.
			
		for(int i = 1; i<s.length(); i++) { // 모두전항이랑 비교해야 하기때문에 기준값을 1로 놓는다.
			if(arr[i].equals(arr[i-1])) { 
				count++; //이전항과 기준항의 값이 같다면 개수를 한개 올려준다.
			} else {
				nu += arr[i-1] + count; //이전 숫자를 누적하기 위한 항목
				count = 1; //위에서  누적된 카운트는 전항과 같은 숫자들의 합니다.
			}
		}
		//모든 반복이 끝나고나면
		//위의 포문이 다 돌아가고 나면 마지막 항에 대한 값이 지정되지 않고 카운트 숫자만 남아있다.
		nu+= arr[s.length() - 1] + count;
		System.out.println(nu);
		s = nu;
		}
		

	}
	}


