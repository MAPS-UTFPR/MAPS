// Agent gerente in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

nVagasMAX(2).

nVagasUsadas(0).
isFull(false).

estacionamento(0,0, "EMPTY").
estacionamento(1,0, "EMPTY").
//estacionamento(2,0, "EMPTY").
//estacionamento(3,0, "EMPTY").
//estacionamento(4,0, "EMPTY").
//estacionamento(5,0, "EMPTY").

/* Initial goals */

!setupParking.

//Initials goals and beliefs

+!setupParking <-
	     makeArtifact("a_Cancela", "maS3.Cancela", ["Starting"], ArtId);
	     focus(ArtId);
	     .print("Estacionamento aberto!");
	     
	     makeArtifact("a_Controle", "maS3.Controle", ["20"], ArtId2);
	     focus(ArtId2).
	     
+!requisicaoVaga[source(AG)] <-
	.term2string(AG,AGENT);
	.print("Agente: ",AGENT," requisitou uma vaga!");	
	!alocaVaga(AGENT).
	
+!requisicaoVaga(AGENT) <-
	.print("Agente: ",AGENT," requisitou uma vaga! (SECOND)");	
	!alocaVaga(AGENT).
	
	
+!alocaVaga(AGENT) : 
					nVagasUsadas(N) & 
					nVagasMAX(MAX) & 
					isFull(COND) &
					COND = false 
					<- 
	
	+~find;
	
	for(estacionamento(V,Z,S)){
		if( S = "EMPTY" & ~find & (COND = false)){
			-estacionamento(V,Z,S); +estacionamento(V,1,AGENT);						
			.print("Vaga (",V,") alocada para o agente: ",AGENT);
			
			abrirCancela;
			
			.send(AGENT,tell,vagaLiberada); .send(AGENT,achieve,estacionar(V));
			
			fecharCancela;
			
			-nVagasUsadas(N); +nVagasUsadas(N+1);
			

			if((N+1) = MAX){
				-isFull(COND);
				+isFull(true);
				.print("Estacionamento CHEIO!");
			};
			
			
			
			!imprimeVagas;			
			-~find;
		}
	};
	+~find.
	
+!alocaVaga(Ag) : isFull(COND) & COND = true <- 
		insereMotoristaFila(Ag).
		
	
+!imprimeVagas <-
	for(estacionamento(V,Z,AG)){
	     	 	.print("Vaga: ",V," - Estado: ",Z, " - Agente: ",AG);	     
	     }.
	     
+!verificaFila : nVagasUsadas(N) & isFull(COND) <-
	
	isAnyone(C);
	if(C = false){
		liberaMotorista(Ag);
		!requisicaoVaga(Ag);
	}else{
		.print("Ninguem na fila!");
	}.
	     
+!liberarVaga(V)[source(AG)] : nVagasUsadas(N) & isFull(COND)<-
	.term2string(AG,AGENT);
	.print(AGENT," liberando vaga: ",V);
	
	-nVagasUsadas(N);
	+nVagasUsadas(N-1);
	
	-isFull(COND);
	+isFull(false);
	
	+estacionamento(V , 0 , "EMPTY");	
	-estacionamento(V,1,AGENT);	
	
	.kill_agent(AGENT);
	
	!verificaFila.
	
	
	

