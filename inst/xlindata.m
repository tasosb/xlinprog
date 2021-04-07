function out=xlindata(input)
% Data for xlinprog package
  a=strsplit(input,'.');
  switch(a{1})
    case 'error'
      switch(a{2})
        case 'main'
          out="LINPROG requires at least three input arguments.";
        case 'AB'
          out="The number of rows in A must be the same as the number of elements of b.";
        case 'AF'
          out="The number of columns in A must be the same as the number of elements of f.";
        case 'AeqBeq'
          out="The number of rows in Aeq must be the same as the number of elements of Beq.";
        case 'Aeqf'
          out="The number of columns in Aeq must be the same as the number of elements of f.";
        case 'intcon'
          out="Each element of INTCON must be an integer in the range [1 numVars]=";
        case 'options'
          out="The options parameter has to be defined by OPTIMOPTIONS.";
      end
    case 'warning' 
      switch(a{2})
        case  'UBignore'
          out="Length of upper bounds is > length(f); ignoring extra bounds";
        case 'UBfill'
          out="Length of upper bounds is < length(x); filling in missing upper bounds with +Inf.";
        case 'LBignore'
          out="Length of lower bounds is > length(f); ignoring extra bounds";
        case 'LBfill'
          out="Length of lower bounds is < length(x); filling in missing lower bounds with -Inf.";
        case 'x0'
          out="The option x0 is not available in GLPK.";
       end
    case 'options'
      switch(a{2})
        case 'error'
          switch(a{3})
            case 'main'
              out="OPTIMOPTIONS requires at least one input.";
            case 'invalid'
              out="Invalid solver specified. Please provide a solver name or handle (such as 'linprog' or @linprog).";
           end 
        case 'algorithm'
          out={'dual-simplex','interior-point','interior-point-legacy'};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter Algorithm: must be `dual-simplex`,  `interior-point-legacy`,  or `interior-point`';
          endif
        case 'preprocess'
          out={'basic','none'};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter Preprocess: must be `basic`,  or `none`';
          endif 
        case 'lppreprocess'
          out={'basic','none'};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter LPPreprocess: must be `basic`,  or `none`';
          endif       
        case 'display'
          out={'final','off','iter'};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter Display: must be `final`, `off`,  or `iter`';
          endif
        case 'maxtime'
          out={};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter MaxTime: must a non-empty scalar double in the range 0 to Inf.';
        endif
        case 'maxiterations'
          out={};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter MaxIterations: must be a real non-negative integer.';
        endif
        case 'lpmaxiterations'
          out={};
          if length(a)>2 && a{3}=='error'
            out='Invalid value for OPTIONS parameter LPMaxIterations: must be a real non-negative integer.';
        endif
        case 'equiv'
          out={};
          out.algorithm={1,2,2,'lpsolver'};
          out.preprocess={1,0,'presol'};
          out.display={2,0,3,'msglev'};
          out.maxtime={'tmlim'};
          out.maxiterations={'itlim'};
         case 'int_equiv'
          out={};
          out.lppreprocess={1,0,'presol'};
          out.display={2,0,3,'msglev'};
          out.maxtime={'tmlim'};
          out.lpmaxiterations={'itlim'};
      end
  end
end

  
  
