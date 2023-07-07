function fit=f_multi(x)

global T S
% global P I D
assignin('base','P',x(1))
assignin('base','I',x(2))
assignin('base','D',x(3))
assignin('base','Ts',5e-6)
assignin('base','b',x(4))
assignin('base','c',x(5))

sim('multi_speed.slx')
Step = stepinfo(speed.Data,speed.Time);

t=speed.time;sp=speed.data;
st=1;
fit=0;
for k=2:length(T)+1
    ref=S(k-1);T1=T(k-1);
    if k<=length(T)
        [~,ed]=min(abs(t-T(k)));
        Tx=t(st:ed);Sx=sp(st:ed);
        st=ed+1;
    else
        Tx=t(st:end);Sx=sp(st:end);
    end
    Step=stepinfo(Sx,Tx);
    if Step.SettlingTime-T1<.5
        f=abs(Step.Peak-ref)+(Step.PeakTime-T1);
        f=f+abs(mean([Step.SettlingMax Step.SettlingMin])-ref);
    else
        f=1e6+abs(Step.Peak-ref)+(Step.PeakTime-T1);
        f=f+abs(mean([Step.SettlingMax Step.SettlingMin])-ref);
    end
    fit=fit+f;
end

plot(speed);
hold on
stairs([T T(end)+1],[S S(end)],'r')
ylim([0 3000])
legend(['Fitness =',num2str(fit)],'Ref');pause(1)
hold off

fprintf('P=%2.4f & I=%2.4f & D=%2.4f \n b=%2.4f & c=%2.4f => f=%4.2f \n',x(1),...
    x(2),x(3),x(4),x(5),fit)


