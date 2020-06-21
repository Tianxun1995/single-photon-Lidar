function [Sum_picture,Sum_0]=fun_simulation_core_universal(Poisson_PDF_total,count,T_jump)
%���Ӽ���������ģ��������Ͷഥ��ͨ�ã����ع��Ӽ����ֲ�

%��ȡʱ϶����time_channel_amount
time_channel_amount = length(Poisson_PDF_total);

%***�ݴ���ƣ�����ۼƴ���count��ʱ϶����time_channel_amount�ĳ˻����󣬻�����ڴ�������Կ���
if (time_channel_amount*count>300020000)
    volume = time_channel_amount*count
    error('��ע�⡿���������Ԫ�ش���3e8�����Լ��ٷֱ��ʻ����ۼƴ���');
end

time_channel_amount = length(Poisson_PDF_total);
Sum = zeros(count,time_channel_amount);

%���ؿ��޷������
cmp_PDF = Poisson_PDF_total * 1e9;
for count1 = 1:count
    j = 1;
    pre_random = rand([1,time_channel_amount]);
    pre_random = pre_random*1e9;
    while j <= time_channel_amount;
        if (pre_random(j) >= cmp_PDF(j) )
            j = j + 1;
        else
            Sum(count1,j) = 1;
            j = j + T_jump;
        end
    end
end

%*********�ݴ���ƣ�����ۼƴ���ֻ��1�Σ�����Sum_0
Sum_picture = sum(Sum);
Sum_0 = Sum(1,:);
if count == 1
    Sum_picture = Sum_0;
end