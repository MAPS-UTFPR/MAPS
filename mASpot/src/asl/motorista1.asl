!chegarEstacionamento.
!requisitarVaga.
!requisitarVaga2.
//!start.


+!chegarEstacionamento : true <- +cheguei; .print("Motorista1 chegou no estacionamento!").


//+!start : true <- .send(gerente , tell , hello).

+!requisitarVaga : cheguei <- .send(gerente, tell, requisicaoVaga); .print("teste").
+!requisitarVaga2 : cheguei <- .send(gerente, tell, requisicaoVaga); .print("teste2").



+!espere <- .print("Espere ae vei").

