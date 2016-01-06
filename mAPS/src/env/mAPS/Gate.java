// CArtAgO artifact code for project mAPS

package mAPS;

import cartago.*;

public class Gate extends Artifact {
	
	void init(String msg) {		
		System.out.println("System message: " + msg );
	}


	@OPERATION
	public void openGate(){
		System.out.println("Opening gate!");
		
	}
	
	@OPERATION
	public void closeGate(){
		System.out.println("Closing gate!");
	}
	

}


