// Agent m1 in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }


//Background is the image reputation that an agent owns (0-1000)
myBackground(100).
timeToSpend(10000).
timeToGet(4000).
vaga(0).

/*Initials Goals*/

!chegarEstacionamento.

+!chegarEstacionamento : timeToGet(TG)<- 
		.wait(math.random(TG)); 
		!requisitarVaga;
		+chegadaEstacionamento.

+!requisitarVaga : myBackground(B)
	<- .print("Cheguei no estacionamento!, \nAguardando liberação da vaga...");
	   .send(gerente,achieve,requisicaoVaga(B)).   

+!estacionar(V)[source(AGENT)] : vagaLiberada & chegadaEstacionamento & timeToSpend(TS)
	<- .print("Estacionando na vaga: ",V);
		+vaga(V);
		.wait(TS);
		!sairEstacionamento.

+!sairEstacionamento : vaga(V) <-
	.print("Saindo estacionamento...");	
	.send(gerente,achieve,liberarVaga(V));
	-vaga(V).

