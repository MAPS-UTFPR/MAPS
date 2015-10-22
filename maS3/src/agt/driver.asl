// Agent m1 in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }


//Background is the image reputation that an agent owns (0-1000)

/*Initials Goals*/

!arriveParking.

+!arriveParking : timeToArrive(TA)<- 
		.wait(TA); 
		!requestSpot;
		+arrivalParking.

+!requestSpot : myTrust(MT)
	<- .print("Arrived in the parking! Waiting for a spot...");
	   .send(manager,achieve,requestSpot(MT)).   

+!park(S)[source(AGENT)] : spotOk & arrivalParking & timeToSpend(TS)
	<- .print("Parking at the spot: ",S);
		+spot(S);
		.wait(TS);
		!leaveSpot.

+!leaveSpot : spot(S) <-
	.print("Leaving the parking...");	
	.send(manager,achieve,leaveSpot(S));
	-spot(S).

