
list_numbs = [0:23,23.5,24];


    % mat_part = load('C:\Amir\UB\Proposals\offset pROPOSAL\pYTHOON ME\est 0\Required\just_the_sh_MAT');
    % pyt_part = load('C:\Amir\UB\Proposals\offset pROPOSAL\pYTHOON ME\est 0\scratches\just_the_sh_PYT.mat');
    % sdsa
% if isequla  (mat_part,pyt_part)   
per_genome_data = 5;
for run_step=1:30
    
    for j= list_numbs
        
        load(['C:\Amir\UB\Proposals\offset pROPOSAL\pYTHOON ME\est 0\Required\SAVE_TOCHECK_MAT' num2str(run_step) ' on ' num2str(j) '.mat']);
        load(['C:\Amir\UB\Proposals\offset pROPOSAL\pYTHOON ME\est 0\scratches\SAVE_TOCHECK_PYT' num2str(run_step) ' on ' num2str(j) '.mat']);
        
        for i=1:5:length(SAVE_TOCHECK_MAT)
            works =1;
            
            for ii=1:per_genome_data
                if abs(sum(sum( SAVE_TOCHECK_MAT(i-1+ii).data)) - sum(sum(SAVE_TOCHECK_PYT{1, i-1+ii+1}  ))) >0.001
%                     SAVE_TOCHECK_MAT(i-1+ii).data
%                     SAVE_TOCHECK_PYT{1, i-1+ii+1}
%                     
%                     ii
%                     abs(sum(sum( SAVE_TOCHECK_MAT(i-1+ii).data)) - sum(sum(SAVE_TOCHECK_PYT{1, i-1+ii+1}  )))
                    works =0;
                end
            end
                    
                %         i
                %         SAVE_TOCHECK_MAT(i).data
                %         SAVE_TOCHECK_PYT{1, i+1}
            if works==0
                ['run_step' , num2str(run_step) '; ' 'XXXXXXXXXXXXXXXXXXX' , num2str(j) '; Genome ' num2str(ceil(i/per_genome_data))]
%                 for ii=1:per_genome_data
%                     i-1+ii
%                     SAVE_TOCHECK_MAT(i-1+ii).data
%                     SAVE_TOCHECK_PYT{1, i-1+ii+1}
%                 end
%                 sadsadsadsa
                    
            end
        end
    end
 
end