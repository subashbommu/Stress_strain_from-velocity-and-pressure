start =5000;
finish =44900;
interval=100;
count=0;
s_x_p=zeros(301,1);
s_y_p=zeros(301,1);
t_tmp=1;
for img=start:interval:finish
    
    count=count+1;
%     if img<10
%        % filename = ['E:\piv_biofilm\q1\df\op_data_' int2str(img) '.tif'];
%         txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int00000' int2str(img) '.dat'];
%     elseif  img<100
%        % filename = ['BS_72hrs_0000' int2str(img) '.tif'];
%          txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int0000' int2str(img) '.dat'];
%     elseif img<1000
%       %  filename = ['BS_72hrs_000' int2str(img) '.tif'];
%        txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int000' int2str(img) '.dat'];
%     elseif img<10000
%       %  filename = ['BS_72hrs_00' int2str(img) '.tif'];
%         txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int00' int2str(img) '.dat'];
%     elseif img<100000
%        % filename = ['BS_72hrs_0' int2str(img) '.tif'];
%         txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int0' int2str(img) '.dat'];
%     else 
%        % filename = ['BS_72hrs_' int2str(img) '.tif'];
%         txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int' int2str(img) '.dat'];
%     end
%     
      if 2*img<10
     %  filename = ['G:\08Aug18\5000_ramp\parula_000' int2str(img) '.mat'];
        txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int00000' int2str(img*2) '.dat'];
    elseif  2*img<100
      %  filename = ['G:\08Aug18\5000_ramp\parula_00' int2str(img) '.mat'];
         txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int0000' int2str(img*2) '.dat'];
    elseif 2*img<1000
      %  filename = ['G:\08Aug18\5000_ramp\parula_0' int2str(img) '.mat'];
       txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int000' int2str(img*2) '.dat'];
    elseif 2*img<10000
       % filename = ['G:\08Aug18\5000_ramp\parula_' int2str(img) '.mat'];
        txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int00' int2str(img*2) '.dat'];
    elseif 2*img<100000
       % filename = ['G:\08Aug18\5000_ramp\parula_' int2str(img) '.mat'];
        txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int0' int2str(img*2) '.dat'];
    else 
       % filename = ['G:\08Aug18\5000_ramp\parula_' int2str(img) '.mat'];
        txtfile1 = ['F:\Biofilm_deformation_experiments\extract\10000_ramp\int\int' int2str(img*2) '.dat'];
    end
    filename = ['E:\piv_biofilm\q1\df\op_data_' int2str(img) '.dat'];
   
     interface = dlmread(txtfile1);
     s_x=interface(((length(interface)/3)-150):((length(interface)/3)+150),1).*1E-6;
s_y=interface(((length(interface)/3)-150):((length(interface)/3)+150),2).*1E-6;

if img == start
    s_x_orig=s_x;
    s_y_orig=s_y;
end
s_dx=s_x-s_x_orig;
s_dy=s_y-s_y_orig;
fin_s_x(count,1:301)=s_dx./s_x_orig;
fin_s_y(count,1:301)=s_dx./s_y_orig;
    tmp=dlmread(filename);
    x=reshape(tmp(:,1), [17,39]);
y=reshape(tmp(:,2), [17,39]);
u=reshape(tmp(:,3), [17,39]);
v=reshape(tmp(:,4), [17,39]);
dpdx=reshape(tmp(:,5), [17,39]);
dpdy=reshape(tmp(:,6), [17,39]);
p=reshape(tmp(:,7), [17,39]);
modp=reshape(tmp(:,8), [17,39]);

x(isnan(x))=0.0;
y(isnan(y))=0.0;
u(isnan(u))=0.0;
v(isnan(v))=0.0;
dpdx(isnan(dpdx))=0.0;
dpdy(isnan(dpdy))=0.0;
p(isnan(p))=0.0;
modp(isnan(modp))=0.0;

l=size(p);
mu=1e-3;


for i =1: l(1)
    tz=find(v(i,:));
    pt(i)=p(i,tz(1));
    ut(i,1:2)=u(i,tz(1):tz(1)+1);
    vt(i,1:2)=v(i,tz(1):tz(1)+1);
    tu_yy(count,i)=2*mu*((vt(i,2)-vt(i,1))/(1.6e-5));
    tot_p(count,i)=pt(i);   
end
for i =1:l(1)-1
     tu_xx(count,i)=2*mu*((ut(i+1,1)-ut(i,1))/(1.6e-5));
     tu_xy(count,i)=mu*(((ut(i,2)-ut(i,1))/(1.6e-5))+(vt(i+1,1)-vt(i,1))/(1.6e-5));
     
end
ta(count)=(start*2*1.25E-4)+1.2500e-04*(t_tmp)*interval;
t_tmp=t_tmp+2;
    count
end
t_tot=tu_xx+tu_yy(:,1:16)+tu_xy;
tt3=mean(t_tot')
tu_mean=movmean(tt3,50)
tt2=mean(fin_s_y(2:400,:)')
sx_mean=movmean(tt2,50)


%10K strain
%      f = p1.*ta1.^3 + p2.*ta1.^2 + p3.*ta1 + p4
% Coefficients (with 95% confidence bounds):
%        p1 =   0.0001196  
%        p2 =    -0.00255 
%        p3 =     0.01304  
%        p4 =    -0.03582  
    p1 =  -8.833e-05  
       p2 =    0.001357 
       p3 =   -0.005236 
       p4 =    -0.01434  
% 10K stress
%      f1 = p1.*ta1.^3 + p2.*ta1.^2 + p3.*ta1 + p4
% Coefficients (with 95% confidence bounds):
%        p1 =    0.001775  
%        p2 =    -0.03564 
%        p3 =      0.2025 
%        p4 =     -0.1176  
       p1 =    -0.00802  
       p2 =       0.104  
       p3 =      -0.116  