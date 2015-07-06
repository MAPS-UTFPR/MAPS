//Initials goals and beliefs
estacionamento(v,3).

+!requisicaoVaga[source(AGENT)]: estacionamento(X,Y) & Y > 0
	<- .print("Vaga alocada para: ",AGENT); -estacionamento(v,Y); 
		+estacionamento(v,Y-1); !imprimirVagas.
	
+!imprimirVagas : estacionamento(X,Y) 
	<- .print("Vagas Disponiveis: ",Y).