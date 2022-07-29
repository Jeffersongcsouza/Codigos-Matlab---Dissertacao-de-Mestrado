fontname= 'Arial';
set(0,'defaultaxesfontname',fontname);
set(0,'defaulttextfontname',fontname);
fontsize= 22;
set(0,'defaultaxesfontsize',fontsize);
set(0,'defaulttextfontsize',fontsize);
% Sistema de Suspens�o - Modelos Passivo e Semiativo
% Autor: Jefferson Gomes de Carvalho Souza
% GRAPHS Ve�culo Completo
%% 1� Modelo (Passivo)
% Rodar as Simula��es
sim('TrafegabilidadeVerticalPassivo');
t = time;
% % Centro de Massa
tetaCM;
Zcg;
Vcm;
Acm;
% % Eixo 1
%Posi��o roda 1 (m)
Z1; 
% Posi��o do solo ponto 1 (m)
Z01;
% Posi��o do eixo 1 (m)
ZD1;
% Velocidade do eixo 1 (m/s)
VD1;
% Acelera��o do eixo 1 (m/s�)
AD1;
% % Eixo 2
%Posi��o roda 2 (m)
Z2; 
% Posi��o do solo ponto 2 (m)
Z02;
% Posi��o do eixo 2 (m)
ZT22;
% % Eixo 3
%Posi��o roda 3 (m)
Z3; 
% Posi��o do solo ponto 3 (m)
Z03;
% Posi��o do eixo 3 (m)
ZT3;
% % Ancoragem Boggie
VT1;
% % Ancoragem Boggie
ZT01;

%% 2� Modelo (Ativo)
% Rodar as Simula��es
sim('TrafegabilidadeVerticalAtivo');
t = time;
% % Centro de Massa
tetaCM1;
Zcg1;
% % Eixo 1
%Posi��o roda 1 (m)
Z11; 
% Posi��o do solo ponto 1 (m)
Z011;
% Posi��o do eixo 1 (m)
ZD11;
% % Eixo 2
%Posi��o roda 2 (m)
Z21; 
% Posi��o do solo ponto 2 (m)
Z021;
% Posi��o do eixo 2 (m)
ZT221;
% % Eixo 3
%Posi��o roda 3 (m)
Z31; 
% Posi��o do solo ponto 3 (m)
Z031;
% Posi��o do eixo 3 (m)
ZT31;
% % % Ancoragem Boggie (Velocidade)
VT2;
% % Ancoragem Boggie (Posi��o)
ZT02;

%% Figuras
figure(10),plot(t,tetaCM,'-',t,tetaCM1,'--r','LineWidth',1.5),hold;
title('Pitch - CM');
xlabel('Tempo [s]');
ylabel('Pitch [�] - CM');
legend ('Pitch - Susp. Passiva','Pitch - Susp. Semiativa')

figure(11),plot(t,Zcg,'-',t,Zcg1,'--r','LineWidth',1.5),hold;
title('Deslocamento - CM');
xlabel('Tempo [s]');
ylabel('Posi��o [m] eixo Z_{cm} - CM');
legend ('Suspens�o Passiva','Suspens�o Semiativa')

figure(12),plot(t,Z1,'--k',t,Z11,'k',t,Z01,'--y',t,Z011,'y',t,ZD1,'--r',t,ZD11,'r','LineWidth',1.5),hold;
title('Deslocamento - Eixo Dianteiro');
xlabel('Tempo [s]');
ylabel('Posi��o [m] - Eixo 1');
legend ('Posi��o Roda - Passiva','Posi��o Roda - Semiativa','Posi��o Solo - Passiva','Posi��o Solo - Semiativa','Posi��o Eixo - Passiva','Posi��o Eixo - Semiativa')

figure(13),plot(t,VD1,'-',t,VD11,'--r','LineWidth',1.5),hold;
title('Velocidade Vertical - Eixo Dianteiro');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] - Eixo 1 (Z)');
legend ('Suspens�o Passiva','Suspens�o Semiativa')

figure(14),plot(t,Vcm,'-',t,Vcm1,'--r','LineWidth',1.5),hold;
title('Velocidade - CM');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] - CM (Z)');
legend ('Suspens�o Passiva','Suspens�o Semiativa')

% figure(16),plot(t,ZT01,'-',t,ZT02,'--r','LineWidth',1.5),hold;
% title('Deslocamento - Ponto de Ancoragem (T) do Bogie');
% xlabel('Tempo [s]');
% ylabel('Deslocamento [m] Ponto T - Boggie (Z)');
% legend ('Suspens�o Passiva','Suspens�o Semiativa')

% figure(17),plot(t,AD1,'k',t,AD11,'--r','LineWidth',1.5),hold;
% title('Acelera��o Vertical do Eixo 1');
% xlabel('Tempo [s]');
% ylabel('Velocidade Eixo 1 [Z]');
% legend ('Suspens�o Passiva','Suspens�o Semiativa')

% figure(18),plot(t,Acm,'k',t,Acm1,'--r','LineWidth',1.5),hold;
% title('Acelera��o Vertical do Chassi');
% xlabel('Tempo [s]');
% ylabel('Velocidade CM [Z]');
% legend ('Suspens�o Passiva','Suspens�o Semiativa')

figure(15),plot(t,VT1,'-',t,VT2,'--r','LineWidth',1.5),hold;
title('Velocidade - Ponto de Ancoragem (T) do Bogie');
xlabel('Tempo [s]');
ylabel('Velocidade [m/s] Ponto T - Boggie (Z)');
legend ('Suspens�o Passiva','Suspens�o Semiativa')

figure(19),plot(t,Z01,'--k',t,Z02,'-.k',t,Z03,'-k',t,Z1,'--r',t,Z2,'-.r',t,Z3,'-r','LineWidth',1.5),hold;
title('Pista de Prova e Deslocamento das rodas');
xlabel('Tempo [s]');
ylabel('Posi��es dos Eixos 1, 2 e 3');
legend ('Posi��o Solo - Eixo 1','Posi��o Solo - Eixo 2','Posi��o Solo - Eixo 3','Posi��o Roda - Eixo 1','Posi��o Roda - Eixo 2','Posi��o Roda - Eixo 3')

figure(20),plot(t,W1,'-',t,W2,'--g',t,W3,'--b','LineWidth',1.5),hold;
title('Distribui��o de Peso');
xlabel('Tempo [s]');
ylabel('Velocidade Ponto T - Boggie [Z]');
legend ('Eixo Dianteiro','Eixo Intermedi�rio','Eixo Traseiro')

figure(21),plot(t,vX,'-r','LineWidth',1.5),hold;
title('Velocidade Longitudinal');
xlabel('Tempo [s]');
ylabel('V_x [m/s]');
legend ('V_x')