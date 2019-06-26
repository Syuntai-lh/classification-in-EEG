function [ WPE_EEGdata ] = WPE_obtain( EEGdata,n )
% WPE_obtain ����������ȡEEG�źŵ�С������
WPE_EEGdata = zeros(size(EEGdata,3),size(EEGdata,1));
E = zeros(1,2^n); % 2^n,�˲�����С���ֽ�����й�
P = zeros(1,2^n); % 2^n,�˲�����С���ֽ�����й�
for i = 1:size(EEGdata,3)
    for j = 1:16 % ��ʾ��16ͨ�����Ե��ź�
        sample = EEGdata(:,:,i); % ��ȡ���ǵ�i������
        t = sample(j,:);
        t = t';
        wpt = wpdec(t,4,'haar'); % С�����ֽ⣬4�ǲ���������HaarС���ֽ⣬�����ɸ�
        for k = 1:2^4 % 4��ֽ⣬16��ϵ��
            E(k) = sum(abs(wprcoef(wpt,[4,k-1])).^2); % �������
        end
        for q = 1:length(E)
            P(q)= E(q)/(sum(E));
        end
        WPE_EEGdata(i,j) = -sum(P.*log(P)); % �صĶ���ʽ      
    end   
end

end

