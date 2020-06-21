% Single-photon Lidar Monte Carlo simulation
% copyright Zhijian Li,  Nov 11, 2019
% I can be reached at: lee-charlie@outlook.com

clc
clear

% Lidar working parameters
N_pulse = 1; % �����������
P_w = 10e-9;           % ����
noise = 10e6; %��������
range_gate = 100e-9; %�����ſ�ȡ�����ľ����ű����������ʱ�䣡
dead_time = 45e-9; %����ʱ�䳤��
z0 = 10;   % ����Ŀ����룬��

% ��������
count = 10000;    % ���ؿ��޷������
L_in_nano_sec = 2*z0/3e8;   % ���룬�����ns
Time_resolution = 100e-12; %����ʱ϶��bin���Ŀ��
t = Time_resolution:Time_resolution:range_gate; %����һ�����ڵ���ɢʱ϶
T_jump = floor(dead_time/Time_resolution); % ����ʱ�����������
time_channel_amount = length(t);

% ���ɸ�˹�ز�����
Tau = P_w/sqrt(8*log(2));
Peak_signal_rate = N_pulse/(Tau*sqrt(2*pi)); % ��˹�����ֵ��������
data_origin_waveform = fun_Gauss_waveform(Peak_signal_rate,t,Time_resolution,P_w,L_in_nano_sec);
% �ز�������
data_origin_waveform = data_origin_waveform + noise*Time_resolution;
% ���㲻������ʱ���ԭʼ Poisson_PDF
Poisson_PDF_total = 1 - exp(-data_origin_waveform);
% ���ؿ��޷��棺������ģʽ
[Sum_histogram_rangegate,Sum_0]=fun_simulation_core_universal(Poisson_PDF_total,count,T_jump);

figure(1)
plot(t*1e9,Sum_histogram_rangegate,'r')
xlabel('Time ns')
ylabel('Photon counts')
title('MC photon count histogram')

figure(2)
plot(t*1e9,data_origin_waveform,'b')
xlabel('Time ns')
ylabel('a.u.')
title('Original waveform')