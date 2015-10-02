// Agent gerente in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

/* Initial beliefs and rules */

nVagasMAX(1).
nVagasUsadas(0).
isFull(false).
pLotacao(0).

estacionamento(0,0, "EMPTY").
//estacionamento(1,0, "EMPTY").
//estacionamento(2,0, "EMPTY").
//estacionamento(3,0, "EMPTY").
//estacionamento(4,0, "EMPTY").
//estacionamento(5,0, "EMPTY").
//estacionamento(6,0, "EMPTY").
//estacionamento(7,0, "EMPTY").
//estacionamento(8,0, "EMPTY").
//estacionamento(9,0, "EMPTY").
//estacionamento(10,0, "EMPTY").
//estacionamento(11,0, "EMPTY").
//estacionamento(12,0, "EMPTY").
//estacionamento(13,0, "EMPTY").
//estacionamento(14,0, "EMPTY").
//estacionamento(15,0, "EMPTY").
//estacionamento(16,0, "EMPTY").
//estacionamento(17,0, "EMPTY").
//estacionamento(18,0, "EMPTY").
//estacionamento(19,0, "EMPTY").
//estacionamento(20,0, "EMPTY").



/* Initial goals */

!setupParking.

//Initials goals and beliefs

+!setupParking <-
	     makeArtifact("a_Cancela", "maS3.Cancela", ["Starting"], ArtId);
	     focus(ArtId);
	     .print("Estacionamento aberto!");
	     
	     makeArtifact("a_Controle", "maS3.Controle", ["20"], ArtId2);
	     focus(ArtId2).
	     
+!requisicaoVaga(BACKGROUND)[source(AG)] <-
	.term2string(AG,AGENT);
	.print("Agente: ",AGENT," requisitou uma vaga! - Background:(",BACKGROUND,")");	
	!alocaVaga(AGENT,BACKGROUND).
	
+!requisicaoVaga(AGENT,BACKGROUND,C) <-
	.print("Agente: ",AGENT," requisitou uma vaga! (SECOND)");	
	!alocaVaga(AGENT,BACKGROUND).
	
	
+!alocaVaga(AGENT,BACKGROUND) : 
					nVagasUsadas(N) & 
					nVagasMAX(MAX) & 
					isFull(COND) &
					pLotacao(P) & 
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
			
			-pLotacao(P);					
			+pLotacao(((N+1) * 100) / MAX);
			.print("Porcentagem Lotacao: ",((N+1) * 100) / MAX,"%");
			
			
			
			
			!imprimeVagas;			
			-~find;
		}
	};
	+~find.
	
+!alocaVaga(AGENT,BACKGROUND) : isFull(COND) & COND = true <- 
		insereMotoristaFila(AGENT,BACKGROUND).
		
	
+!imprimeVagas <-
	for(estacionamento(V,Z,AG)){
	     	 	.print("Vaga: ",V," - Estado: ",Z, " - Agente: ",AG);	     
	     }.
	     
+!verificaFila : nVagasUsadas(N) & isFull(COND)<-
	
	isAnyone(C);
	if(C = false){
		liberaMotorista(AG,BG);
		!requisicaoVaga(AG,BG,true);
	}else{
		.print("Ninguem na fila!");
	}.
	     
+!liberarVaga(V)[source(AG)] : nVagasUsadas(N) & nVagasMAX(MAX) &  isFull(COND) &
					pLotacao(P) <-
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
	
	
	

