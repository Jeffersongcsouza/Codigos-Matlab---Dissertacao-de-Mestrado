% Sistema de Suspensão - Função Fitness e Restrições - Modelo GA-LQR
% Autor: Jefferson Gomes de Carvalho Souza
function J2 = custo_gen(A,B,C,D,X,indiv,dt,u1,Q1,R1,f3,Fobj,a,a3,m1,m2,c1,c2,k1,k2,y,E,s,f1,a1,f2,a2)
%% Sistema dinâmico
m1 = 490; m2 = 4500; c1 = 2660; c2 = 20000; k1 = 770700; k2 = 59600;
% Sistema de Controle
Q1=diag(indiv(1:4));
R1=diag(indiv(5:5));
K2=lqr(A,B,Q1,R1);
A_cl2=A-B*K2;
system5=ss(A_cl2,B,C,D);
% Condição Inicial (Degrau unitário)
t = 0:0.02:4;
x0=[1;0;0;0];
[Y,T,X] = initial(system5,x0,t);
u1 = -K2*X';
dt = t(5)-t(1);
%% Restrições
% Deflexão máxima do Pneu (Z1 - Zr = 0.0508)
% Aceleração da Suspensão (Z1' - Zr' = 4,5)
% Aceleração máxima massa suspensa (Z2'')~(X2') // RMS < 0.315 m/s²
f1 = (-(c2/m2)*X(4) -(k2/m2)*X(3) -0.315).^2;
% % Batente da Suspensão (Z2 - Z1)~(X3)
f2 = (X(3) - 0.127).^2;
% Estabilidade, Tempo de Acomodação e Overshoot
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
% Função Objetivo
Fobj = (trace(X'*X*Q1))+(trace(u1*u1'*R1))*dt;
% Constantes de Penalidades
a1=1; a2=100;
a3=10; a=1;
% Função Fitness
J2 = Fobj + a3*f3 + a*E + a1*f1 + a2*f2;
end