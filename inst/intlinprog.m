function [x,fval,exitflag,output]=intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,x0,options)
% intlinprog: Mixed Integer-Linear Programing - Converts matlab intlinprog function to octave GLPK

%Set default values if omitted
if nargin < 10
   options = [];
   if nargin <9
     x0=[];
        if nargin < 8
                ub = [];
                if nargin < 7
                    lb = [];
                    if nargin < 6
                        beq = [];
                        if nargin < 5
                            Aeq = [];
                        end
                    end
                end
          end
     end
end
if nargin <4
   error(xlindata('error.main'))
end

%Check f,b,lb,ub,intcon for their format
%If they are formatted with one row-multiple columns
%Convert to multiple rows-one column (transpose)
if size(f,1)==1
  f=f';
end
if size(b,1)==1
  b=b';
end
if size(lb,1)==1
  lb=lb';
end
if size(ub,1)==1
  ub=ub';
end
if size(intcon,2)==1
  intcon=intcon';
end

%Checks if given xlindata are valid
if size(A,1)~=size(b,1)
  error(xlindata('error.AB'))
end
if length(A)>0 && size(A,2)~=size(f,1)
  error(xlindata('error.AF'))
end
if length(ub)>0 && size(ub,1)~=size(f,1)
  diff=size(f,1)-size(ub,1);
  if diff<0
    ub=ub(1:size(f,1));
    warning(xlindata('warning.UBignore'))
  else
    ub=[ub;ones(diff,1)*inf];
    warning(xlindata('warning.UBfill'))
  end
end
if length(lb)>0 && size(lb,1)~=size(f,1)
  diff=size(f,1)-size(lb,1);
  if diff<0
    lb=lb(1:size(f,1));
    warning(xlindata('warning.LBignore'))
  else
    lb=[lb;ones(diff,1)*-inf];
    warning(xlindata('warning.LBfill'))
  end
end
if length(Aeq)>0 && size(Aeq,1)~=size(beq,1)
  error(xlindata('error.AeqBeq'))
end
if length(Aeq)>0 && size(Aeq,2)~=size(f,1)
  error(xlindata('error.Aeqf'))
end
if any((intcon - length(f))>0)
  error(strcat(xlindata('error.intcon'),'[',num2str([1:length(f)]),']'))
end
if ~isempty(x0)
  warning(xlindata('warning.x0'))
end
s = struct();
if ~isempty(options)
  if isa(options,"IntlinprogC")
    s = options.matlab2glpk();
  else
    error(xlindata('error.options'))
  end
end
ctype=strcat(repmat("U",1,size(A,1)),repmat("S",1,size(Aeq,1)));
vartype=repmat("C",1,size(A,2));
vartype(intcon)='I';
A=[A;Aeq];
b=[b;beq];

[x,fval,status,extra] = ...
   glpk (f, A, b, lb, ub, ctype, vartype,1,s);
   
[exitflag,output]=convertres(status,extra);
end
