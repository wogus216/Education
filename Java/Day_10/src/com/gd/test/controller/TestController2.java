package com.gd.test.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class TestController2 {
//웹 개발시 리스트를 많이 사용 
	public static void main(String[] args) {
		List<Integer> list = new ArrayList<Integer>();
		
		//add(값) : 리스트에 값을 추가한다.
		list.add(1);
		list.add(2);

		//get(인덱스 번호) : 리스트에서 해당 값을 가져온다.
		System.out.println("해당 값 :"+list.get(0));
		//size() : 리스트의 크기를 돌려준다.
		System.out.println("크기 :"+list.size());
		// set (인덱스 번호, 값) : 인덱스 번호에 해당하는 내용을 주어진 값을 변경한다.
		list.set(0, 7);
		System.out.println(list.get(0));
		//remove(인덱스 번호) : 인덱스번호에 해당하는 것을 제거한다. 인덱스번호 이후에 것들을 당겨온다.
		list.remove(0);
		System.out.println(list.get(0));
		//clear(): 리스트를 비운다.
		list.clear();
		System.out.println("크기 :"+list.size());
		list.add(3);
		list.add(7);
		//contains(값) : 값이 리스트에 존재하는 지 여부를 돌려줌. boolean타입을 돌려줌
		System.out.println(list.contains(3));
		// isEmpty() : 리스트가 비어있는 여부를 돌려줌. 비어있으면 true 안비어있으면 false
		System.out.println(list.isEmpty());
		
		list.clear();
		list.add(5);
		list.add(7);
		list.add(3);
		int temp = 0;
//		여기에 오름차순 정렬을 구현하시오.
		for(int i = 0; i<list.size()-1; i++) {
			for(int j=i+1; j<list.size(); j++) {
				if(list.get(i)>list.get(j)) {
					temp=list.get(i);
					list.set(i,list.get(j));
					list.set(j, temp);
				}
			}
		}
		
		
		//출력 : 3 5 7이 한줄 씩 출력 됨
		for(int i = 0; i< list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println("--------------------------");
		//add(인덱스번호, 값) : 해당 인덱스 번호 위치에 값을 넣는다.
		//						넣기 전에 해당 인덱스 위치 이후의 모든 것을 하나씩 뒤로 미룬다.
		list.add(0, 4);  // list[4,3,5,7}로  집가서 복습!!!
		
		for(int i = 0; i< list.size()-1; i++) {
			for(int j = i+1; j < list.size(); j++) {
				if(list.get(i)>list.get(j)) {
					list.add(i, list.get(j));
					list.remove(j + 1); //넣은 수 빼는 과정 !!
				}
			}
		}
		for(int i = 0; i< list.size(); i++) {
			System.out.println(list.get(i));
		}
		System.out.println("--------------------------");
		list.clear();
		list.add(5);
		list.add(7);
		list.add(3);
		list.add(10);
		for(int i= 0; i < list.size() -1; i++) {
			for(int j = list.size() -1; j> i; j--) {
				if(list.get(i) > list.get(j)) {
					list.add(list.get(i));
					list.remove(i);
			
				}
			}
		}
		for(int i = 0; i< list.size(); i++) {
			System.out.println(list.get(i));
		
			}
		System.out.println("--------------------------");
		list.clear();
		list.add(5);
		list.add(7);
		list.add(3);
		
		
		list.sort(null);
		
		for(int i = 0; i< list.size(); i++) {
			System.out.println(list.get(i));
		
			}
		// toArray 정리 필요
		Object[] arr = list.toArray(); //toArray는 그냥 오브젝트 타입으로 배열을 생성해줌
			// arr는 오브젝트이지만 제네릭이 Integer타입이라 integer 타입이다. 
		System.out.println(Arrays.toString(arr));
		
		System.out.println(Integer.toString((int)arr[0])+10);
	
		HashMap<String, String> map = new HashMap<String, String>();
		// put(값1 ,값2 ) : 값1을 키로 지정하고 해당 내용으로 값2를 지정한다.
		map.put("가", "abc");
		//get(값) : 값이 키와 동일한 것의 내용을 가져온다.
		System.out.println(map.get("가"));
		System.out.println(map.get("나")); //map은 비순차적 개념이 라서 값이 없으면 없다고 알려준다.
	
		//replace(값1, 값2 ) : 값 1이 키로 있는 해당내용을 값2를 지정한다. 추가시켜주는 기능 없음.
		map.replace("나", "ABC");
		System.out.println(map.get("나"));
		//put은 추가의 개념과 덮어씌운다는 의미도 있음. replace와 동일한 기능 put을 써라
		map.put("가", "abc");
		System.out.println(map.get("가"));
		//remove(값) : 값이 키인 것을 제거한다.
		map.remove("가");
		System.out.println(map.get("가"));
		//isEmpty() : 맵이 비어있는 지 여부를 돌려줌 boolean타입으로 알려준다.
		System.out.println(map.isEmpty());
		// containsKey(값) : 값과 일치하는 키가 있는 지 여부를 돌려줌.
		// containsValue(값) : 값과 일치하는 내용이 있는 지 여부를 돌려줌.
		System.out.println(map.containsKey("가"));
		System.out.println(map.containsValue("abc"));
		//clear() : 맴에 있는 내용들을 제거.
		map.clear();
		map.put("가", "abc");
		map.put("나", "123");
		map.put("다", "가나다"); //출력은 순차적으로 가 아닌 그냥 가깝게 놓은 것 부터 출력
		//KeySet() : 맵의 키들을 Set의 형태로 변환한다.
		//Set : 값을 순차적으로 넣을 수 있다. 넣을 수만 있다.
		Set<String> keySet = map.keySet();
		
		//Iterator : 값을 순차적으로 꺼낼 수 있다. 꺼낼 수만 있다. 무조건 순차적으로만 꺼낸다.
		// 레코드판과 동일
		Iterator<String> keys = keySet.iterator();
		//hasNext(): 다음 값이 존재하는 지 여부를 돌려줌
		while(keys.hasNext()) {
			//next(): 다음 값을 가져온다.
			System.out.println(map.get(keys.next()));
		}
		
		List<HashMap<String, String>> board 
			= new ArrayList<HashMap<String, String>>();
		
		for(int i = 10; i > 0 ; i--) {
			HashMap<String, String> data = new HashMap<String, String> ();
			//new가생성 될때마다 새로운 객체 주소를 받기 위해 for문 안에 있다.
			data.put("no", Integer.toString(i));
			data.put("title", "Test"+i);
			data.put("writer", "Tester");

			board.add(data);
		}
			//순차형 데이터 board 
		for(HashMap<String, String> data : board) {
			System.out.println(data.get("no")+"\t"+data.get("title")
			+"\t"+data.get("writer"));
		}
		
		
		
	
	}
	
}







