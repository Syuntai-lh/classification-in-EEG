%% ��ջ�������
clear;
clc;
close all;
%% ��ӵ�ǰ·������������
currentFolder = pwd;
addpath(genpath(currentFolder));
%% ��ȡ��һ��������16���ŵ���ԭʼEEG�źţ�������ʾ
load('data\EEGdata_newdata.mat') %���ݵ�·�����޸�
A = EEGdata_awake(:,:,1); %AΪ���ݼ��еĵ�һ������
data = A';
len = 2048;
t1=data(1:len,1); %��1���ŵ�
t2=data(1:len,2); %��2���ŵ�
t3=data(1:len,3); %��3���ŵ�
t4=data(1:len,4); %��4���ŵ�
t5=data(1:len,5); %��5���ŵ�
t6=data(1:len,6); %��6���ŵ�
t7=data(1:len,7); %��7���ŵ�
t8=data(1:len,8); %��8���ŵ�
t9=data(1:len,9); %��9���ŵ�
t10=data(1:len,10); %��10���ŵ�
t11=data(1:len,11); %��11���ŵ�
t12=data(1:len,12); %��12���ŵ�
t13=data(1:len,13); %��13���ŵ�
t14=data(1:len,14); %��14���ŵ�
t15=data(1:len,15); %��15���ŵ�
t16=data(1:len,16); %��16���ŵ�
%% ����ԭʼ�źŵĲ���ͼ
figure(1)
subplot(8,2,1);plot(t1);title('��1���ŵ�');
subplot(8,2,2);plot(t2);title('��2���ŵ�');
subplot(8,2,3);plot(t3);title('��3���ŵ�');
subplot(8,2,4);plot(t4);title('��4���ŵ�');
subplot(8,2,5);plot(t5);title('��5���ŵ�');
subplot(8,2,6);plot(t6);title('��6���ŵ�');
subplot(8,2,7);plot(t7);title('��7���ŵ�');
subplot(8,2,8);plot(t8);title('��8���ŵ�');
subplot(8,2,9);plot(t9);title('��9���ŵ�');
subplot(8,2,10);plot(t10);title('��10���ŵ�');
subplot(8,2,11);plot(t11);title('��11���ŵ�');
subplot(8,2,12);plot(t12);title('��12���ŵ�');
subplot(8,2,13);plot(t13);title('��13���ŵ�');
subplot(8,2,14);plot(t14);title('��14���ŵ�');
subplot(8,2,15);plot(t15);title('��15���ŵ�');
subplot(8,2,16);plot(t16);title('��16���ŵ�');
%% �Ը����źŽ���С���任��16ͨ����
[c1,l1] = wavedec(t1,3,'db2');
[c2,l2] = wavedec(t2,3,'db2');
[c3,l3] = wavedec(t3,3,'db2');
[c4,l4] = wavedec(t4,3,'db2');
[c5,l5] = wavedec(t5,3,'db2');
[c6,l6] = wavedec(t6,3,'db2');
[c7,l7] = wavedec(t7,3,'db2');
[c8,l8] = wavedec(t8,3,'db2');
[c9,l9] = wavedec(t9,3,'db2');
[c10,l10] = wavedec(t10,3,'db2');
[c11,l11] = wavedec(t11,3,'db2');
[c12,l12] = wavedec(t12,3,'db2');
[c13,l13] = wavedec(t13,3,'db2');
[c14,l14] = wavedec(t14,3,'db2');
[c15,l15] = wavedec(t15,3,'db2');
[c16,l16] = wavedec(t16,3,'db2');
%% �����źž���С���任��Ĳ���ͼ��16�ŵ���
figure(2)
subplot(8,2,1);plot(c1);title('��1���ŵ�');
subplot(8,2,2);plot(c2);title('��2���ŵ�');
subplot(8,2,3);plot(c3);title('��3���ŵ�');
subplot(8,2,4);plot(c4);title('��4���ŵ�');
subplot(8,2,5);plot(c5);title('��5���ŵ�');
subplot(8,2,6);plot(c6);title('��6���ŵ�');
subplot(8,2,7);plot(c7);title('��7���ŵ�');
subplot(8,2,8);plot(c8);title('��8���ŵ�');
subplot(8,2,9);plot(c9);title('��9���ŵ�');
subplot(8,2,10);plot(c10);title('��10���ŵ�');
subplot(8,2,11);plot(c11);title('��11���ŵ�');
subplot(8,2,12);plot(c12);title('��12���ŵ�');
subplot(8,2,13);plot(c13);title('��13���ŵ�');
subplot(8,2,14);plot(c14);title('��14���ŵ�');
subplot(8,2,15);plot(c15);title('��15���ŵ�');
subplot(8,2,16);plot(c16);title('��16���ŵ�');
%% �����������������Լ���Ӧ��ǩ����ԭʼ���ݼ��������
% ��Ӧ��ǩ˵����0����awake״̬  1����sleep״̬
load('data\awake.mat') %���ݵ�·�����޸�
load('data\awake_label.mat') %���ݵ�·�����޸�
load('data\sleep.mat') %���ݵ�·�����޸�
load('data\sleep_label.mat') %���ݵ�·�����޸�
%% С���任
awake_1 = zeros(230,2055); %�����ڴ�ռ�
sleep_1 = zeros(150,2055);
% �ֱ���������ݽ���С���任
for i=1:1:230
    t = awake(i,:);
    [c,l] = wavedec(t,3,'db2');
    awake_1(i,:) = c;
