import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Scanner;

public class StockHard {
/*
 * 하루는 오전 / 오후로 구분
 * 시간 변경 시 등락률 random 추출
 *  -2.5 ~ + 2.5% ex) 25*0.1
 *  등락률에 따라 금액변동
 *  종목 조회 시 최근 5건의 변동을 보여줌
 *  보유내역은 구매금액 포함 제공
 *  구매 시 수수료  1% 판매 시  수수료 4% 
 *  시작금액 500원
 *  
 *  삼성 100원, 카카오 80원 넷플릭스 150원 
 */
	List<HashMap<String, Integer>> mystock=new ArrayList<HashMap<String, Integer>>();
	List<HashMap<String, Double>> stockPrice= new ArrayList<HashMap<String, Double>>();
	DecimalFormat form= new DecimalFormat("#.##");  //소수점?
	double amount = 500;
	String[] com= {"삼성","카카오","넷플릭스"};
	double[] price= {100,80,150};
	int[] stockcnt= {0,0,0};
	double miniStockBuy; //최소금액
	double buyFee = 0.01;
	double sellFee = 0.04;
	int time = -1;
	int pos= -1;
	double rate=0;

	Scanner sc = new Scanner(System.in);
	
	public StockHard() {
		miniStockBuy= price[0]*0.01;
		
		for(int i =0; i<price.length; i++) {
			if(amount>miniStockBuy) {
				miniStockBuy=price[i];
			}
		}
	}//StockHard 메솓,
	public void run() {
		boolean flag = true;

		while (flag) {
			System.out.println("=============================================");
			System.out.println("메뉴를 선택하시오. (보유금액 :" + form.format(amount) + ")");
			System.out.println("1.주식구매\t2.주식판매\t3.시간변경\t4.주식보유내역\t5.종목조회\t6.종료");
			System.out.println("=============================================");
			String menu = sc.nextLine();
			switch (menu) {
			case "1":
				buy();
				break;
			case "2":
				sell();
				break;
			case "3":
				tmrw();
				break;
			case "4":
				status();
				break;
			case "5":
				check();
				break;
			case "6":
				System.out.println("5일차죽여버리고싶다.");
				flag = false;
				break;
			default:
				System.out.println("잘못입력하셨습니다.");
			}
		}
	}

	public void buy() { // 구매/최소금액,구매시 수수료 포함 
		if(amount>miniStockBuy) {
			System.out.println("주식 구매 가능합니다. 어느 주식을 구매하시겠습니까?");
			for(int i =0; i<com.length; i++) {
				System.out.println((i+1)+"번."+com[i]);
			}
			String input=sc.nextLine(); //1,2,3선택가능
			int choice=Integer.parseInt(input)-1;
		
			if(choice <0 || choice >= com.length) {
				System.out.println("잘못입력하셨습니다.");
			}else if(amount <price[choice]) {
				System.out.println("돈이 없습니다.");
			}else {
				HashMap<String, Integer> s = new HashMap<String, Integer>();
				s.put("name", choice);//이름
				s.put("price", choice); //가격
				s.put("cnt", choice); //자산 갯수
				mystock.add(s);
				
				stockcnt[choice]++; //해당 인덱스 번호 증가
				amount -=this.price[choice]+(this.price[choice]*buyFee);
			}
			
		
			
		}else {
			System.out.println("돈이없어 주식구매를 못합니다.");
		}
		
	}// buy 메소드 종료

	public void sell() {//
		if(mystock.size()>0) {
			System.out.println("주식판매 가능합니다.");
			for(int i = mystock.size()-1; i >=0; i--) {
				
				HashMap<String, Integer> s = mystock.get(i);
				int price= s.get("price"); //choice 번호
				int name=s.get("name");
				amount += this.price[price]-(this.price[price]*sellFee);
				System.out.println(com[name]+"주식이"+"\t"+this.price[price]+"에 팔렸습니다.");
				System.out.println("판매 수수료 포함 금액 : "+(this.price[price]-(this.price[price]*sellFee)));
				mystock.remove(i);
				stockcnt[i]--;
				
			}
		} else {
			System.out.println("보유중인 주식이 업습니다.");
		}
	}//sell 메소드

	public void tmrw() {//오전 오후 반영, 등락률변경, 2.5%,종목 조회 시 최근 5건의 변동을 보여줌
		int random= (int)Math.floor(Math.random()*2)+1; 
		if(time == 1 || time == -1) {
			time*=pos;
		}
		if(time==1) {
			System.out.println("다음날입니다. 오전 9시 장이열립니다 마음편안히 가지세요");
			if(random ==1) {
				 rate=((double)Math.floor(Math.random()*26)+0)*0.1;
				 System.out.println(form.format(rate));
				 
			}else {
				 rate=((double)Math.floor(Math.random()*26)+0)*-0.1;
				 System.out.println(form.format(rate));
				
			}
			for(int i=0; i<com.length; i++) {
				HashMap<String, Double> s = new HashMap<String, Double>();
				this.price[i]+=(this.price[i]*(rate*0.01));
				System.out.println(form.format(this.price[i]));
				s.put(com[i], this.price[i]);
				
				stockPrice.add(s);
		
			}
			
		}else {
			System.out.println("금일 오후입니다. 한번더 주가 변동합니다.");
			if(random ==1) {
				 rate=((double)Math.floor(Math.random()*26)+0)*0.1;
				 System.out.println(form.format(rate));
				 
			}else {
				 rate=((double)Math.floor(Math.random()*26)+0)*-0.1;
				 System.out.println(form.format(rate));
				
			}
			for(int i=0; i<com.length; i++) {
				HashMap<String, Double> s = stockPrice.get(i);
				this.price[i]+=(this.price[i]*(rate*0.01));
				System.out.println(form.format(this.price[i]));
				s.put(com[i], this.price[i]);
				stockPrice.set(i, s);
			}
		}
		
	}
	public void status() {//구매금액포함제공,가격,갯수, 자산
		if(mystock.size()>0) {
		System.out.println("----- 보유금액 : " + amount + "원 -----");
		
			for(HashMap<String, Integer>s : mystock) {
				
			int com=s.get("name");
			int price=s.get("price");
			int cnt= s.get("cnt");
			
			System.out.println("회사이름 :"+this.com[com]+"\t"+"가격  :"+this.price[price]+
					"\t"+"주식 갯수 :"+stockcnt[cnt]+"\t"+"구매금액 :"+this.price[price]+(this.price[price]*buyFee));
			}
		}else{
			System.out.println("주식부터 사오세요");
		}
	}
	public void check() {//5일치가격 ,종목 조회 5일 가격
		int cnt =0;
		if(stockPrice.size()>0) {
		System.out.println("어떤 종목을 확인하시겠습니까?");
		System.out.println("1.삼성\t2.카카오\t3.넷플릭스");
		String choice= sc.nextLine();
		int input3 = Integer.parseInt(choice)-1;
			for(int i = 0; i<stockPrice.size(); i++) {
				cnt++;
				if(cnt<16) {
					if(stockPrice.get(i).get(com[input3])!=null) {
						System.out.println("최근 5일내역"+com[input3]+":"+(form.format(stockPrice.get(i).get(com[input3]))));
						}
					}
				}
			
		}else {
			System.out.println("날짜가 넘어가야합니다.");
		}
	}
	
	public void check2() {
					for(HashMap<String, Double> days : stockPrice) {
						System.out.println("5일차 삼성 :"+days);
					}
	}
}// 클래스 메소드
