clc;clear;close all

SearchAgents_no=30; 

global ref
ref=3000;

Max_iter=50;

lb=0;ub=1;
dim=3;

fobj=@f;

[Alpha_score,Alpha_pos]=GWO(SearchAgents_no,...
    Max_iter,lb,ub,dim,fobj);


save res1.mat
% pause(10)
% system('shutdown /s')

