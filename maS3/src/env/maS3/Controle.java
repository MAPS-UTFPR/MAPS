// CArtAgO artifact code for project maS3

package maS3;

import java.util.LinkedList;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.ObsProperty;
import cartago.OpFeedbackParam;


public class Controle extends Artifact {
	
	LinkedList <Object> listaEspera;
	
	void init(String msg){
		listaEspera = new LinkedList<Object>();
        defineObsProperty("first", "empty");       

	}
	
	@OPERATION
	public void insereMotoristaFila(Object idMotorista){
		
		//System.out.println("Motorista: " + idMotorista + " entrou na fila!");
		listaEspera.add(idMotorista);
		System.out.println("Tipo:" + idMotorista.getClass());
		System.out.println("Fila de espera: " + listaEspera);
	}
	
	@OPERATION
	public void isAnyone(OpFeedbackParam<Boolean> cond){
		cond.set(listaEspera.isEmpty());
			
	}
	
	@OPERATION
	public void liberaMotorista(OpFeedbackParam<Object> idMotorista){	
		ObsProperty opFirst = getObsProperty("first");
		opFirst.updateValue(listaEspera.getFirst());
		idMotorista.set(listaEspera.getFirst());
		listaEspera.removeFirst();
	}
	
	
	
	
	
}

