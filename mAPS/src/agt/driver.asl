// Agent driver in project mAPS
// Trust is the value that an agent owns (0-1000)

/*Initials Goals*/

!arriveParking.

+!arriveParking : timeToArrive(TA)<- 
		.wait(TA); 
		!requestSpot;
		+arrivalParking.

+!requestSpot
	<- .print("Arrived in the parking! Waiting for a spot...");
	   .send(manager,achieve,requestSpot).   

+!park(S)[source(AGENT)] : spotOk & arrivalParking & timeToSpend(TS)
	<- .print("Parking at the spot: ",S);
		+spot(S);
		.wait(TS);
		!leaveSpot.

+!leaveSpot : spot(S) & timeToArrive(TA) <-
	.print("Leaving the parking...");	
	.send(manager,achieve,leaveSpot(S));
	-spot(S).
	//.send(manager,achieve,requestSpot).   
	
	
	




{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
//{ include("$jacamoJar/templates/org-obedient.asl") }
