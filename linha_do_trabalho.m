function [LDATA] = linha_do_trabalho(frequencia, resistividade_do_solo, com_cabos_para_raio)

%% Cria��o do template LDATA

LDATA = power_lineparam('new');

%% Defini��o dos par�metros f�sicos da linha de transmiss�o

% O sistema de unidade utilizado para o c�lculo � o m�trico.
LDATA.units = 'metric';

% A frequ�ncia, em hertz, para calcular os valores RLC. O pard�o � 60hz.
LDATA.frequency = frequencia;

% Resistividade do solo. Utilizamos 0 para facilitar o c�lculo pelo m�todo das imagens.
LDATA.groundResistivity = resistividade_do_solo;

% O n�mero de condutores de fase (condutores simples ou feixes de sub-condutores). 
% O padr�o � 3.
LDATA.Geometry.NPhaseBundle = 2;

% O n�mero de fios de aterramento (condutores simples ou feixes de sub-condutores). 
% O padr�o � 2.
LDATA.Geometry.NGroundBundle = 0;

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa o n�mero de fase ao qual os condutores pertencem. 
% V�rios condutores podem ter o mesmo n�mero de fase. 
% O n�mero de fase de terra � 0. O padr�o � [1 2 3 0 0].
LDATA.Geometry.PhaseNumber = [1,2];

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posi��o horizontal dos condutores, em metros ou p�s. 
% A localiza��o da posi��o de refer�ncia zero � arbitr�ria. 
% Para uma linha sim�trica, voc� normalmente escolhe X = 0 no centro da linha. 
% O padr�o � [-12 0 12 -8 8].
LDATA.Geometry.X = [0,1];

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posi��o vertical dos condutores (na torre) 
% em rela��o ao solo, em metros ou p�s. 
% O padr�o � [20 20 20 33 33].
LDATA.Geometry.Ytower = [8,8];

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa a posi��o vertical dos condutores em rela��o 
% ao solo a meia-esfera, em metros ou p�s. 
% O padr�o � [20 20 20 33 33].
LDATA.Geometry.Ymin = [8,8];

% Vetor 1-por-NPhaseBundle + NGroundBundle
% Este ajuste representa o tipo de condutor. 
% Os n�meros correspondem aos elementos do vetor definidos na estrutura dos Condutores. 
% O padr�o � [1 1 1 2 2].
LDATA.Geometry.ConductorType = [1,1];


% O di�metro externo do condutor, em cm. O padr�o � [3,5500 1,2700].
LDATA.Conductors.Diameter = 1.5;

% A rela��o T/D do condutor oco. 
% T � a espessura do material condutor, e D � o di�metro externo. 
% Este par�metro pode variar entre 0 e 0,5. 
% Um valor T/D de 0,5 indica um condutor s�lido. 
% Para condutores de cabos de alum�nio refor�ados com a�o (ACSR), 
% pode-se ignorar o n�cleo de a�o e considerar um condutor de alum�nio oco 
%(as rela��es t�picas de T/D est�o entre 0,3 e 0,4).
LDATA.Conductors.ThickRatio = 0.5;

% O Raio Geom�trico M�dio.(Geometric Mean Radius.)
LDATA.Conductors.GMR = 0.5841;

% A reat�ncia Xa, em ohms/km. (The default is 0)
LDATA.Conductors.Xa = 0;

% A resist�ncia do condutor em DC, em ohms/km. O padr�o � [0,0430 3,1060].
LDATA.Conductors.Res = 0.1601;

% A permeabilidade relativa dos condutores. O padr�o � [1 1].
LDATA.Conductors.Mur = 1;

% O n�mero de condutores por feixe (bundle). O padr�o � [4 1].
LDATA.Conductors.Nconductors = 1;

% O di�metro do feixe, em cm ou polegadas. O padr�o � [65 0].
LDATA.Conductors.BundleDiameter =0;

% O �ngulo, em graus, que determina a posi��o do primeiro condutor do 
% feixe em rela��o a uma linha horizontal paralela ao solo. 
% Este �ngulo determina a orienta��o do feixe. O padr�o � [45 0].
LDATA.Conductors.AngleConductor1 = 0;

% Ajustado para sim para incluir o impacto da freq��ncia na resist�ncia 
% e indut�ncia CA do condutor (efeito pele). 
% Se ajustado para n�o, a resist�ncia � mantida constante no valor 
% especificado pelo campo Res, e a indut�ncia � mantida constante no 
% valor calculado em DC, usando o campo Di�metro, e o campo ThickRatio.
LDATA.Conductors.skinEffect = 'no';

%% C�lculo dos par�metros RLC da linha de transmiss�o
LDATA = power_lineparam(LDATA);

end

