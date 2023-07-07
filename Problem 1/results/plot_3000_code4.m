clc;clear;close all

load GWO_3000t
load woa_3000t
load system_3000t
% load('system.mat')

figure()
plot(speed_GWO)
hold on
plot(speed_woa,'r')
title('speed')
plot(speed,'k')
plot([0 5],[3000 3000],'b--')
title('Speed')
xlabel('Time [S]')
legend('GWO','WOA',...
    'intial System',...
    'refrence',...
    'location','southeast','fontsize',15)
xlim([0 1])
T1=voltage_GWO.time;S1=speed_GWO.data;
T2=speed_woa.time;S2=speed_woa.data;
T3=speed.time;S3=speed.data;
disp('************')
disp('GWO Step Info')
stepinfo(S1,T1)
disp('************')
disp('WOA Step Info')
stepinfo(S2,T2)
disp('************')
disp('Intial Syste, Step Info')
stepinfo(S3,T3)
disp('************')


figure()
t1=voltage_GWO.time;d1=voltage_GWO.data;
t2=voltage_woa.time;d2=voltage_woa.data;
t3=voltage.time;d3=voltage.data;
subplot(311)
plot(t1(5:end),d1(5:end));title('Voltage GWO')
subplot(312)
plot(t2(5:end),d2(5:end),'r');title('Voltage WOA')
subplot(313)
plot(t3(5:end),d3(5:end),'k');title('Voltage')

figure()
t1=current_GWO.time;d1=current_GWO.data;
t2=current_woa.time;d2=current_woa.data;
t3=current.time;d3=current.data;
subplot(311)
plot(t1,d1);title('Current GWO')
subplot(312)
plot(t2,d2,'r');title('Current WOA')
subplot(313)
plot(t3,d3,'k');title('Current')

figure()
t1=control_GWO.time;d1=control_GWO.data;
t2=control_woa.time;d2=control_woa.data;
t3=control.time;d3=control.data;
subplot(311)
plot(t1(15:end),d1(15:end));title('Control GWO')
subplot(312)
plot(t2(15:end),d2(15:end),'r');title('Control WOA')
subplot(313)
plot(t3(15:end),d3(15:end),'k');title('Control')

figure()
t1=torque_GWO.time;d1=torque_GWO.data;
t2=torque_woa.time;d2=torque_woa.data;
t3=torque.time;d3=torque.data;
subplot(311)
plot(t1,d1);title('Torque GWO')
subplot(312)
plot(t2,d2,'r');title('Torque WOA')
subplot(313)
plot(t3,d3,'k');title('Torque')



disp('GWO PID')
fprintf('P = %1.4f \n I = %1.4f \n D = %1.4f \n',P_GWO,I_GWO,D_GWO)

disp('WOA PID')
fprintf('P = %1.4f \n I = %1.4f \n D = %1.4f \n',P_woa,I_woa,D_woa)

disp('PID')
fprintf('P = %1.4f \n I = %1.4f \n D = %1.4f \n',P,I,D)
