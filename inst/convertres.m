function [exitflag,output]=convertres(exit,extra)
% Converts error codes
  err_equiv={1,
             -99,
             -99,
             -99,
             -3,
             -9,
             -99,
             -99,
             0,
             0,
             -2,
             -2,
             -99,
             -7,
             -99,
             -5,
             -99,
             -99,
             -4,
             -99};
             
  err_msg={'No error.',
           'Invalid basis.',
           'Singular matrix.',
           'Ill-conditioned matrix.',
           'Invalid bounds.',
           'Solver failed.',
           'Objective function lower limit reached.',
           'Objective function upper limit reached.',
           'Iterations limit exhausted.',
           'Time limit exhausted.',
           'No primal feasible solution.',
           'No dual feasible solution.',
           'Root LP optimum not provided.',
           'Search terminated by application.',
           'Relative MIP gap tolerance reached.',
           'No primal/dual feasible solution.',
           'No convergence.',
           'Numerical instability.',
           'Invalid data.',
           'Result out of range.'};
           
 st_msg={'Solution status is undefined.',
         'Solution is feasible.',
         'Solution is infeasible.',
         'Problem has no feasible solution.',
         'Solution is optimal.',
         'Problem has no unbounded solution.'};

 exitflag=err_equiv{exit+1};
 output=struct();
 output.message=st_msg{extra.status};
 output.error_message=err_msg{exit+1};
 
   
