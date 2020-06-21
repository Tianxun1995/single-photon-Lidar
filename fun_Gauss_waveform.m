function data_oringe_waveform = fun_Gauss_waveform(Peak_signal_rate,t,Time_resolution,P_w,L)
%���Ӽ�����˹���η��棬���ز��ɸ�����ʱ϶��̽����ʷֲ�Poisson_PDF_total������ʱ������ʱ϶�ĸ���T_jump�͵�����ز�����N_pulse
%�����L�����루�Ѿ����������˫�̷���ʱ�䣬�������汾��"�����������"��ͬ��
A = Peak_signal_rate*Time_resolution;                       %ʱ϶�ڹ�������ֵ    %A = N/(Tau*sqrt(2*pi));
Tau = P_w/sqrt(8*log(2));                                   %��˹�����һ������tau
d = L;  % d = 2*L/3e8; 
data_oringe_waveform = A*exp( (-1/(2*Tau*Tau)) * (t - d).^2);
% 
% %�Ż���˹�������ݣ�ʹ������ֵ�ֲ��ϰ��������������ϸ�Գ�
% [~,Mn0]=find(S==max(S));
% Mn = Mn0(1);
% bb = round(2*P_w/Time_resolution);
%  = S(Mn-bb+1:Mn);
end