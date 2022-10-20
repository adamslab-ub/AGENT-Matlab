function [F_total,C_total,additional_outputs]= Simulate(out_needed_local,genomeNumber,generationNumber)

F_best_till_now = out_needed_local.F_best_till_now;

strgen = num2str(genomeNumber);
save(['out_needed' strgen '.mat'],'out_needed_local')
openAI_run = out_needed_local.simul_para.openAI_run ;
comment = sprintf('python "%s" %d %d',[openAI_run,'.py'],genomeNumber,generationNumber); % For windows., For linux change it 

[status,cmdout] = system(comment);

infoMat = load(['Reward' num2str(genomeNumber) '.mat']);
F_total = infoMat.totalReward;
if F_total>F_best_till_now
    save([pwd, '\' num2str(F_total) , 'out_needed_local.mat'], 'out_needed_local');
end
C_total=0;
additional_outputs.counter_Amir = infoMat.counter_Amir;% total episodes
additional_outputs.totalStepCounter = infoMat.totalStepCounter;% steps in all episodes together
end