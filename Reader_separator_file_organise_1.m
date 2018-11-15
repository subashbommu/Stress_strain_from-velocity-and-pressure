clear;close all;clc
%addAttachedFiles(gcp,{'bnd_sep.m'})
cd ('G:\08Aug18\extracts\25000_ramp')
average=unit8(imread('G:\08Aug18\extracts\25000_ramp\test\average.tif'));
start=5000;
finish=120000;
% Z1=zeros(288,640);
% Y=zeros(288,640);
% bd=zeros(1000,2);
mkdir('solid');
mkdir('liquid');
mkdir('int')
parfor img=start:finish
    if img<10
        filename = ['BS_72hrs_00000' int2str(img) '.tif'];
        txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int00000' int2str(img) '.dat'];
    elseif  img<100
        filename = ['BS_72hrs_0000' int2str(img) '.tif'];
         txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int0000' int2str(img) '.dat'];
    elseif img<1000
        filename = ['BS_72hrs_000' int2str(img) '.tif'];
        txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int000' int2str(img) '.dat'];
    elseif img<10000
        filename = ['BS_72hrs_00' int2str(img) '.tif'];
        txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int00' int2str(img) '.dat'];
    elseif img<100000
        filename = ['BS_72hrs_0' int2str(img) '.tif'];
        txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int0' int2str(img) '.dat'];
    else 
        filename = ['BS_72hrs_' int2str(img) '.tif'];
        txtfile1 = ['G:\08Aug18\extracts\25000_ramp\int\int' int2str(img) '.dat'];
    end
 %   clear X Y Z p q A1 A2 A3 Z1 bndry bd a
   
%     bd(:,1)=bndry2(:,2);
%     bd(:,2)=bndry2(:,1);
%     figure(1)
%     imshow(Z1)
%     figure(2)
%     imshow(Z2)
%     pause
    %a=dlmread(txtfile);
    X=imread(filename);
    
   % [bd,Z1,Y]=bnd_sep(subt);
    img1=img-start+1;
       Y = imadjust(X,[0 1],[0 1]);
    Z = imbinarize(Y);
    [p,q] = size(Z);
    A1 =[zeros(p,1) Z zeros(p,1);zeros(1,q+2)];
    A2 = bwareaopen(A1,1000);
    A3 = imfill(A2,'holes');
    Z1 =A3(1:end-1,2:end-1);
    SE = strel('disk',3);
    Z2 = imdilate(Z1,SE);
    [r,s] = find(Z2==1);
    for ni=1:length(r)
        Y(r(ni),s(ni))=0;
    end
    sub=imsubtract(im2double(Y),average);
    %bndry1 = cell2mat(bwboundaries(Z1));
    bndry2 = cell2mat(bwboundaries(Z2));
   % bd=bndry2(:,1:2);
%     dlmwrite(txtfile1,bndry2,',');
   imwrite(sub,fullfile('G:\08Aug18\extracts\25000_ramp\test',filename));
%      cd('solid')
%      imwrite(uint8(255*Z1),filename)
%      cd ..
%      
%      cd('liquid')
%      imwrite(uint8(Y),filename)
%      cd ..

disp(img)
end
