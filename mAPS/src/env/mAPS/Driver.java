package mAPS;

import java.util.Date;

public class Driver {
	
	private String id;
	private int myTrust;
	private Date arrivalTime;
	
	public Driver(){
		
	}
	
	public Driver(String id, int b, Date t){
		this.id = id;
		this.myTrust = b;
		this.arrivalTime = t;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getBackground() {
		return myTrust;
	}

	public void setTrust(int trust) {
		this.myTrust = trust;
	}
	
	public Date getArrivalTime(){
		return arrivalTime;
	}
	
	public void setArrivalTime(Date time){
		arrivalTime = time;
	}
	
	@Override
	public String toString() {
		return this.id.concat(" - " + this.myTrust);
	}
	
	

}

