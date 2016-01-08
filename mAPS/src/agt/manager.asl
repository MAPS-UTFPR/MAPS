// Agent manager in project mAPS

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

nSpotsMAX(1).
nSpotsUsed(0).
isFull(false).
pFull(0).


spot(0,0, "EMPTY").
//spot(1,0, "EMPTY").
//spot(2,0, "EMPTY").
//spot(3,0, "EMPTY").
//spot(4,0, "EMPTY").
//spot(5,0, "EMPTY").
//spot(6,0, "EMPTY").
//spot(7,0, "EMPTY").
//spot(8,0, "EMPTY").
//spot(9,0, "EMPTY").
//spot(10,0, "EMPTY").
//spot(11,0, "EMPTY").
//spot(12,0, "EMPTY").
//spot(13,0, "EMPTY").
//spot(14,0, "EMPTY").
//spot(15,0, "EMPTY").
//spot(16,0, "EMPTY").
//spot(17,0, "EMPTY").
//spot(18,0, "EMPTY").
//spot(19,0, "EMPTY").
//spot(20,0, "EMPTY").
//spot(21,0, "EMPTY").
//spot(22,0, "EMPTY").
//spot(23,0, "EMPTY").
//spot(24,0, "EMPTY").



/* Initial goals */

!setupParking.

//Initials goals and beliefs

+!setupParking <-
	     makeArtifact("a_Gate", "mAPS.Gate", ["Starting"], ArtId);
	     focus(ArtId);
	     .print("Parking has opened");
	     
	     makeArtifact("a_Control", "mAPS.QueueControl", ["20"], ArtId2);
	     focus(ArtId2);
	     
	     makeArtifact("a_DBControl", "mAPS.DBControl", ["20"], ArtId3);
	     focus(ArtId3).
	     
+!requestSpot[source(AG)] <-
	.term2string(AG,AGENT);	
	getDriver(AGENT,TRUST);	
	.print("Agent: ",AGENT," has requested a spot! - TRUST: ", TRUST);		
	!allocateSpot(AGENT,TRUST).
	
+!requestSpotQueue(AGENT,TRUST) <-
	.print("Agent: ",AGENT," has requested a spot from Queue! - Trust:(",TRUST,")");	
	!allocateSpot(AGENT,TRUST).
	
	
+!allocateSpot(AGENT,TRUST) : 
					nSpotsUsed(N) & 
					nSpotsMAX(MAX) & 
					isFull(COND) &
					pFull(P) & 
					COND = false 
					<- 
	
	+~find;
	
	for(spot(S,C,A)){
		if(A = "EMPTY" & ~find & (COND = false)){
			-spot(S,C,A); +spot(S,1,AGENT);	
			
			.print("Spot (",S,") has allocated for the agent: ",AGENT);
			
			openGate;
			
			.send(AGENT,tell,spotOk); 
			.send(AGENT,achieve,park(S));
			insertOrUpdateDriver(AGENT,TRUST+20);
			
						
			-nSpotsUsed(N); +nSpotsUsed(N+1);
			
			if((N+1) = MAX){
				-isFull(COND);
				+isFull(true);
				.print("Parking lot FULL!");
			};
			
			-pFull(P);					
			+pFull(((N+1) * 100) / MAX);
			.print("Parking usage: ",((N+1) * 100) / MAX,"%");
			
			closeGate;
			
			
			
			!printSpots;			
			-~find;
		}
	};
	+~find.
	
+!allocateSpot(AGENT,TRUST) : isFull(COND) & COND = true <- 
		insertDriverQueue(AGENT,TRUST).
		
	
+!printSpots <-
	for(spot(V,Z,AG)){
	     	 	.print("Spot: ",V," - Condition: ",Z, " - Agent: ",AG);	     
	     }.
	     
+!checkQueue : nSpotsUsed(N) & isFull(COND)<-
	
	isAnyone(C);
	if(C = false){
		freeDriver(AG,BG);
		!requestSpotQueue(AG,BG);
	}else{
		.print("Nobody at queue");
	}.
	     
+!leaveSpot(S)[source(AG)] : nSpotsUsed(N) & nSpotsMAX(MAX) &  isFull(COND) &
					pFull(P) <-
	.term2string(AG,AGENT);
	.print(AGENT," leaving the spot: ",S);
	
	-nSpotsUsed(N);
	+nSpotsUsed(N-1);
	
	-isFull(COND);
	+isFull(false);
	
	
	+spot(S,0,"EMPTY");	
	-spot(S,1,AGENT);	
	
	//.kill_agent(AGENT);
	
	!checkQueue.
	
	
	

