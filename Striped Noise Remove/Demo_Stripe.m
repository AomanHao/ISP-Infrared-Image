%% ������� 
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clear;
close all;
clc;

addpath('./method');
addpath('./tools');

pathname = '.\test_image\image\';
% pathname = '.\image_noise\';
img_conf = dir(pathname);%ͼ�������
img_name = {img_conf.name};
img_num = numel({img_conf.name})-2;

data_type = 'bmp'; % raw: raw data
                    %bmp: bmp data
conf.save_file = '.\result\';

flag_win_mean = 1; %�ֲ����ھ�ֵ����
flag_bilateral = 1; %˫���˲�������������
flag_win_mean_LP = 0; %���ھ�ֵ�����Ƶ��Ϣ


conf.noise_type = 'colstripe';% rowstripe or colstripe��

for i = 1:img_num
    switch data_type
        case 'raw'

        case 'bmp'
            name = split(img_name{i+2},'.');
            conf.imgname = name{1};
            conf.imgtype = name{2};
            img_re = imread([pathname,img_name{i+2}]);
            img = im2double(img_re);
            [m_img,n_img,z_img] = size(img);
            figure;imshow(img);
    end
    if size(img,3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    conf.pathname = pathname;
    conf.m_img = m_img;
    conf.n_img = n_img;
    
    
    %% �����ֵ����
    if flag_win_mean == 1
        conf.win_radius = 2;
        conf.sigma = 0.5;
        img_out = DeSN_win_mean(img_gray,conf);
    end
    %% ˫���˲�����
    if flag_bilateral == 1
        conf.w     = 2;       % bilateral filter half-width
        conf.sigma = [3 0.1]; % bilateral filter standard deviations
        img_out = DeSN_LP_bilateral(img_gray,conf);
    end
    
    %% ���ھ�ֵ����
    if flag_win_mean_LP == 1

        img_out = DeSN_LP_mean(img_gray,conf);
    end

    
end





