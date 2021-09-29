%% Trabalho de Transmissão
% Disciplina: ENGC 47
%
% Professor: Fernando Augusto Moreira 
%
% Discentes:   Henrique de Moura Sinezio, Moira Bastos Prates, Ricardo Messala


%% Modelo RLC de linha de transmissão com cabos para-raio, f=60Hz, R_solo = 0  ohm . m

[LDATA] = linha_do_trabalho(60, 0, true);

display("Valores de R")
display(LDATA.R)

display("Valores de L")
display(LDATA.L)

display("Valores de C")
display(LDATA.C)

%% Modelo RLC de linha de transmissão com cabos para-raio, f=60Hz, R_solo = 1000  ohm . m
%% Modelo RLC de linha de transmissão com cabos para-raio, f=1kHz, R_solo = 0  ohm . m
%% Modelo RLC de linha de transmissão com cabos para-raio, f=1kHz, R_solo = 1000  ohm . m

%% Modelo RLC de linha de transmissão sem cabos para-raio, f=60Hz, R_solo = 0 ohm . m
%% Modelo RLC de linha de transmissão sem cabos para-raio, f=60Hz, R_solo = 1000  ohm . m
%% Modelo RLC de linha de transmissão sem cabos para-raio, f=1kHz, R_solo = 0  ohm . m
%% Modelo RLC de linha de transmissão sem cabos para-raio, f=1kHz, R_solo = 1000 ohm . m