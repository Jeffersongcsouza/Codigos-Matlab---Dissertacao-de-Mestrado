% Sistema de Suspensão - Modelos Passivo e Semiativo 1/2 Carro
% Autor: Jefferson Gomes de Carvalho Souza
%% CAMINHÃO PROJETO DISSERTAÇÃO (SCANIA)%%
% PARÂMETROS %
clc
g=9.81; %Aceleração da gravidade [m/S^2]
%% Geometria do carro
a1=1.990; %Comprimento eixo diantero ao CG [m]
a2=1.988; %Comprimento eixo traseiro ao CG [m]
hcg=1.359; %altura do centro de gravidade do caminhão e do bogie [m]
bw=2.479; % Bitola [m]
Lt=8.63; %[m] Comprimento total do veículo
W=3.26; %[m] Largura total do veículo
%% Geometria do bogie
b1=0.675;
b2=0.675;
%% TIPO DE SOLO (sinusoidal)
fr=0.01; %Coeficiente ao rolamento (WONG,2001, p. 18)
d=50; % Posição do começo da lombada em [m]
L=7;  % Período da lombada (comprimento entre picos) em [m] (PISTA DE BOULOGNE)
h=0.3; % Altura da lombada [m] (PISTA DE BOULOGNE)
dh=0.1; % Altura do degrau [m] só para os teste em solo deformável
%% MASSA CAMINHÃO COMPLETO
mv=22560; % Massa veiculo [kg]
ms=18470; % Massa suspensa [kg]
ms_b=200; %Massa suspensa do bogie [kg]
m1=490;  %Massa não suspensa diantera[N](1 roda + 1/2 eixo)
m2=1700;  %Massa não suspensa traseira [N] (1 roda + 1/2 eixo)
m3=1700;  %Massa não suspensa traseira [N] (1 roda + 1/2 eixo)
%% PNEU  395/85R20
r_ind=(20*25.4/2+0.5*0.85*395)/1000;%0.542;   %r_ind=r_aro+h_pneu     h_pneu(50%)=0.1975 m  ;  r_aro=0.254 m%STATIC LADEN RADIUS  
r_est=0.542; %STATIC LADEN RADIUS (MICHELIN MILITARY  TYRES DATA BOOK,2017) 
Iroda=14; %Momento de inércia da roda no eixo [kgm^2]
bp1=2660;    %Coeficiente do amortiçamento(70Ns/m ~ 150Ns/m)(BUMPER)
kp1=770700; %Constante elástica (160000N/m ~ 250000N/m)
             %(205/50/R15)

bp2=2660;    %Coeficiente do amortiçamento(70Ns/m ~ 150Ns/m)(BUMPER)
kp2=770700; %Constante elástica (160000N/m ~ 250000N/m)

bp3=2660;    %Coeficiente do amortiçamento(70Ns/m ~ 150Ns/m)(BUMPER)
kp3=770700; %Constante elástica (160000N/m ~ 250000N/m)

%% Parametros Susp. Dianteira Ativa (Função de Transferência de malha fechada)

m11 = 490; %m1
m22 = 4500; %m2
kp11 = 870000; %k1
ks11 = 55000; %k2
bs11 = 24500; %c2
bp11 = 2660; %c1

%% SUSPENSÃO 
gama=0; %ângulo de câmber em [º]
bs1=20000; %AMORTECEDOR SUSPENSÃO    [bs] (300Ns/m ~ 3000Ns/m)
ks1= 59000; %MOLA SUSPENSÃO   [ks] (10000Nm ~ 20000Nm)

bs2=10000; %AMORTECEDOR SUSPENSÃO    [bs] (300Ns/m ~ 3000Ns/m)
ks2=3220000; %MOLA SUSPENSÃO   [ks] (10000Nm ~ 20000Nm)

bs3=8000; %AMORTECEDOR SUSPENSÃO    [bs] (300Ns/m ~ 3000Ns/m)
ks3=2740000;%3220000; %MOLA SUSPENSÃO   [ks] (10000Nm ~ 20000Nm)
%MOMENTO DE INERCIA DO CHASSIS Iyy: 
Iyy=284800;%104000; %(ms*a1*a2)
%MOMENTO DE INERCIA DO BOGIE Ibyy: 
 %Ibyy=ms_b*b1*b2; %Equação usada em TRUCKSIM
%MOMENTO DE INERCIA DO VEÍCULO Izz:
Izz=281100;%727.390; %[kg*m^2]%Obtidos do CAD (Solid Edge)
%MOMENTO DE INERCIA DO VEÍCULO Ixx:
Ixx=35080.8; %[kg*m^2]%Obtidos do CAD (Solid Edge)
%MOMENTO DE INERCIA DO BOGIE
Ibyy=66.080; %[kg*m^2]
%Força longitudinal (Fórmula Magica - Pacejka) 
    %%Dados do TRUCKSIM 2016
Pacejka=load('Pacejka_Trucksim.dat');
Pacejka(1,:)=zeros;

slip=Pacejka(:,1)*100;
FX=Pacejka(:,4);

w0=20; %Velocidade inicial das rodas [rad/s]
%plot(x_cg,y_cg,'*r',x1,y1,'+',x2,y2,'o',x3,y3,x4,y4,x5,y5,x6,y6)
%================================================================================
%% =====================Calculo dos Calfaf e Calfar============================
vx=5.5;%16.6667;%10; %[m/s]
Calfa=5600*180/pi;%5600.5 [N/º] até [N/rad] Para Fz 5390 kg segundo MICHELIN 16.00R20 (Babullal, 2015)
%Eixo dianteiro
CalfafE=Calfa;
CalfafD=Calfa;
Calfaf=CalfafE+CalfafD;
%Eixo intermediario
CalfaiE=Calfa;
CalfaiD=Calfa;
Calfai=CalfaiE+CalfaiD;
%Eixo traseiro
CalfatE=Calfa;
CalfatD=Calfa;
Calfat=CalfatE+CalfatD;

%DERIVADAS PARCIAIS DE Fy (psis,beta,delta)

%dFy/dpsip
Cr=(-a1/vx)*Calfaf+((a2-b1)/vx)*Calfai+((a2+b2)/vx)*Calfat;          %Pag 616
%DFy/dbeta
Cbeta=-Calfaf-Calfai-Calfat;
%dFy/d_delta
Cdelta=Calfaf;

%DERIVADAS PARCIAIS DE Mz (psis,beta,delta)

%dMz/dpsip
Dr=-(a1^2/vx)*Calfaf-((a2-b1)^2/vx)*Calfai-((a2+b2)^2/vx)*Calfat;
%dMz/dbeta
Dbeta=(a2+b1)*Calfat+(a2-b1)*Calfai-a1*Calfaf;
%dMz/d_delta
Ddelta=a1*Calfaf;

%SISTEMA DE EDO DE 2do ordem transfromado em 1ro ORDEM
% %Calcula vy[m/s] e psip [º/s]
% matrizA=[Cbeta/(mv*vx)  Cr/mv-vx;Dbeta/(Izz*vx)   Dr/Izz]; %Matriz dinâmica
% matrizB=[Cdelta/mv;Ddelta/Izz]; %Matriz de control

% Calcula beta[rad] e psip [rad/s]
matrizA=[Cbeta/(mv*vx)  Cr/(mv*vx)-1;Dbeta/Izz   Dr/Izz]; %Matriz dinâmica
matrizB=[Cdelta/(mv*vx);Ddelta/Izz]; %Matriz de control
%%=========================================================================
%MANOBRA MUDANÇA DE PISTA ("Doble lane change")
X0=59; %Ponto de inicio da pobra en metros [m]
