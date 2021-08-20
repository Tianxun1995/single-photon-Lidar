function [Sum_histogram,Sum_0]=fun_simulation_core_universal(Poisson_PDF_total,time_channel_amount,count,T_jump)
%���Ӽ���������ģ��������Ͷഥ��ͨ�ã����ع��Ӽ����ֲ�


%***�ݴ���ƣ�����ۼƴ���count��ʱ϶�ܸ���time_channel_amount�ĳ˻����󣬻�����ڴ�������Կ���
if (time_channel_amount*count>300000000)
    volume = time_channel_amount*count
    error('��ע�⡿���������Ԫ�ش���3e8����������ʱ϶��Ȼ��߼����ۼƴ���');
end

% �����վ������ڴ洢ÿ�������ۼƵõ��Ĺ��Ӽ���ʱ���
Sum = zeros(count,time_channel_amount);

%���ؿ��޷������
for count1 = 1:count
    j = 1;
    pre_random = rand([1,time_channel_amount]); % Ϊ�˼��ٷ��������������ɺ����ĵ��ô�����Ԥ������time_channel_amount��0-1֮��������

    while j <= time_channel_amount;
        if (pre_random(j) >= Poisson_PDF_total(j) )
            j = j + 1; % �����������ڵ�����ʱ϶j�������Ӽ���ʱ����ĸ��ʣ�����������������һ��ʱ϶
        else
            % ��������С����ʱ϶j�������Ӽ���ʱ����ĸ��ʣ�����Ϊ���ʱ϶�����˹��Ӽ���������ʱ϶�ļ���ֵ+1�������ܵ�����ʱ��Ӱ�죬��Ҫ��ԾT_jump��ʱ϶��
            Sum(count1,j) = 1;
            j = j + T_jump;
        end
    end
end

% ��count���ۼƵõ��Ĺ��Ӽ���ʱ����������еķ�����ͣ��õ�TCSPCֱ��ͼ����Sum_histogram
Sum_histogram = sum(Sum);

%*********�ݴ���ƣ�����ۼƴ���ֻ��1�Σ�ֱ�ӷ���Sum����ĵ�һ�У�����Ҫ�����
Sum_0 = Sum(1,:);
if count == 1    
    Sum_histogram = Sum_0;
end