// Agent m1 in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }


//Background is the image reputation that an agent owns (0-1000)
myBackground(100).
timeToSpend(10000).

/*Initials Goals*/

!chegarEstacionamento.

+!chegarEstacionamento <- 
		.wait(math.random(1000)+4000); 
		!requisitarVaga;
		+chegadaEstacionamento.

+!requisitarVaga
	<- .print("Cheguei no estacionamento!, \nAguardando liberação da vaga...");
	   .send(gerente,achieve,requisicaoVaga).	   

+!estacionar(V)[source(AGENT)] : vagaLiberada & chegadaEstacionamento & timeToSpend(T)
	<- .print("Estacionando na vaga: ",V);
		+vaga(V);
		.wait(T);
		!sairEstacionamento.

+!sairEstacionamento : vaga(V) <-
	.print("Saindo estacionamento...");	
	.send(gerente,achieve,liberarVaga(V));
	-vaga(V).

