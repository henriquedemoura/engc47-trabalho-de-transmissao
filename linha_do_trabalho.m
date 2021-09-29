function [LDATA] = linha_do_trabalho(frequencia, resistividade_do_solo, com_cabos_para_raio)

%% Criação do template LDATA

LDATA = power_lineparam('new');

%% Definição dos parâmetros físicos da linha de transmissão

% O sistema de unidade utilizado para o cálculo é o métrico.
LDATA.units = 'metric';

% A frequência, em hertz, para calcular os valores RLC. O pardão é 60hz.
LDATA.frequency = frequencia;

% Resistividade do solo. Utilizamos 0 para facilitar o cálculo pelo método das imagens.
LDATA.groundResistivity = resistividade_do_solo;

% O número de condutores de fase (condutores simples ou feixes de sub-condutores). 
% O padrão é 3.
LDATA.Geometry.NPhaseBundle = 3;

% O número de fios de aterramento (condutores simples ou feixes de sub-condutores). 
% O padrão é 2.
if (com_cabos_para_raio == true)
    LDATA.Geometry.NGroundBundle = 2;
else
    LDATA.Geometry.NGroundBundle = 0;
end

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa o número de fase ao qual os condutores pertencem. 
% Vários condutores podem ter o mesmo número de fase. 
% O número de fase de terra é 0. O padrão é [1 2 3 0 0].
if (com_cabos_para_raio == true)
    LDATA.Geometry.PhaseNumber = [1, 2, 3, 0, 0];
else
    LDATA.Geometry.PhaseNumber = [1, 2, 3];
end

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posição horizontal dos condutores, em metros ou pés. 
% A localização da posição de referência zero é arbitrária. 
% Para uma linha simétrica, você normalmente escolhe X = 0 no centro da linha. 
% O padrão é [-12 0 12 -8 8].
if (com_cabos_para_raio == true)
    LDATA.Geometry.X = [-12, 0, 12, -7.85, 7.85];
else
    LDATA.Geometry.X = [-12, 0, 12];
end
    
% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posição vertical dos condutores (na torre) 
% em relação ao solo, em metros ou pés. 
% O padrão é [20 20 20 33 33].
if (com_cabos_para_raio == true)
    LDATA.Geometry.Ytower = [21.63, 21.63, 21.63, 30.5, 30.5];
else
    LDATA.Geometry.Ytower = [21.63, 21.63, 21.63];
end

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posição vertical dos condutores em relação 
% ao solo a meia-vão, em metros ou pés. 
% O padrão é [20 20 20 33 33].
if (com_cabos_para_raio == true)
    LDATA.Geometry.Ymin = [9.83, 9.83, 9.83, 23.23, 23.23];
else
    LDATA.Geometry.Ymin = [9.83, 9.83, 9.83];
end

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa o tipo de condutor. 
% Os números correspondem aos elementos do vetor definidos na estrutura dos Condutores. 
% O padrão é [1 1 1 2 2].
if (com_cabos_para_raio == true)
    LDATA.Geometry.ConductorType = [1, 1, 1, 2, 2];
else
    LDATA.Geometry.ConductorType = [1, 1, 1];
end

% O diâmetro externo do condutor, em cm. O padrão é [3,5500 1,2700].
if (com_cabos_para_raio == true)
    LDATA.Conductors.Diameter = [3.18, 1.46];
else
     LDATA.Conductors.Diameter = 3.18;
end

% A relação T/D do condutor oco. 
% T é a espessura do material condutor, e D é o diâmetro externo. 
% Este parâmetro pode variar entre 0 e 0,5. 
% Um valor T/D de 0,5 indica um condutor sólido. 
% Para condutores de cabos de alumínio reforçados com aço (ACSR), 
% pode-se ignorar o núcleo de aço e considerar um condutor de alumínio oco 
%(as relações típicas de T/D estão entre 0,3 e 0,4).
if (com_cabos_para_raio == true)
    LDATA.Conductors.ThickRatio = [0.231, 0.5];
else
    LDATA.Conductors.ThickRatio = [0.231];
end

% O Raio Geométrico Médio.(Geometric Mean Radius.)
% isso se usa?
% LDATA.Conductors.GMR = [0.5841, 0.360]; %??????

% A reatância Xa, em ohms/km. (The default is 0)
% precisa?
%LDATA.Conductors.Xa = [0, 0];

% A resistência do condutor em DC, em ohms/km. O padrão é [0,0430 3,1060].
if (com_cabos_para_raio == true)
    LDATA.Conductors.Res = [0.0522, 0.360];
else
    LDATA.Conductors.Res = [0.0522];
end


% A permeabilidade relativa dos condutores. O padrão é [1 1].
if (com_cabos_para_raio == true)
    LDATA.Conductors.Mur = [1, 1];
else
    LDATA.Conductors.Mur = [1];    
end

% O número de condutores por feixe (bundle). O padrão é [4 1].
if (com_cabos_para_raio == true)
    LDATA.Conductors.Nconductors = [2, 1];
else
    LDATA.Conductors.Nconductors = [2];
end

% O diâmetro do feixe, em cm ou polegadas. O padrão é [65 0].
if (com_cabos_para_raio == true)
    LDATA.Conductors.BundleDiameter = [40, 0];
else
    LDATA.Conductors.BundleDiameter = [40];
end

% O ângulo, em graus, que determina a posição do primeiro condutor do 
% feixe em relação a uma linha horizontal paralela ao solo. 
% Este ângulo determina a orientação do feixe. O padrão é [45 0].
if (com_cabos_para_raio == true)
    LDATA.Conductors.AngleConductor1 = [0, 0];
else
    LDATA.Conductors.AngleConductor1 = [0];
end


% Ajustado para sim para incluir o impacto da freqüência na resistência 
% e indutância CA do condutor (efeito pele). 
% Se ajustado para não, a resistência é mantida constante no valor 
% especificado pelo campo Res, e a indutância é mantida constante no 
% valor calculado em DC, usando o campo Diâmetro, e o campo ThickRatio.
LDATA.Conductors.skinEffect = 'no';

%% Cálculo dos parâmetros RLC da linha de transmissão
LDATA = power_lineparam(LDATA);

end

