%  Golden Jackal Optimization  (GJO)            
SearchAgents_no=25; % Number of search agents
Max_iteration=3; % Maximum numbef of iterations

Function_name='F1';
% 'F1'Tension/compression spring design; 
% 'F2' %Pressure vessel design
% 'F3' %Welded beam design 
% 'F4' %Speed Reducer design 
% 'F5'  Gear train design problem
% 'F6' Three-bar truss design problem

%% Load details of the selected engineering design problem
Function_name = 'F23';  % Change this to the desired function name
[lb, ub, dim, fobj] = Get_Functions_details(Function_name);

runn=5;% maximum number of re-run of GJO
cost=zeros(runn,1);pos=zeros(runn,4);
for i=1:runn
    disp(['Run no: ',num2str(i)]);
 [Male_Jackal_score,Male_Jackal_pos,GJO_cg_curve]=GJO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
cost(i,:)=Male_Jackal_score;
end
mean_cost=mean(cost);
min_cost=min(cost);
max_cost=max(cost);

disp(['best value GJO:  ',num2str(min_cost,10),'  Mean: ', num2str(mean_cost),'  Max: ', num2str(max_cost)]);
figure;
plot(GJO_cg_curve);
title('Objective Function vs Iteration');
xlabel('Iteration');
ylabel('Objective Function Value');
grid on;
