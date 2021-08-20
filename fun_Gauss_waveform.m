function data_oringe_waveform = fun_Gauss_waveform(Peak_signal_rate,t,Time_resolution,P_w,L)
% ��˹���Ⲩ�εķ��棬����ʱ϶�ڵ�ƽ���������data_oringe_waveform
% 20210820

%�����L�����루�Ѿ����������˫�̷���ʱ�䣩
A = Peak_signal_rate*Time_resolution;         % ʱ϶��ƽ����������ֵ    %A = N/(Tau*sqrt(2*pi));
Tau = P_w/sqrt(8*log(2));                     % ��˹����Ĳ���tau
d = L;  % �����dȡ����˫�̷���ʱ��
data_oringe_waveform = A*exp( (-1/(2*Tau*Tau)) * (t - d).^2); % ����ĸ�˹�����źŲ���

end