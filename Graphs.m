fontname= 'Arial';
set(0,'defaultaxesfontname',fontname);
set(0,'defaulttextfontname',fontname);
fontsize= 22;
set(0,'defaultaxesfontsize',fontsize);
set(0,'defaulttextfontsize',fontsize);
% Sistema de Suspensão - Modelos Passivo e Semiativo
% Autor: Jefferson Gomes de Carvalho Souza
% GRAPHS Veículo Completo
%% 1º Modelo (Passivo)
% Rodar as Simulações
sim('TrafegabilidadeVerticalPassivo');
t = time;
% % Centro de Massa
tetaCM;
Zcg;
Vcm;
Acm;
% % Eixo 1
%Posição roda 1 (m)
Z1; 
% Posição do solo ponto 1 (m)
Z01;
% Posição do eixo 1 (m)
ZD1;
% Velocidade do eixo 1 (m/s)
VD1;
% Aceleração do eixo 1 (m/s²)
AD1;
% % Eixo 2
%Posição roda 2 (m)
Z2; 
% Posição do solo ponto 2 (m)
Z02;
% Posição do eixo 2 (m)
ZT22;
% % Eixo 3
%Posição roda 3 (m)
Z3; 
% Posição do solo ponto 3 (m)
Z03;
% Posição do eixo 3 (m)
ZT3;
% % Ancoragem Boggie
VT1;
% % Ancoragem Boggie
ZT01;

%% 2º Modelo (Ativo)
% Rodar as Simulações
sim('TrafegabilidadeVerticalAtivo');
t = time;
% % Centro de Massa
tetaCM1;
Zcg1;
% % Eixo 1
%Posição roda 1 (m)
Z11; 
% Posição do solo ponto 1 (m)
Z011;
% Posição do eixo 1 (m)
ZD11;
% % Eixo 2
%Posição roda 2 (m)
Z21; 
% Posição do solo ponto 2 (m)
Z021;
% Posição do eixo 2 (m)
ZT221;
% % Eixo 3
%Posição roda 3 (m)
Z31; 
% Posição do solo ponto 3 (m)
Z031;
% Posição do eixo 3 (m)
ZT31;
% % % Ancoragem Boggie (Velocidade)
VT2;
% % Ancoragem Boggie (Posição)
ZT02;

%% Figuras
figure(10),plot(t,tetaCM,'-',t,tetaCM1,'--r','LineWidth',1.5),hold;
title('Pitch - CM');
xlabel('Tempo [s]');
ylabel('Pitch [º] - CM');
legend ('Pitch - Susp. Passiva','Pitch - Susp. Semiativa')

figure(11),plot(t,Zcg,'-',t,Zcg1,'--r','LineWidth',1.5),hold;
title('Deslocamento - CM');
xlabel('Tempo [s]');
ylabel('Posição [m] eixo Z_{cm} - CM');
legend ('Suspensão Passiva','Suspensão Semiativa')

figure(12),plot(t,Z1,'--k',t,Z11,'k',t,Z01,'--y',t,Z011,'y',t,ZD1,'--r',t,ZD11,'r','LineWidth',1.5),hold;
title('Deslocamento - Eixo Dianteiro');
xlabel('Tempo [s]');
ylabel('Posição [m] - Eixo 1');
legend ('Posição Roda - Passiva','Posição Roda - Semiativa','Posição Solo - Passiva','Posição Solo - Semiativa','Posição Eixo - Passiva','Posição Eixo - Semiativa')

figure(13),plot(t,VD1,'-',t,VD11,'--r','LineWidth',1.5),hold;
title('Velocidade Vertical - Eixo Dianteiro');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] - Eixo 1 (Z)');
legend ('Suspensão Passiva','Suspensão Semiativa')

figure(14),plot(t,Vcm,'-',t,Vcm1,'--r','LineWidth',1.5),hold;
title('Velocidade - CM');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] - CM (Z)');
legend ('Suspensão Passiva','Suspensão Semiativa')

% figure(16),plot(t,ZT01,'-',t,ZT02,'--r','LineWidth',1.5),hold;
% title('Deslocamento - Ponto de Ancoragem (T) do Bogie');
% xlabel('Tempo [s]');
% ylabel('Deslocamento [m] Ponto T - Boggie (Z)');
% legend ('Suspensão Passiva','Suspensão Semiativa')

% figure(17),plot(t,AD1,'k',t,AD11,'--r','LineWidth',1.5),hold;
% title('Aceleração Vertical do Eixo 1');
% xlabel('Tempo [s]');
% ylabel('Velocidade Eixo 1 [Z]');
% legend ('Suspensão Passiva','Suspensão Semiativa')

% figure(18),plot(t,Acm,'k',t,Acm1,'--r','LineWidth',1.5),hold;
% title('Aceleração Vertical do Chassi');
% xlabel('Tempo [s]');
% ylabel('Velocidade CM [Z]');
% legend ('Suspensão Passiva','Suspensão Semiativa')

figure(15),plot(t,VT1,'-',t,VT2,'--r','LineWidth',1.5),hold;
title('Velocidade - Ponto de Ancoragem (T) do Bogie');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] Ponto T - Boggie (Z)');
legend ('Suspensão Passiva','Suspensão Semiativa')

figure(19),plot(t,Z01,'--k',t,Z02,'-.k',t,Z03,'-k',t,Z1,'--r',t,Z2,'-.r',t,Z3,'-r','LineWidth',1.5),hold;
title('Pista de Prova e Deslocamento das rodas');
xlabel('Tempo [s]');
ylabel('Posições dos Eixos 1, 2 e 3');
legend ('Posição Solo - Eixo 1','Posição Solo - Eixo 2','Posição Solo - Eixo 3','Posição Roda - Eixo 1','Posição Roda - Eixo 2','Posição Roda - Eixo 3')

figure(20),plot(t,W1,'-',t,W2,'--g',t,W3,'--b','LineWidth',1.5),hold;
title('Distribuição de Peso');
xlabel('Tempo [s]');
ylabel('Velocidade Ponto T - Boggie [Z]');
legend ('Eixo Dianteiro','Eixo Intermediário','Eixo Traseiro')

figure(21),plot(t,vX,'-r','LineWidth',1.5),hold;
title('Velocidade Longitudinal');
xlabel('Tempo [s]');
ylabel('V_x [m/s]');
legend ('V_x')