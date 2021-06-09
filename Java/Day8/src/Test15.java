
public class Test15 implements ITest15, Ifake {

	// @ - Annotation(어노테이션) : 지시자
	@Override
	public void test() {
		System.out.println("내가 다시 만들었다.");
	}

	@Override
	public void name() {
		System.out.println("신기한데");
		
	}
	

	
}
