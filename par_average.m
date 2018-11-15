clear;
clc;
cd ('E:\piv_biofilm\25kramp\liquid')
start=116718;
finish=120000;
%mkdir('test');
filename = ['BS_72hrs_' int2str(start) '.tif'];
a1=im2double(imread(filename));
%a1=imcrop(in,[470,1,810,1024]);
for img=(start+1):finish
    if img<10
        filename = ['BS_72hrs_00000' int2str(img) '.tif'];
    elseif  img<100
        filename = ['BS_72hrs_0000' int2str(img) '.tif'];
    elseif img<1000
        filename = ['BS_72hrs_000' int2str(img) '.tif'];
    elseif img<10000
        filename = ['BS_72hrs_00' int2str(img) '.tif'];
    elseif img<100000
        filename = ['BS_72hrs_0' int2str(img) '.tif'];
    else 
        filename = ['BS_72hrs_' int2str(img) '.tif'];
    end
x=imread(filename);
%x1=imcrop(x,[470,1,810,1024]);
% whole(:,:,img)=x;
% a1=imadd(a1,medfilt2(im2double(x)));
% %disp('Averaging %d of %d',img,finish);
disp(img)

end
% average=a1/(finish-start+1);
% imwrite(average,'C:\Users\b3053534\Desktop\1_1\test\average.tif','tif');