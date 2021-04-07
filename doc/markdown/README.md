# xlinprog

[linprog help page](/linprog.html) | [intlinprog help page](/intlinprog.html)

xlinprog is an Octave Package that introduces the optimization functions
linprog and intlinprog, with the same format as MATLAB, along with the 
option function optimoptions.

The functions convert the inputs of linprog, intlinprog and optimoptions
so that they are valid for the GLPK function in octave.

The main goal for xlinprog is to provide the same user experience as in 
MATLAB, while using GLPK for the calculations.

## Installation
Download the installation file xlinprog-0.1.0.tar.gz and place it on a temporary directory.
Run Octave and change the path to the temorary directory, or add it to the path.
Install the package from the Octave prompt with the command:

```octave
pkg install xlinprog-0.1.0.tar.gz
```

## Limitations
Since both functions use the GLPK format, there are some limitations for
their inputs.

**intlinprog:**
`x0` cannot be processed by GLPK, therefore it is ignored and a warning message appears.

**optimoptions:**
Some options are not available with this package. See each function's help page for the available options.

**exitflag and output:**
Some exitflags and outputs are not available with this package. See output.md for the available output.


## Usage

```octave
pkg load xlinprog

% Example usage of linprog-optimoptions
f=-[0.15
    0.17
    0.12];
A=[1 1 0
    -0.75 0.25 0
    1 1 1];
B=[20
   0
   80];
Aeq=[];
beq=[];
lb=[0,0,16];
ub=[inf,inf,inf];
options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
[x,fval,exitflag,output]=linprog(f,A,B,Aeq,beq,lb,ub,options);

% Example usage of intlinprog
f = [3 6 12 -6 -4 -8]';
A = [1 2 4 -2 0 0
     0 0 0 0 -1 -1
     1 2 4 -2 2 4
     ];
b = [4 0 6]';
Aeq=[];
beq=[];
lb = zeros(6,1)';
ub = lb+1';
intcon = 1:6;
x0=[];
options = optimoptions('intlinprog','LPMaxIterations',25);
[x,fval,exitflag,output]=intlinprog(f,intcon,A,b,Aeq,beq,lb,ub,x0,options);
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[GNU General Public License v3](https://www.gnu.org/licenses/gpl-3.0.html)
