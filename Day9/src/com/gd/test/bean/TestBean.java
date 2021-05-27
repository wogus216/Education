package com.gd.test.bean;

public class TestBean {
	private int no;
	private String name;
	private int age;
	private String address;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getNo() { //getter는값을 가져올 때
		return no;
	}
	public void setNo(int no) {//setter는 값을 넣을 때
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	
}
