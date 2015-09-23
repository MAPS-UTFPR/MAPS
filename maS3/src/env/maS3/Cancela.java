// CArtAgO artifact code for project maS3

package maS3;

import cartago.*;

public class Cancela extends Artifact {
	
	void init(String msg) {		
		System.out.println("Mensagem do sistema: " + msg );
	}


	@OPERATION
	public void abrirCancela(){
		System.out.println("Abrindo cancela!");
		
	}
	
	@OPERATION
	public void fecharCancela(){
		System.out.println("Fechando cancela!");
	}
	

}