end
for j=1:1:150
    q = sleep(j,:);
    [c,l] = wavedec(t,3,'db2');
    sleep_1(j,:) = c;
end
% ������С���任���������ݷֱ��ͻ�ԭ����
awake = awake_1;
sleep = sleep_1;
%% ���������ݽ��й�һ������
input_train = [awake;sleep];
[inputn,inputps] = mapminmax(input_train);
% ��һ����������ͻ�ԭ����
awake = inputn((1:230),:);
sleep = inputn((231:380),:);
%% �����źŵ�70%����������ѵ��SVM��30%���������ڲ���ģ�ͷ�������
%�����������ȷ��ʵ���������
number_1 = randperm(size(awake,1)); 
number_2 = randperm(size(sleep,1));
% ����awake״̬�µ���������
% 230*0.7=161��awake״̬��������ѵ��
% 230*0.3=69��awake״̬�������ڲ���
awake_train_label = zeros(size(awake_label,1)*0.7,size(awake_label,2));
awake_test_label = zeros(size(awake_label,1)*0.3,size(awake_label,2));
awake_train = zeros(size(awake,1)*0.7,size(awake,2));
awake_test = zeros(size(awake,1)*0.3,size(awake,2));
% ����70%��awake������ѵ����
for i=1:1:(size(awake,1)*0.7)
    awake_train(i,:) = awake(number_1(i),:);
    awake_train_label(i,1) = awake_label(number_1(i),:);
end
% ����30%��awake����(ʣ���)�����Լ�
for i=(size(awake,1)*0.7+1):1:size(awake,1)
    awake_test(i-(size(awake,1)*0.7),:) = awake(number_1(i),:); 
    awake_test_label(i-(size(awake,1)*0.7),1) = awake_label(number_1(i),:);  
end
% ����˯��״̬�µ���������
% 150*0.7=105��sleep״̬��������ѵ��
% 150*0.3=45��sleep״̬�������ڲ���
sleep_train_label = zeros(size(sleep_label,1)*0.7,size(sleep_label,2));
sleep_test_label = zeros(size(sleep_label,1)*0.3,size(sleep_label,2));
sleep_train = zeros(size(sleep,1)*0.7,size(sleep,2));
sleep_test = zeros(size(sleep,1)*0.3,size(sleep,2));
% ����70%��sleep������ѵ����
for j=1:1:size(sleep,1)*0.7
    sleep_train(j,:) = sleep(number_2(j),:);
    sleep_train_label(j,1) = sleep_label(number_2(j),:);
end
% ����30%��sleep����(ʣ���)�����Լ�
for j=(size(sleep,1)*0.7+1):1:size(sleep,1)
    sleep_test(j-(size(sleep,1)*0.7),:)= sleep(number_2(j),:);
    sleep_test_label(j-(size(sleep,1)*0.7),1) = sleep_label(number_2(j),:);
end
%% ��������
% ˵����xTr��yTr��ӦΪȫ��ѵ�����������ݡ���ǩ
% ˵����xTe��yTe��ӦΪȫ��������������ݡ���ǩ
xTr = [sleep_train;awake_train];
yTr = [sleep_train_label;awake_train_label];
xTe = [sleep_test;awake_test];
yTe = [sleep_test_label;awake_test_label];
%% ѵ��������
model = fitcsvm(xTr,yTr); % ѵ�����ݣ��õ�ģ�Ͳ���
yPre = predict(model,xTe);% ��������������ģ�ͣ��õ�Ԥ���ǩyPre
%% ʵ��������
Acc = sum(yTe == yPre)/length(yTe); 
C = confusionmat(yTe, yPre); % CΪ��������
recall = 0;
accuracy = 0;
n = length(C);
for i=1:n
    recall = recall + C(i,i)/sum(C(i,:));
    accuracy = accuracy + C(i,i)/sum(C(:,i));
end
recall = recall/n;
accuracy = accuracy/n;
f1 = 2*(recall*accuracy)/(recall+accuracy);
disp(['Acc =' num2str(Acc)]);
disp(['f1 =' num2str(f1)]);
disp(['recall =' num2str(recall)]);
disp(['accuracy =' num2str(accuracy)]);
plotconfusion(yPre',yTe')