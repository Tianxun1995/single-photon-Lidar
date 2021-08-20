% Single-photon Lidar Monte Carlo simulation
% copyright Zhijian Li,  Nov 11, 2019
% Contact me: lee-charlie@outlook.com
% Latest edit by Zhijian Li, Aug 20, 2021

clc
clear

% �����״﹤������
N_pulse = 3; % �����ز����������ƽ���������
P_w = 10e-9;  % ��˹���������FWHM����
noise = 10e6; % ������������
range_gate = 100e-9; % �����ſ�ȣ�Ҳ����ÿ������ϵͳ�Ĺ���ʱ�䳤�ȡ�����ľ����ű����������ʱ�䣡
dead_time = 45e-9; % ̽��������ʱ�䳤��
z0 = 5;   % ����Ŀ����룬��

% ��������
count = 30000;    % ���ؿ��޷�����ۼƴ���
L_in_nano_sec = 2*z0/3e8;   % ���룬���������
Time_resolution = 100e-12; %����ʱ϶�������е�time bin��time channel��time resolutionָ����ͬһ������Ŀ��
t = Time_resolution:Time_resolution:range_gate; %����һ�����ڵ���ɢʱ϶
time_channel_amount = length(t); % ʱ϶���ܸ���
T_jump = floor(dead_time/Time_resolution); % ����ʱ������ε�ʱ϶������

% ���ɸ�˹�ز�����
Tau = P_w/sqrt(8*log(2)); % ����Tau
Peak_signal_rate = N_pulse/(Tau*sqrt(2*pi)); % ��˹�����ֵ��������
data_origin_waveform = fun_Gauss_waveform(Peak_signal_rate,t,Time_resolution,P_w,L_in_nano_sec); % ��ɢʱ϶ʱ�����ϵĲ��������ĸ�˹�ز��źţ���ÿ�����ݵ��ʾ��ÿ��ʱ϶�ڵĽ��յ���ƽ�����������

% �ز����������õ���ɢʱ϶ʱ�����Ϻ���Ļز��źţ�ÿ�����ݵ��ʾ��ÿ��ʱ϶�ڵĽ��յ���ƽ�����������
data_origin_waveform = data_origin_waveform + noise*Time_resolution; % ÿ��ʱ϶�ڵ������������Ϊnoise*Time_resolution������������ز��ź���

% ���㲻������ʱ��Ӱ��ġ��������Ӽ����źŵġ�ԭʼ���ɸ���Poisson_PDF
Poisson_PDF_total = 1 - exp(-data_origin_waveform);

% ���ؿ��޷��棺������ģʽ
[Sum_histogram,Sum_0] = fun_simulation_core_universal(Poisson_PDF_total,time_channel_amount,count,T_jump);

% �����ͼ
figure(1)
plot(t*1e9,Sum_histogram,'r')
xlabel('Time ns')
ylabel('Photon counts')
title('MC photon count histogram�����ؿ������õ��Ļ����TCSPCֱ��ͼ���Σ�')

figure(2)
plot(t*1e9,data_origin_waveform,'b')
xlabel('Time ns')
ylabel('ÿ��ʱ϶�ڽ��յ���ƽ���������')
title('Original waveform��ԭʼ���յ�����ʵ�Ⲩ�Σ�')