clc;clear;close all
clear global
close all force
warning off
%%
global ref ref_rt hisham
%%
load best_one_200.mat
cost200=m{3};hisham=m{4};best_response{1}=m{1}; bst_time{1}=m{2};
pso_out_struct{1}=hisham;
load mat.mat
mat=m;

save init_pso200.mat cost200 best_response bst_time pso_out_struct
% load best_one_1100.mat
% best_1100=m;
% clear m


%%
ref=200;ref_rt=0.01;
format short
Bird_in_swarm=15;
% Number of tests per 1 Iteration
MinMaxRange=[mat(1:27)-0.1 mat(1:27)+0.1];
% Variables Change Limits
Food_availability='pso_cost_fcn';
% Cost Function Name
availability_type='min';
% PSO Target
max_iteration=35;
% Number Of Iteration
% Number of Testing =Bird_in_Swarm*Max_Iteration

Min_Inertia_weight=.4;
Max_Inertia_weight=.9;
velocity_clamping_factor=2;
cognitive_constant=2;
social_constant=2;
Number_of_quality_in_Bird=27;
availability_type=lower(availability_type(1:3));
[row,col]=size(MinMaxRange);
if row~=Number_of_quality_in_Bird || col~=2
    error('Not a proper MinMaxRange Matrix')
end
for i=1:Number_of_quality_in_Bird
    if MinMaxRange(i,1)>=MinMaxRange(i,2)
        error('Minimum value greater than Maximum value!!!')
    end
end

%{
	 counter to display % of completion
%}
N=Bird_in_swarm*max_iteration;
q=0;
bird_min_range=MinMaxRange(:,1);
bird_max_range=MinMaxRange(:,2);
for i=1:Number_of_quality_in_Bird
    bird(:,i)=bird_min_range(i)+(bird_max_range(i)-bird_min_range(i))*rand(Bird_in_swarm,1);
end

Vmax=bird_max_range*velocity_clamping_factor;
Vmin=-abs(Vmax)-.1;

for i=1:Number_of_quality_in_Bird
    Velocity(:,i)=Vmin(i)+(Vmax(i)-Vmin(i))*rand(Bird_in_swarm,1);
end

for itr=1:max_iteration
    fprintf('Completed  %d  %% ...', uint8(q*100/N ))
    
    for p=1:Bird_in_swarm
        parameter=bird(p,:,itr);
        [hisham,parameter]=adding(hisham,parameter);
        availability(p,itr)=feval(Food_availability,parameter);
        
        switch availability_type
            case 'min'
                [pBest_availability,index]=min(availability(p,:));
                pBest=bird(p,:,index);
                
                if(p==1 && itr==1)
                    gBest=pBest;
                    gBest_availability=pBest_availability;
                elseif availability(p,itr)<gBest_availability
                    gBest_availability=availability(p,itr);
                    gBest=bird(p,:,itr);
                end
                
            case 'max'
                [pBest_availability,index]=max(availability(p,:));
                pBest=bird(p,:,index);
                
                if(p==1 && itr==1)
                    gBest=pBest;
                    gBest_availability=pBest_availability;
                elseif availability(p,itr)>gBest_availability
                    gBest_availability=availability(p,itr);
                    gBest=bird(p,:,itr);
                end
                
            otherwise
                error('availability_type mismatch')
        end
        
        w(itr)=((max_iteration - itr)*(Max_Inertia_weight - Min_Inertia_weight))/(max_iteration-1) + Min_Inertia_weight;
        Velocity(p,:,(itr+1))=w(itr)*Velocity(p,:,itr) + social_constant*rand(1,Number_of_quality_in_Bird).*(gBest-bird(p,:,itr)) + cognitive_constant*rand(1,Number_of_quality_in_Bird).*(pBest-bird(p,:,itr));
        Velocity(p,:,(itr+1))=MinMaxCheck(Vmin, Vmax, Velocity(p,:,(itr+1)));
        
        bird(p,:,(itr+1))= bird(p,:,itr) + Velocity(p,:,(itr+1));
        bird(p,:,(itr+1))=MinMaxCheck(bird_min_range, bird_max_range, bird(p,:,(itr+1)));
        q=q+1;
    end
    
    clc;
end
optimised_parameters=gBest;
% save tst.mat
% system('shutdown /s')