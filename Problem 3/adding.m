function [hisham,x]=adding(hisham,mat)

%% Split the Matrix
Ns1=mat(1:3);
Z1=mat(4:6);
Ps1=mat(7:9);
Ns2=mat(10:12);
Z2=mat(13:15);
Ps2=mat(16:18);
Ns3=mat(19:21);
Z3=mat(22:24);
Ps3=mat(25:27);



%% Condtioning & Sorting
Ns1(Ns1<-1)=-1;
Ns1(Ns1>1)=1;
Z1(Z1<-1)=-1;
Z1(Z1>1)=1;
Ps1(Ps1<-1)=-1;
Ps1(Ps1>1)=1;
Ns2(Ns2<-1)=-1;
Ns2(Ns2>1)=1;
Z2(Z2<-1)=-1;
Z2(Z2>1)=1;
Ps2(Ps2<-1)=-1;
Ps2(Ps2>1)=1;
Ns3(Ns3<0)=0;
Ns3(Ns3>1)=1;
Z3(Z3<0)=0;
Z3(Z3>1)=1;
Ps3(Ps3<0)=0;
Ps3(Ps3>1)=1;
Ns1=sort(Ns1);Ns1(1)=-1;
Ns2=sort(Ns2);Ns2(1)=-1;
Ns3=sort(Ns3);Ns3(1)=0;
Z1=sort(Z1);
Z2=sort(Z2);
Z3=sort(Z3);
Ps1=sort(Ps1);Ps1(end)=1;
Ps2=sort(Ps2);Ps2(end)=1;
Ps3=sort(Ps3);Ps3(end)=1;

%%

O=Ns1;F=Z1;V=Ps1;
Ns1(3)=max(F(1),O(3));
Z1(1)=min(F(1),O(3));
Z1(end)=max(V(1),F(3));
Ps1(1)=min(V(1),F(3));

O=Ns2;F=Z2;V=Ps2;
Ns2(3)=max(F(1),O(3));
Z2(1)=min(F(1),O(3));
Z2(end)=max(V(1),F(3));
Ps2(1)=min(V(1),F(3));

O=Ns3;F=Z3;V=Ps3;
Ns3(3)=max(F(1),O(3));
Z3(1)=min(F(1),O(3));
Z3(end)=max(V(1),F(3));
Ps3(1)=min(V(1),F(3));

%%
Ns1=sort(Ns1);Ns1(1)=-1;
Ns2=sort(Ns2);Ns2(1)=-1;
Ns3=sort(Ns3);Ns3(1)=0;
Z1=sort(Z1);
Z2=sort(Z2);
Z3=sort(Z3);
Ps1=sort(Ps1);Ps1(end)=1;
Ps2=sort(Ps2);Ps2(end)=1;
Ps3=sort(Ps3);Ps3(end)=1;


%% Add
hisham.input(1).mf(2).params=Ns1;
hisham.input(2).mf(2).params=Ns2;
hisham.output.mf(2).params=Ns3;
hisham.input(1).mf(3).params=Z1;
hisham.input(2).mf(3).params=Z2;
hisham.output.mf(3).params=Z3;
hisham.input(1).mf(4).params=Ps1;
hisham.input(2).mf(4).params=Ps2;
hisham.output.mf(4).params=Ps3;

x=[Ns1 Z1 Ps1 Ns2 Z2 Ps2 Ns3 Z3 Ps3];