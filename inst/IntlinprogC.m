classdef IntlinprogC < handle
%Intlinprog options class
 
  properties
    Display
    LPMaxIterations 
    %BranchRule (den exei oles tis epiloges to octave)
    LPPreprocess
    MaxTime
  end
  
  methods
    function obj = setdatas(obj,data)
      if mod(length(data),2)==0
        for i=1:2:length(data)
          datat=lower(data{i});
          switch (datat)
             case 'lpmaxiterations'
              obj.LPMaxIterations=data{i+1};
             case 'display'
              obj.Display=data{i+1};
             case 'lppreprocess'
              obj.LPPreprocess=data{i+1};
             case 'maxtime'
              obj.MaxTime=data{i+1};
             otherwise
              error(strcat('`',data{i},'` is not an option for INTLINPROG.'));
          end
        end
       else
        error("Different number of parameters and values");
      end
    end
    
    function set.LPMaxIterations(obj,a)
      if isnumeric(a) && a>=0 && mod(a,1)==0
        obj.LPMaxIterations=a;
      else
        disp(xlindata('options.maxiterations.error'));
      end
    end
    
    function set.LPPreprocess(obj,a)
      if any(strcmpi(lower(a),cellstr(xlindata('options.preprocess'))))
        obj.LPPreprocess=lower(a);
      else
        disp(xlindata('options.preprocess.error'));
      end
    end
    
    function set.Display(obj,a)
      if any(strcmpi(lower(a),cellstr(xlindata('options.display'))))
        obj.Display=lower(a);
      else
        disp(xlindata('options.display.error'));
      end
    end
    
    function set.MaxTime(obj,a)
      if isnumeric(a) && a>=0
        obj.MaxTime=a;
      else
        error(xlindata('options.maxtime.error'));
      end
    end
    
    function s = matlab2glpk(obj)
      s=struct();                                                             % init struct
      d=xlindata("options.int_equiv");                                        % get the equivilent xlindata
      props={'LPMaxIterations','Display','LPPreprocess','MaxTime'};           % properties() would be better but not working, meta?
      for n = 1:length(props)                                     
        prop=props{n};                                
        lprop=lower(prop);                                                    % lower name 
        if ~isempty(obj.(prop))                                               % check if the object property has a value
          if any(strcmp(lprop,{'maxtime','lpmaxiterations'}))                 % maxtime maxiterations need no conversion
            s.(d.(lprop){end})=obj.(prop);                                    % add field to struct and assign value
            continue
          end
          nr=find(strcmp(obj.(prop),xlindata(strcat("options.",lprop))));     % find the index of the original property value from the cell stored at xlindata
          s.(d.(lprop){end})=d.(lprop){nr};                                   % assign the equivilent value to the struct
        end
      end
      
    end
  end
 end
