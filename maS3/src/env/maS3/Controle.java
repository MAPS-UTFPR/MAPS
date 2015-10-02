// CArtAgO artifact code for project maS3

package maS3;

import java.util.LinkedList;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.ObsProperty;
import cartago.OpFeedbackParam;


public class Controle extends Artifact {
	
	public LinkedList <Motorista> listaEspera;
	Motorista motorista;
	
	
	
	void init(String msg){
		listaEspera = new LinkedList<Motorista>();
        defineObsProperty("first", "empty");       

	}
	
	@OPERATION
	public void insereMotoristaFila(Object idMotorista, Object bMotorista){
		
		//System.out.println("Motorista: " + idMotorista + " entrou na fila!");
		motorista = new Motorista(idMotorista.toString(), Integer.parseInt(bMotorista.toString()));
		listaEspera.add(motorista);
		System.out.println("Tipo:" + idMotorista.getClass());
		System.out.println("Fila de espera: " + listaEspera);
	}
	
	@OPERATION
	public void isAnyone(OpFeedbackParam<Boolean> cond){
		cond.set(listaEspera.isEmpty());
			
	}
	
	@OPERATION
	public void liberaMotorista(OpFeedbackParam<Object> idMotorista, OpFeedbackParam<Object> bMotorista){
		
		Motorista m = maiorReputacao();
		ObsProperty opFirst = getObsProperty("first");
		//opFirst.updateValue(listaEspera.getFirst());
		
		idMotorista.set(m.getId());
		bMotorista.set(m.getBackground());
		listaEspera.remove(m);
	}
	
	public Motorista maiorReputacao(){
		
		Motorista m1 = new Motorista();		
		
		for(Motorista m : listaEspera){
			if(m1.getBackground() < m.getBackground())
				m1 = m;
		}
		
		return m1;
		
	}
	
	
	
	
	
}

