// Agent m1 in project maS3

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }


//Background is the image reputation that an agent owns (0-1000)
myBackground(10).

/*Initials Goals*/

!chegarEstacionamento.

+!chegarEstacionamento <- 
		.wait(3000); 
		!requisitarVaga;
		+chegadaEstacionamento.

+!requisitarVaga 
	<- .print("Cheguei no estacionamento!, \nAguardando liberação da vaga...");
	   .send(gerente,achieve,requisicaoVaga).	   

+!estacionar(V)[source(AGENT)] : vagaLiberada & chegadaEstacionamento 
	<- .print("Estacionando na vaga: ",V).
