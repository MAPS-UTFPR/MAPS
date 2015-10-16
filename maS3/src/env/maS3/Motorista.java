package maS3;

import java.util.Date;

public class Motorista {
	
	private String id;
	private int background;
	private Date dataChegada;
	
	public Motorista(){
		
	}
	
	public Motorista(String id, int b, Date t){
		this.id = id;
		this.background = b;
		this.dataChegada = t;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getBackground() {
		return background;
	}

	public void setBackground(int background) {
		this.background = background;
	}
	
	public Date getWaitTime(){
		return dataChegada;
	}
	
	public void setWaitTime(Date time){
		dataChegada = time;
	}
	
	@Override
	public String toString() {
		return this.id.concat(" - " + this.background + " - (" + this.dataChegada + ")");
	}
	
	

}
