% Sistema de Suspens�o - Modelo GA-LQR
% Autor: Jefferson Gomes de Carvalho Souza
%% Algoritmo Gen�tico (Par�metros da Planta)
clc, clear all
syms k1 k2 c1 c2 m1 m2 t s;
I = eye(4);
m1 = 490; m2 = 4500; c1 = 2660; c2 = 20000; k1 = 770700; k2 = 59600;

%% Espa�o Estado
A = [0 1 0 0;
-[(c2/m2)*(c1/m1)] 0 [(c2/m2)*(c2/m2 + c2/m1 + c1/m1)-(k2/m2)] -c2/m2;
c1/m1 0 -(c2/m2 + c2/m1 + c1/m1) 1;
k1/m1 0 -(k2/m2 + k2/m1 + k1/m1)  0];
B = [0; [(c2/m2)*(c1/m1)]; -c1/m1; -k1/m1];
C = [1 0 0 0];
C1 = [0 1 0 0];
D = [0];

%% Estrutura��o Controlador LQR e Par�metros da Fun��o Custo
indiv(:,1)=[2;1;0;0;100;];
Q1=diag(indiv(1:4));
R1=diag(indiv(5));
K2=lqr(A,B,Q1,R1);
A_cl2=A-B*K2;
% Sistema Din�mico LQR no Espa�o Estado
system5=ss(A_cl2,B,C,D);
t = 0:0.02:4;
% Condi��o Inicial // degrau unit�rio
x0 =[1; 0; 0; 0];
[Y,T,X] = initial(system5,x0,t);
% C�lculo da For�a de Controle e da Fun��o Custo (custo_gen) // J1=(trace(X'*X*Q))+(trace(u1*u1'*R))*dt;
u1 = -K2*X';
dt = t(5)-t(1);
%% Restri��es
% Deflex�o m�xima do Pneu (Z1 - Zr = 0.0508)
% Acelera��o da Suspens�o (Z1' - Zr' = 4,5)
% Acelera��o m�xima massa suspensa (Z2'')~(X2') // RMS < 0.315 m/s�
f1 = (-(c2/m2)*X(4) -(k2/m2)*X(3) -0.315).^2;
% % Batente da Suspens�o (Z2 - Z1)~(X3)
f2 = (X(3) - 0.127).^2;
% Estabilidade, Tempo de Acomoda��o e Overshoot
h = eig(A_cl2);
p_desired = [-23.233+31.34*i;
      -23.233-31.34*i;
      -2.66+2.938*i;
      -2.66-2.938*i;];
s=h - p_desired;
f3 = trace(s'*s);
% Erro de regime permanente
y=impulse(ss(A_cl2,B,C,D));
E=sum(sum(sum(y.^2)));
% Fun��o Objetivo
Fobj = (trace(X'*X*Q1))+(trace(u1*u1'*R1))*dt;
% Constantes de Penalidades
a1=1; a2=100;
a3=10; a=1;
% Fun��o Fitness
J2 = Fobj + a3*f3 + a*E + a1*f1 + a2*f2;
%% AG - Par�metros de Entrada
% n� estados (n), entradas (p) e sa�das (q)
n=4; p=1; q=2;
% n� indiv�duos - nind (Cromossomos) // n� Genes (ng)
nind=200; ng=5;
% N� de Gera��es/Recombina��es
NR=30;
% Popula��o Inicial
pini=randi(100,ng,nind);
% Estabelecendo n� de Recombina��es e crit�rio de parada
Jt=zeros(1,NR); nr=1; J2=zeros(nind,1);

while nr<NR
%% Avalia��o do �ndice de desempenho de cada indiv�duo
for k=1:nind,
    indiv=pini(:,k);
   J2(k)=custo_gen(A,B,C,D,X,indiv,dt,u1,Q1,R1,f3,Fobj,a,a3,m1,m2,c1,c2,k1,k2,y,E,s,f1,a1,f2,a2);
   % J2(k)=custo_gen(A,B,C,D,X,indiv,dt,u1,Q1,R1); %f1,f2,f3,f4,Fobj,alpha
% %% Manuten��o de Jt (min) entre as itera��es
%    [~,ind]=min(J2);
% if Jt(nr)>=J2(ind);
%     Jt(nr)==J2(ind);
% else 
%     Jt(nr)==J2(ind);
% end
end
% Encontrar indiv�duo pelo menor de para J2
[~,ind]=sort(J2);
Jt(nr)=J2(ind(1));
figure(1),plot(Jt),hold;
pini=pini(:,ind);
% xticks(2:3:79);
% Associar o indiv�duo da popula��o com menor J2 ao LQR 
Q1=diag(pini(1:4,1));
R1=diag(pini(5:5,1));
K2=lqr(A,B,Q1,R1);
% Retornar Valores Otimizados
E=sum(sum(sum(y.^2)));
f1 = (-(c2/m2)*X(4) -(k2/m2)*X(3) -0.315).^2;
f2 = (X(3) - 0.127).^2;
f3 = trace(s'*s);
A_cl2=A-B*K2;
h = eig(A_cl2);
Fobj = (trace(X'*X*Q1))+(trace(u1*u1'*R1))*dt;
%% Gera��o da nova popula��o (Sele��o da Elite)
npini=zeros(ng,nind);
% Elite
%n� indiv�duos Elite
nie=40; npini(:,1:nie)=pini(:,1:nie);

%% Muta��o
% N� Indiv�duos Mutados
nim=60;
% Muta��o de 1 cromossomo para cada indiv�duo da Elite
cm=randi(5,1,nim);
for km=1:nim
    ie=pini(:,km);
    ie(cm(km))=rand;
    npini(:,nie+km)=ie;
end
%% Recombina��o Aleat�ria (Operadores Gen�ticos)
for nrec=1:100,
ic=randi(200,1,2);
npini(:,nie+km+nrec)=[pini(1:2,ic(1)); pini(3:5,ic(2))];
end
pini=npini;
nr=nr+1;
end
Q1, R1, Fobj, A_cl2, eig(A_cl2)