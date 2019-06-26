%% ��ջ�������
clear;
clc;
close all;

%% ��ӵ�ǰ·������������
currentFolder = pwd;
addpath(genpath(currentFolder));

%% ����ԭʼ�����ݼ�������ȡ��һ��������16���ŵ���ԭʼEEG�źŽ�����ʾ
load('data\EEGdata_newdata.mat') % ���ݵ�·�����޸�
data = EEGdata_sleep(:,:,14); % AΪ���ݼ��еĵ�һ������
% ���Ƹ����ŵ���EEG�ź�
figure(1)
main_title = 'EEGdata-sleep';
suptitle(main_title);
for i = 1:size(data,1)
    sub_title = ['Channel ',num2str(i)];
    subplot(8,2,i);
    plot(data(i,:));
    title(sub_title);
end

%% ��16ͨ�����Ե��źŽ��в���С�����ֽ�(�����ѵ���)
% ��Awake���ݽ���������ȡ
% n = 4;
% WPE_awake = WPE_obtain(EEGdata_awake,n);
% ��Sleep���ݽ���������ȡ
% WPE_sleep = WPE_obtain(EEGdata_sleep,n);
%% ���������ݽ��й�һ������
load('data\awake_label.mat') 
load('data\sleep_label.mat') 
load('data\WPE_awake.mat')
load('data\WPE_sleep')

input_all = [WPE_awake;WPE_sleep];
[inputn,inputps] = mapminmax(input_all);
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
disp(['F1 =' num2str(f1)]);
disp(['Recall =' num2str(recall)]);
disp(['Accuracy =' num2str(accuracy)]);
plotconfusion(yPre',yTe')