
public class Test14C extends Test14P {
//상속은 자식기준으로 생각한다.
	String s = "자식의 반란";
	
	public String getPs() {
		// super : 부모 클래스, 상속 받은 곳에서만 사용가능
		return super.s;
		

	}

		public void p() {
			System.out.println("자식이 덮어쓴 메소드");
		}
}
