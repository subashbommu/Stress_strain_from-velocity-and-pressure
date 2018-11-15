clear;
clc;
cd ('G:\08Aug18\extracts\50000_ramp')
filename = ['bg_C100000' int2str(1) '.tif'];
average=im2double(imread('G:\08Aug18\extracts\50000_ramp\average.tif'));
initial=1;
last=103;
parfor img=initial:last    
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
imwrite(imsubtract(im2double(x),average),fullfile('G:\ex_ph\test\',filename));
%disp('Subtracting %d of %d',img,last);
disp(img)
end