function [x,fval,exitflag,output]=linprog(f,A,b,Aeq,beq,lb,ub,options)
% linprog: Linear Programing - Converts matlab linprog function to octave GLPK

%Set default values if omitted
if nargin < 8
        options = [];
        if nargin < 7
                ub = [];
                if nargin < 6
                    lb = [];
                    if nargin < 5
                        beq = [];
                        if nargin < 4
                            Aeq = [];
                        end
                    end
                end
            end
          end
if nargin <3
   error(xlindata('error.main'))
endif

%Check f,b,lb,ub for their format
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

%Checks if given data are valid
if size(A,1)~=size(b,1)
  error(xlindata('error.AB'))
endif
if length(A)>0 && size(A,2)~=size(f,1)
  error(xlindata('error.AF'))
endif
if length(ub)>0 && size(ub,1)~=size(f,1)
  diff=size(f,1)-size(ub,1);
  if diff<0
    ub=ub(1:size(f,1));
    warning(xlindata('warning.UBignore'))
  else
    ub=[ub;ones(diff,1)*inf];
    warning(xlindata('warning.UBfill'))
  endif
endif
if length(lb)>0 && size(lb,1)~=size(f,1)
  diff=size(f,1)-size(lb,1);
  if diff<0
    lb=lb(1:size(f,1));
    warning(xlindata('warning.LBignore'))
  else
    lb=[lb;ones(diff,1)*-inf];
    warning(xlindata('warning.LBfill'))
  endif
endif
if length(Aeq)>0 && size(Aeq,1)~=size(beq,1)
  error(xlindata('error.AeqBeq'))
endif
if length(Aeq)>0 && size(Aeq,2)~=size(f,1)
  error(xlindata('error.Aeqf'))
endif
s = struct();
if ~isempty(options)
  if isa(options,"LinprogC")
    s = options.matlab2glpk();
  else
    error(xlindata('error.options'))
  endif
endif

ctype=strcat(repmat("U",1,size(A,1)),repmat("S",1,size(Aeq,1)));
vartype=repmat("C",1,size(A,2));
A=[A;Aeq];
b=[b;beq];

[x,fval,status,extra] = ...
   glpk (f, A, b, lb, ub, ctype, vartype,1,s);
   
[exitflag,output]=convertres(status,extra);
end
