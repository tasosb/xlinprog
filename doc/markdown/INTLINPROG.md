# xlinprog
[Home](/readme.html) | [linprog help page](/linprog.html)

## intlinprog function

**Mixed-integer Linear Programming (MILP) solver**
intlinprog can solve Mixed-integer Linear Programming minimization problems with the GLPK function.

Therefore, it can solve
`min f'*x`
subject to the constraints
```
x(intcon) are integers
A*x<=b
Aeq*x=beq
lb<=x<=ub
```

## Syntax
```octave
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b)
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq)
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub)
[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,x0,options)
```

## Input arguments
`f`: A column array containing the objective function coefficients.

`intcon`: Vector of integer constraints. For example `intcon=[1]` means `x(1)` can only take integer values.

`A`: A matrix containing the inequality constraints.

`b`: A column array containing the right-hand side value for each inequality constraint in the A matrix.

`Aeq`: A matrix containing the equality constraints.

`beq`: A column array containing the right-hand side value for each equality constraint in the Aeq matrix.

`lb`: An array containing the lower bound on each of the variables. If lb is not supplied, the default lower bound for the variables is zero. 

`ub`: An array containing the upper bound on each of the variables. If ub is not supplied, the default upper bound is assumed to be infinite. 

`x0`: This argument is not supported due to GLPK errors. It is added for compatibility purposes, and a warning notifies the user that it is not used.

`options`: Optimization options, generated as the output of `optimoptions`.
The available options are listed below:
Option Name | Option Description
------------ | -------------
Display | <ul><li>'final' (default) displays just the final output.</li><li>'off' or 'none' displays no output.</li><li>'iter' displays output at each iteration.</li></ul>
LPMaxIterations | Simplex iterations limit. It is decreased by one each time when one simplex iteration has been performed, and reaching zero value signals the solver to stop the search. 
MaxTime | Searching time limit, in milliseconds. 
LPPreprocess | If 'basic', the simplex solver uses the built-in LP presolver. If 'none', the LP presolver is not used. 

## Output arguments
`x`: The optimizer (the value of the decision variables at the optimum).

`fval`: The optimum value of the objective function.

`exitflag`: Reason `intlinprog` stopped, returned as an integer.
The available exitflags are listed below:
Error Code | Error Description
------------ | -------------
1 | intlinprog converged to the solution x.
-2 | No feasible point found.
-3 | Root LP problem is unbounded.
-9 | Solver lost feasibility.
-99 | Other error - see extra

`output`: Information about the optimization process, returned as a structure with the following fields:
Output Name | Output Description
------------ | -------------
message | Exit message
error_message | GLPK exitflag message


