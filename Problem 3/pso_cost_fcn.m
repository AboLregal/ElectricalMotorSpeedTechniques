function [best_score]=pso_cost_fcn(mat)

%% Define Inputs in Other Method
% mat=reshape(mat,[1 27]);
mzzzzzz=mat(1:27);
mzzzzzz=reshape(mzzzzzz,[1 27]);
% mxxxxxx=mat(28:end);
global ref ref_rt hisham
load init_pso200.mat
[cx,lx]=min(cost200);
lcx=length(cost200);
figure(4)
plot(cost200)
hold on
plot(lx,cx,'r*')
title(strcat('Best Score=',num2str(cx),'&& at Iteration=',num2str(lx)))
xlabel(strcat('At Iteration=',num2str(lcx)))
hold off
hisham=pso_out_struct{end};
hisham=adding(hisham,mzzzzzz);
% for i=1:length(mxxxxxx)
%     ozzz=round(mxxxxxx(i));
%     ozzz(ozzz<=1)=1;
%     ozzz(ozzz>=5)=5;
%     hisham.rule(i).consequent=ozzz;
% end
pso_out_struct{end+1}=hisham;
assignin('base','hisham',hisham)
%% Runing Simulation
sim('fuzzy1001.slx');
x=wa(:,2);
t=t;
best_response{end+1}=x;
bst_time{end+1}=t;

figure(5)
plot(bst_time{1},best_response{1},t,x)
hold on
legend('GA OUT','PSO Out')
title('New Response from PSO compare with GA')
xlabel('Time');ylabel('Response')
hold off
% [mx]=findpeaks(x);
% mx=mx(1);L=find(x==mx,1,'first');
% if mx<ref && mx>.95*ref
%     mx=ref;
% end
% if mx<ref  || L>length(x)/2
%     best_score=0;
% elseif max(x)>1.1*ref
%     best_score=0;
% elseif mx>1.03*ref && max(x)<1.1*ref
%     x1=0;best_score=.01;
% elseif mx<=1.03*ref && mx>=ref 
%     best_score=abs((max(x)-ref)/ref);
%     best_score=1-best_score;
%     x1=best_score;
% end
% if best_score~=0
%     if max(x)<ref || max(x)>1.2*ref
%         best_score=0;
%     end
% end
% if best_score~=0
%     z=x(L+1:end);
%     if min(z)<.9*ref
%         x2=0;
%     else
%         x2=1-abs((ref-min(z))/ref);
%     end
% end
% if best_score~=0
%     [~,m]=min(z);
%     o=x(m+L:end);
%     mx1=round(max(o));
%     mx2=round(min(o));
%     if mx1<ref || mx2>ref
%         best_score=0;
%     elseif mx1>ref+5 || mx2<ref-5
%         x3=0;
%     else
%         x3=1-abs((mean(o)-ref)/ref);
%     end
% end
% 
% if best_score~=0
%     [~,L]=findpeaks(x);
%     rt=t(L(1));
%     if rt<=ref_rt
%         x4=1;
%     elseif rt>ref_rt*2
%         x4=0;
%     else
%         x4=1-abs((rt-ref_rt)/ref_rt);
%     end
% end
% if best_score~=0
%     zx=[x1 x2 x3 x4];
%     best_score=prod(zx);
%     if best_score==0
%         zx(zx==0)=[];
%         best_score=(4-length(zx))*.1*prod(zx);
%     end
% end
% if best_score==0 || best_score>.1
%     best_score=1e-6;
% end

Step = stepinfo(x,t);
best_score=abs(Step.Peak-ref)+Step.SettlingTime;
best_score=best_score+abs(mean([Step.SettlingMax Step.SettlingMin]-ref));

cost200(end+1)=best_score;
save init_pso200.mat cost200 pso_out_struct best_response bst_time