package maS3;

public class Motorista {
	
	private String id;
	private int background;
	
	public Motorista(){
		
	}
	
	public Motorista(String id, int b){
		this.id = id;
		this.background = b;
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
	
	@Override
	public String toString() {
		return this.id.concat(" - " + this.background);
	}
	
	

}
