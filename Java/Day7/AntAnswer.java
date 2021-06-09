
public class AntAnswer {

	public static void main(String[] args) {

		String val = "1"; //대상
		String res = ""; //결과 문자열
		String check = ""; //숫자
		int cnt = 0; // 개수
		System.out.println(val);

		for(int i =0; i< 9; i++) { //횟수
			res = "";
			check = val.substring(0, 1);//0번째 숫자 설정
			cnt = 1; //개수 1
			for(int j =1; j< val.length(); j++) {// 1~~마지막
				if(check.equals(val.substring(j, j+1))) { //같을 때
					cnt++; //개수증가
				} else {
					res+= check+cnt; //문자열 누적
					check = val.substring(j, j+1);//숫자 변경
					cnt = 1; //개수 1
				}
			}
			res+= check+ cnt; //문자열 누적
			val = res; //현재 결과값이 다음 대상이 됨
			System.out.println(res);//출력
		}
	}

}
