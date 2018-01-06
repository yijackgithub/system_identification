% This file is used to preprocess the measured data in excel and save them as .mat data.
clc;clear;close all;
%% load data from excel
filename = 'SweptFrequenSignal1228.xlsx';
range = 'A2:A25000';
[num,txt,raw] =  xlsread(filename,range);
%% initial data
index = zeros(length(txt),3);
leng = zeros(length(txt),4);
time_num = zeros(length(txt),1);
angle_num = zeros(length(txt),1);
velocity_num = zeros(length(txt),1);
current_num = zeros(length(txt),1);
%% determine the indexs of all semicolons
for i = 1:length(txt)
index(i,:) = strfind(txt{i,1}, ';'); % semicolon index
leng(i,1) = index(i,1)-1; % length of time string
leng(i,2) = index(i,2)-index(i,1)-1; % length of angle string
leng(i,3) = index(i,3)-index(i,2)-1; % length of current string
leng(i,4) = length(txt{i,1})-index(i,3); % length of velocity string
end
%% read time, angle, velocity, and current data
for i = 1:length(txt)
    a = txt{i,1};
    time_str = a(1:leng(i,1)); % time string
    time_num(i) = str2double(time_str); % convert string to number
    angle_str = a(index(i,1)+1:index(i,1)+leng(i,2)); % angle string
    angle_num(i) = str2double(angle_str); % convert string to number
    velocity_str = a(index(i,2)+1:index(i,2)+leng(i,3)); % current string
    velocity_num(i) = str2double(velocity_str); % convert string to number
    current_str = a(index(i,3)+1:index(i,3)+leng(i,4)); % velocity string
    current_num(i) = str2double(current_str); % convert string to number
end
time = 0.002*(1:length(txt));
current_num = current_num/1000;
angle_num = angle_num/1000;
velocity_num = velocity_num/1000;

%% plot data
figure(1);
set(gcf,'Position',[50 50 900 400]);
plot(time,current_num,'b'); hold on;
plot(time,angle_num,'r'); hold on;
plot(time,velocity_num,'g'); grid on;
set(gca,'FontSize',12);
legend('Current','Angle','Velocity');
xlabel('Time');
ylabel('Magnitude');
xlim([0 50]);
%% save data with .mat format
mea_data = [time',angle_num,velocity_num,current_num];
save measure mea_data

