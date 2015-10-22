// CArtAgO artifact code for project maS3

package maS3;

import java.util.Date;
import java.util.LinkedList;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;


public class Control extends Artifact {
	
	public LinkedList <Driver> waitingQueue;
	public LinkedList <Driver> listaTotal = new LinkedList<Driver>();

	Driver driver;
	public float tempoTotal = 0;
	int numMotoristas = 7;
	
	public final int WAIT_TIME = 60000;
	
	
	
	void init(String msg){
		waitingQueue = new LinkedList<Driver>();
        defineObsProperty("first", "empty");       

	}
	
	@OPERATION
	public void insertDriverQueue(Object idDriver, Object tDriver){
		
		System.out.println("Driver: " + idDriver + " got in queue!");
		driver = new Driver(idDriver.toString(), Integer.parseInt(tDriver.toString()), new Date());
		waitingQueue.add(driver);
		//System.out.println("Tipo:" + idMotorista.getClass());
		System.out.println("Fila de espera: " + waitingQueue);
		listaTotal.add(driver);
	}
	
	@OPERATION
	public void isAnyone(OpFeedbackParam<Boolean> cond){
		cond.set(waitingQueue.isEmpty());
			
	}
	
	@OPERATION
	public void freeDriver(OpFeedbackParam<Object> idDriver, OpFeedbackParam<Object> tDriver){
		
		Driver d = greatestTrust();
		
		idDriver.set(d.getId());
		tDriver.set(d.getBackground());
		
		waitingQueue.remove(d);
		d.dataAlocacao = new Date();
		tempoTotal += d.dataAlocacao.getTime() - d.getArrivalTime().getTime();
		
	}
	
	@OPERATION
	public void calculaTempoMedio(){
		
		System.out.println("========================================");
		System.out.println("TEMPO MEDIO DE ALOCACAO: " + (tempoTotal/1000)/numMotoristas);
		System.out.println("Quantidade de motoristas FILA: " + listaTotal.size());
		System.out.println("========================================");
		for(Driver m : listaTotal){
			System.out.println("========================================");
			System.out.println("Motorista: " + m.getId());
			System.out.println("Background: " + m.getBackground());
			System.out.println("Hora chegada: " + m.getArrivalTime());
			System.out.println("Hora de alocacao: " + m.dataAlocacao);
			System.out.println("Tempo de espera: " + ((m.dataAlocacao.getTime() -  m.getArrivalTime().getTime())/1000) + "s");
		}
	}
	
	public Driver greatestTrust(){
		
		Driver d1 = new Driver();		
		
		for(Driver d : waitingQueue){		
			if(new Date().getTime() - d.getArrivalTime().getTime() > WAIT_TIME)
				return d;
		}
		
		for(Driver d : waitingQueue){			
			if(d1.getBackground() < d.getBackground())
				d1 = d; 
		}
		
		return d1;
	}
	
	
	
	
	
}

