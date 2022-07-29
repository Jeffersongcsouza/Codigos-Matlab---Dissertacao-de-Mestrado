% Sistema de Suspensão - Modelos Passivo e Semiativo
% Autor: Jefferson Gomes de Carvalho Souza
clc, clear all
syms k1 k2 c1 c2 m1 m2 t s;
I = eye(4);

m11 = 490; %m1
m22 = 5350; %m2
kp11 = 870000; %k1
ks11 = 55000; %k2
bs11 = 24500; %c2
bp11 = 2660; %c1

%% Espaço Estado
A_cl3 = [0 1 0 0;
-[(bs11/m22)*(bp11/m11)] 0 [(bs11/m22)*(bs11/m22 + bs11/m11 + bp11/m11)-(ks11/m22)] -bs11/m22;
bp11/m11 0 -(bs11/m22 + bs11/m11 + bp11/m11) 1;
kp11/m11 0 -(ks11/m22 + ks11/m11 + kp11/m11) 0];

%B = [0; 1/m2; 0; [(1/m1)+(1/m2)]];
B = [0; [(bs11/m22)*(bp11/m11)]; -bp11/m11; -kp11/m11];
C = [1 0 0 0];
C1 = [0 1 0 0];
D = [0];

system10=ss(A_cl3,B,C,D);
sys10=tf(system10)
[z,p,k] = ss2zp (A_cl3, B, C, D)
A_cl3