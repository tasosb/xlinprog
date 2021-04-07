clear all;clc;close all;
%Tests for the linprog script

%Load xlinprog
pkg load xlinprog

f=[2 4 2 1.5 5 3]';
A=[-1 -1 -1 -1 -1 -1 %oloi oi metaferomenoi=(x1+x2+x3+x4+x5+x6)
   -0.7 0.3 0.3 -0.7 0.3 0.3
   -0.4 -0.4 0.6 -0.4 -0.4 0.6
   0 0 -1 0 0 -1
   0 -1 0 0 -1 0
   -0.4 -0.4 -0.4 0.6 0.6 0.6
   -0.45 -0.45 -0.45 0.55 0.55 0.55];
b=[-4000 0 0 -700 -1000 0 0];
lb=zeros(6,1);
ub=ones(6,1)*inf;
[x,fval]=linprog(f,A,b,[],[],lb,ub)
disp('-----------------------')
f=-[700 600]';
A=[1 1
   700 500];
b=[3200 2000000];
lb=[900 1300]';
ub=[inf]; %in purpose missing one inf
[x,fval]=linprog(f,A,b,[],[],lb,ub)
disp('------------------------')
f=-[0.15;0.17;0.12];
A=[1 1 0
    -0.75 0.25 0
    1 1 1];
B=[20;0;80];
Aeq=[];
beq=[];
lb=[0,0,16];
ub=[inf,inf,inf];
[x,fval,exitflag,output]=linprog(f,A,B,Aeq,beq,lb,ub)
disp('------------------------')
%from matlab website
A = [1 1
    1 1/4
    1 -1
    -1/4 -1
    -1 -1
    -1 1];
b = [2 1 2 1 -1 2];
f = [-1 -1/3];
x = linprog(f,A,b)
disp('------------------------')
Aeq = [1 1/4];
beq = 1/2;
[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq)
disp('------------------------')
lb = [-1,-0.5];
ub = [1.5,1.25];
x = linprog(f,A,b,Aeq,beq,lb,ub)
disp('------------------------')
disp('------------------------')
%Tests for the options function
options = optimoptions('linprog','Algorithm','dual-simplex')
options.Display='falsevalue' %must throw error
options.Display='off'
options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter')
%from matlab website
A = [1 1
    1 1/4
    1 -1
    -1/4 -1
    -1 -1
    -1 1];
b = [2 1 2 1 -1 2];
f = [-1 -1/3];
Aeq = [1 1/4];
beq = 1/2;
lb = [-1,-0.5];
ub = [1.5,1.25];
[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq,lb,ub,options)
