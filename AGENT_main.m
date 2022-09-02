function AGENT_main(varargin)
%Amir Behjat
close all;
clc;

if isempty(varargin)  
    sample_id = 1; % sample_id is Index for saving, 1 is the default
else 
    sample_id = varargin{:};
end

AGENT(sample_id);    

end