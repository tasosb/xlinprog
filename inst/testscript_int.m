clear all;clc;close all;
%Tests for the intlinprog script

%Load xlinprog
pkg load xlinprog

f=[3 -4]';
A=[1 2];
b=[6];
lb=[-2 1]';
ub=[4 3]';
intcon=[1 2];
[x,fval]=intlinprog(f,intcon,A,b,[],[],lb,ub)
disp('------------------------')
f = [3 6 12 -6 -4 -8]';
A = [1 2 4 -2 0 0
     0 0 0 0 -1 -1
     1 2 4 -2 2 4
     ];
b = [4 0 6]';
lb = zeros(6,1)';
ub = lb+1';
intcon = 1:6;
[x,fval] = intlinprog(f,intcon,A,b,[],[],lb,ub)
disp('------------------------')
f = -[0.1*1 0.07*1.5 0.1*0.7 0.07*2 0.07*1.2]';
A = [1 1.5 0.7 2 1.2
     1 1 1 1 1];
b = [4 3]';
lb = zeros(5,1)';
ub = lb+1';
intcon = 1:5;
[x,fval] = intlinprog(f, intcon, A, b, [], [], lb, ub)
disp('------------------------')
f= [14 5 8 7 2 12 6 5 7 8 3 9 2 4 6 10]';
Aeq = [1 1 1 1  0 0 0 0  0 0 0 0  0 0 0 0
       0 0 0 0  1 1 1 1  0 0 0 0  0 0 0 0
       0 0 0 0  0 0 0 0  1 1 1 1  0 0 0 0
       0 0 0 0  0 0 0 0  0 0 0 0  1 1 1 1
       1 0 0 0  1 0 0 0  1 0 0 0  1 0 0 0
       0 1 0 0  0 1 0 0  0 1 0 0  0 1 0 0
       0 0 1 0  0 0 1 0  0 0 1 0  0 0 1 0
       0 0 0 1  0 0 0 1  0 0 0 1  0 0 0 1];
beq = [1 1 1 1 1 1 1 1]';
lb = zeros(16,1);
ub=lb+1;
intcon= 1:16;
[x,fval] = intlinprog(f,intcon,[],[],Aeq,beq,lb,ub)
disp('------------------------')
f=-[30 50 40 55 50 35 45 50 55 45]';
A=[1 0 0 0 0 1 0 0 0 0
   0 1 0 0 0 0 1 0 0 0
   0 0 1 0 0 0 0 1 0 0
   0 0 0 1 0 0 0 0 1 0
   0 0 0 0 1 0 0 0 0 1 
   0.4 0.35 0.4 0.5 0.35 0 0 0 0 0
   0 0 0 0 0 0.4 0.4 0.45 0.45 0.4];
b=[1 1 1 1 1 1.0 1.2];
lb=zeros(10,1);
ub=ones(10,1);
intcon=1:10;
[x,fval]=intlinprog(f,intcon,A,b,[],[],lb,ub)
disp('------------------------')
f=-[10 18 11 9 10 25 35 28 20 40]';
A=[1 0 0 0 0 -5 0 0 0 0
   0 1 0 0 0 0 -4 0 0 0
   0 0 1 0 0 0 0 -5 0 0
   0 0 0 1 0 0 0 0 -7 0
   0 0 0 0 1 0 0 0 0 -3
   0 0 0 0 0 0 1 0 0 1
   0 0 0 0 0 1 -1 -1 0 0 
   0 0 0 0 0 0 0 -1 -1 -1];
b=[0 0 0 0 0 1 0 -2]';
lb=zeros(10,1);
ub=[ones(5,1)*inf;ones(5,1)];
intcon=ones(10,1);
[x,fval]=intlinprog(f,intcon, A,b,[],[],lb,ub)
disp('------------------------')
%Tests for the options function
options = optimoptions('intlinprog','LPMaxIterations',25)
options.Display='falsevalue' %must throw error
options.Display='off'
options = optimoptions('intlinprog','LPPreprocess','basic','Display','iter')
f=[1 1 1]';
A=[-pi.*1.4.^2./4 -pi.*1.6.^2./4 -pi.*2.^2./4
   pi.*1.4.^2./4 pi.*1.6.^2./4 pi.*2.^2./4
   -1 -1 -1];
b=[-15 20 -8];
lb=[0 0 4]';
ub=ones(1,3)*inf;
intcon=1:3;
[x,fval,exitflag,output]=intlinprog(f,intcon,A,b,[],[],lb,ub,[],options)
disp('------------------------')