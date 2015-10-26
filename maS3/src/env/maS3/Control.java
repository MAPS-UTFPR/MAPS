// CArtAgO artifact code for project maS3

package maS3;

import java.util.Date;
import java.util.LinkedList;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;


public class Control extends Artifact {
	
	public LinkedList <Driver> waitingQueue;
	Driver driver;	
	
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
		
		System.out.println("Waiting Queue: " + waitingQueue);
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

