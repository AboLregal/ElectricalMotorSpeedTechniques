clc;clear;close all

global S T
S=1000*[.5:.5:2.5 2:-.5:.5];
T=0:8;

Max_iter=50;
SearchAgents_no=30;

lb=[0 0 0 0.5 0.5];ub=[10 10 5 2 2];
dim=5;

fobj=@f_multi;

[Alpha_score,Alpha_pos]=WOA(SearchAgents_no,...
    Max_iter,lb,ub,dim,fobj);

save res_woa_multi3000.mat

system('shutdown -s')