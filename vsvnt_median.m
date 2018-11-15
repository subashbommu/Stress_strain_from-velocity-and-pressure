clc;
clear;
ua=zeros(1,1000);
va=zeros(1,1000);
ta=zeros(1,1000);
t_tmp=1;
for k=1:1000
us=12;
ue=16;
vs=7;
ve=11;
interval=45;
count=k*interval;


   if count<10
        filename= ['E:\piv_biofilm\ParaPIV\data\data_000',int2str(count),'.mat'];
    elseif  count<100
        filename= ['E:\piv_biofilm\ParaPIV\data\data_00',int2str(count),'.mat'];
   elseif count<1000
        filename= ['E:\piv_biofilm\ParaPIV\data\data_0',int2str(count),'.mat'];
   else
       filename= ['E:\piv_biofilm\ParaPIV\data\data_',int2str(count),'.mat'];
   end
load(filename);
for i =7:11
    for j=12:16
        ut(i-6,j-11)=u(i,j);
        vt(i-6,j-11)=v(i,j);
    end
end
c(k)=count;
ua(k)=median(median(ut))*(1E-6/1.25E-4);
va(k)=median(median(vt))*(1E-6/1.25E-4);
ta(k)=1.2500e-04*(t_tmp)*interval;
clear u v 
t_tmp=t_tmp+2
end
