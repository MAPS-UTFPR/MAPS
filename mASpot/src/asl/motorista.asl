/*Initials Goals*/

!chegarEstacionamento.
!requisitarVaga.

+!chegarEstacionamento : true <- +chegadaEstacionamento.

+!requisitarVaga : chegadaEstacionamento 
	<- .print("Cheguei no estacionamento!"); .print("Aguardando liberação da vaga..."); 
	   .send(gerente,achieve,requisicaoVaga).

+!estacionar : vagaLiberada & chegadaEstacionamento 
	<- .print("Estacionando na vaga...").

