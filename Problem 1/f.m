function fit=f(x)

global ref
% global P I D
assignin('base','P',x(1))
assignin('base','I',x(2))
assignin('base','D',x(3))
assignin('base','Ts',5e-6)


% P=x(1);
% I=x(2);
% D=x(3);

sim('closed_loop_system.slx')
Step = stepinfo(speed.Data,speed.Time);
fit=abs(Step.Peak-ref)+Step.SettlingTime;
fit=fit+abs(mean([Step.SettlingMax Step.SettlingMin]-ref));

plot(speed);text(2,500,['Fitness =',num2str(fit)]);pause(1)
