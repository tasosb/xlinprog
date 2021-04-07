# xlinprog
[Home](/README.md) | [intlinprog help page](INTLINPROG.md)

## linprog function

**Linear Programming Solver**
linprog can solve Linear Programming minimization problems with the GLPK function.

Therefore, it can solve
`min f'*x`
subject to the constraints
```octave
A*x<=b
Aeq*x=beq
lb<=x<=ub
```

## Syntax
```octave
[x,fval,exitflag,output] = linprog(f,A,b)
[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq)
[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq,lb,ub)
[x,fval,exitflag,output] = linprog(f,A,b,Aeq,beq,lb,ub,options)
```

## Input arguments
`f`: A column array containing the objective function coefficients.

`A`: A matrix containing the inequality constraints.

`b`: A column array containing the right-hand side value for each inequality constraint in the A matrix.

`Aeq`: A matrix containing the equality constraints.

`beq`: A column array containing the right-hand side value for each equality constraint in the Aeq matrix.

`lb`: An array containing the lower bound on each of the variables. If lb is not supplied, the default lower bound for the variables is zero. 

`ub`: An array containing the upper bound on each of the variables. If ub is not supplied, the default upper bound is assumed to be infinite. 

`options`: Optimization options, generated as the output of `optimoptions`.
The available options are listed below:
Option Name | Option Description
------------ | -------------
Algorithm | <ul><li>'dual-simplex' (default)</li><li>'interior-point-legacy'</li><li>'interior-point'</li></ul>  
Display | <ul><li>'final' (default) displays just the final output.</li><li>'off' or 'none' displays no output.</li><li>'iter' displays output at each iteration.</li></ul>
MaxIterations | Simplex iterations limit. It is decreased by one each time when one simplex iteration has been performed, and reaching zero value signals the solver to stop the search. 
MaxTime | Searching time limit, in milliseconds. 
Preprocess | If 'basic', the simplex solver uses the built-in LP presolver. If 'none', the LP presolver is not used. 

## Output arguments
`x`: The optimizer (the value of the decision variables at the optimum).

`fval`: The optimum value of the objective function.

`exitflag`: Reason `linprog` stopped, returned as an integer.
The available exitflags are listed below:
Error Code | Error Description
------------ | -------------
1 | Function converged to a solution x.
0 | Number of iterations exceeded `options.MaxIterations` or solution time in seconds exceeded `options.MaxTime`.
-2 | No feasible point was found.
-3 | Problem is unbounded.
-4 | NaN value was encountered during execution of the algorithm.
-5 | Both primal and dual problems are infeasible.
-7 | Search direction became too small. No further progress could be made.
-9 | Solver lost feasibility.
-99 | Other error - see extra

`output`: Information about the optimization process, returned as a structure with the following fields:
Output Name | Output Description
------------ | -------------
message | Exit message
error_message | GLPK exitflag message


