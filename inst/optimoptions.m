function opt = optimoptions(solver, varargin)
% optimoptions: Object for optimization options (matlab equiv.)
if nargin==0
  error(xlindata('options.error.main'));
end
if isa(solver,'function_handle')
  solver=func2str(solver);
end
if isstring(solver)
  solver=char(solver);
end
if ~any(strcmpi(solver, {'linprog', 'intlinprog'}))
    error(xlindata('options.error.invalid'))
end
switch lower(solver)
  case 'linprog'
    obj = LinprogC();
    opt = obj.setdatas(varargin);
  case 'intlinprog'
    obj = IntlinprogC();
    opt = obj.setdatas(varargin);
end
endfunction
