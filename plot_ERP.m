%% Name: plot_ERP.m
%% Description: a function for visualizing ERP
%% Author: Yao Yipeng
%% Contact: darianyao@gmail.com
%% Date: 2023,12,9
function plot_ERP()
try
    %% initialization
    eeglab;
    clc;
    clear all;
    close all;
    commandwindow;
    
    %% load data
    load('D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\ERP_analysis\group_A_ERP\Group_level_ERP.mat');
    
    %% combine all conditions
    % ===================================ERP===================================
    numSub = [1:20];
    Cz = 12; % channel number
    figure;
    mean_data = squeeze(mean(EEG_avg(numSub,Cz,:),1));
    plot(EEG.times, mean_data,'r','linewidth', 0.8); % 'r'=red
    set(gca,'YDir','reverse');     % reverse y axis
    axis([-1000 2000 -10 10]);  %% define the region to display
    % xlim([-500 1000]);  %% define the region of X axis
    % ylim([-15 10]); %% define the region of Y axis
    title(' ERP at Cz-reference','fontsize',16); %% specify the figure name
    xlabel('Latency (ms)','fontsize',16); %% name of X axis
    ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
    
    %% ================traverse all electrode channels=========================
    Roi_condV  = [1 2 3];
    Roi_condP  = [5 6];
    Roi_condVP = [7 8 9 10 11 12];
    Roi_condN  = [4];
    Roi_condAll = [1 2 3 4 5 6 7 8 9 10 11 12];
    show_conds = 3; % 1 = V; 2 = P; 3 = VP; 4 = all
    if show_conds == 1
        Roi_condTemp = Roi_condV;
    elseif show_conds == 2
        Roi_condTemp = Roi_condP;
    elseif show_conds == 3
        Roi_condTemp = Roi_condVP;
    elseif show_conds == 4
        Roi_condTemp = Roi_condAll;
    end
    for iChan = 1: EEG.nbchan
        data_conV  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condV,iChan,:),1),2));
        data_conP  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condP ,iChan,:),1),2));
        data_conVP = squeeze(mean(mean(EEG_avg_cond(:,Roi_condVP,iChan,:),1),2));
        data_conN  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condN,iChan,:),1),2));
        figure
        hold on
        plot(EEG.times, data_conV,'Color',[1 0 0],'linewidth', 1.2);
        plot(EEG.times, data_conP,'Color',[0 1 0],'linewidth', 1.2);
        plot(EEG.times, data_conVP,'Color',[0 0 1],'linewidth', 1.2);
        plot(EEG.times, data_conN,'Color',[0.8 0.8 0.8],'linewidth', 1.2);
        set(gca,'YDir','reverse');
        axis([-1000 3000 -8 8]);  %% define the region to display
        %xlim([-500 1000]);  %% define the region of X axis
        % ylim([-15 10]); %% define the region of Y axis
        title(['Group-level at ',EEG.chanlocs(iChan).labels],'fontsize',16); %% specify the figure name
        xlabel('Latency (ms)','fontsize',16); %% name of X axis
        ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
        legend('Vision','Pain','Vision-Pain','Null')
        hold off
    end
    %% test N1 component 
    Roi_condV  = [1 2 3];
    Roi_condP  = [5 6];
    Roi_condVP = [7 8 9 10 11 12];
    % vision
    figure;
    hold on
    data_Vcz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condV,12,:),1),2));
    data_Voz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condV,30,:),1),2));
    plot(EEG.times, data_Vcz, 'Color',[1 0 0],'linewidth', 1.2);
    plot(EEG.times, data_Voz, 'Color',[0 1 0],'linewidth', 1.2);
    set(gca,'YDir','reverse');
    axis([-1000 3000 -8 8]);  %% define the region to display
    title(['Group-level ERP '],'fontsize',16); %% specify the figure name
    xlabel('Latency (ms)','fontsize',16); %% name of X axis
    ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
    legend('ERP under V at Cz','ERP under V at Oz'); % low pain
    hold off
   % pain
   figure;
   hold on
   data_Pcz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condP,12,:),1),2));
   data_Poz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condP,30,:),1),2));
   plot(EEG.times, data_Pcz, 'Color',[1 0 0],'linewidth', 1.2);
   plot(EEG.times, data_Poz, 'Color',[0 1 0],'linewidth', 1.2);
   set(gca,'YDir','reverse');
   axis([-1000 3000 -8 8]);  %% define the region to display
   title(['Group-level ERP '],'fontsize',16); %% specify the figure name
   xlabel('Latency (ms)','fontsize',16); %% name of X axis
   ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
   legend('ERP under P at Cz','ERP under P at Oz'); % low pain
   hold off
   % vision-pain
   figure;
   hold on
   data_VPcz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condVP,12,:),1),2));
   data_VPoz  = squeeze(mean(mean(EEG_avg_cond(:,Roi_condVP,30,:),1),2));
   plot(EEG.times, data_VPcz, 'Color',[1 0 0],'linewidth', 1.2);
   plot(EEG.times, data_VPoz, 'Color',[0 1 0],'linewidth', 1.2);
   set(gca,'YDir','reverse');
   axis([-1000 3000 -8 8]);  %% define the region to display
   title(['Group-level ERP '],'fontsize',16); %% specify the figure name
   xlabel('Latency (ms)','fontsize',16); %% name of X axis
   ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
   legend('ERP under VP at Cz','ERP under VP at Oz'); % low pain
   hold off
   
    %% ===================================scalp map across different conditions===================================
    % search peak time point with group-level analysis results (dominant peaks on waveforms)
    N1_peak = 115; N2_peak = 257; P2_peak = 395; 
    % define componets intervals [peak-15 peak+15]
    N1_interval = find((EEG.times>=(N1_peak-25))&(EEG.times<=(N1_peak+25))); 
    N2_interval = find((EEG.times>=(N2_peak-25))&(EEG.times<=(N2_peak+25))); 
    P2_interval = find((EEG.times>=(P2_peak-25))&(EEG.times<=(P2_peak+25))); 
    
    % plot   
    show_conds = 3; % 1 for vision; 2 for pain; 3 for vision-pain
    if show_conds == 1
        figure;
        % vision
        subplot(1,3,1);
        N1_Vamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[1 2 3],:,N1_interval),1),2),4));
        topoplot(N1_Vamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N1 Amplitude under Vision','fontsize',16); %% N1 scalp map (group-level)
        colorbar;
        % pain
        subplot(1,3,2);
        N1_Pamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[5 6],:,N1_interval),1),2),4));
        topoplot(N1_Pamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N1 Amplitude under Pain','fontsize',16); %% N1 scalp map (group-level)
        colorbar;
        % vision - pain
        subplot(1,3,3);
        N1_Pamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[7 8 9 10 11 12],:,N1_interval),1),2),4));
        topoplot(N1_Pamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N1 Amplitude under Vision-Pain','fontsize',16); %% N1 scalp map (group-level)
        colorbar;
    elseif show_conds == 2
        figure
        % vision
        subplot(1,3,1);
        N2_Vamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[1 2 3 4],:,N2_interval),1),2),4));
        topoplot(N2_Vamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N2 Amplitude under Vision','fontsize',16); %% N2 scalp map (group-level)
        colorbar;
        % pain
        subplot(1,3,2);
        N2_Pamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[5 6],:,N2_interval),1),2),4));
        topoplot(N2_Pamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N2 Amplitude under Pain','fontsize',16); %% N2 scalp map (group-level)
        colorbar;
        % vision-pain
        subplot(1,3,3);
        N2_VPamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[7 8 9 10 11 12],:,N2_interval),1),2),4));
        topoplot(N2_VPamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('N2 Amplitude under Vision-Pain','fontsize',16); %% N2 scalp map (group-level)
        colorbar;
    elseif show_conds == 3
        figure;
        % vision
        subplot(1,3,1);
        P2_Vamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[1 2 3 4],:,P2_interval),1),2),4));
        topoplot(P2_Vamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('P2 Amplitude under Vision','fontsize',16); %% P2 scalp map (group-level)
        colorbar;
        % pain
        subplot(1,3,2);
        P2_Pamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[5 6],:,P2_interval),1),2),4));
        topoplot(P2_Pamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('P2 Amplitude under Pain','fontsize',16); %% P2 scalp map (group-level)
        colorbar;
        % vision-pain
        subplot(1,3,3);
        P2_VPamp = squeeze(mean(mean(mean(EEG_avg_cond(:,[7 8 9 10 11 12],:,P2_interval),1),2),4));
        topoplot(P2_VPamp,EEG.chanlocs,'maplimits',[-4 4]);
        title('P2 Amplitude under Vision-Pain','fontsize',16); %% P2 scalp map (group-level)
        colorbar;
    end
        %% ===================================time series of scalp maps===================================
        % 定义显示地形图的时间窗间隔
        time_interval = [0:100:1000]; %% specify the time intervals to display (to be changed)
        figure;
        condVC = [1 2 3 4];
        condPN = [5 6];
        condVP = [7 8 9 10 11 12];
        for iFig = 1:length(time_interval)
            latency_range = [time_interval(iFig) time_interval(iFig)+50]; %% lower and upper limits
            latency_idx = find((EEG.times>=latency_range(1))&(EEG.times<=latency_range(2))); %% interval of the specific regions
            Amplitude_1 = squeeze(mean(mean(mean(EEG_avg_cond(:,condVC,:,latency_idx),3),2),1)); %% 1*channel (averaged across subjects and interval)
            Amplitude_2 = squeeze(mean(mean(mean(EEG_avg_cond(:,condPN,:,latency_idx),3),2),1));
            Amplitude_3 = squeeze(mean(mean(mean(EEG_avg_cond(:,condVP,:,latency_idx),3),2),1));
            subplot(3,4,iFig);
            topoplot(Amplitude_3,EEG.chanlocs,'maplimits',[-2 2]); %% topoplot(Amplitude,EEG.chanlocs);
            fig_name = [num2str(latency_range(1)),'--',num2str(latency_range(2)),'ms']; %% specify the name of subplots
            title(fig_name,'fontsize',16); %% display the names of subplots
            colorbar;
        end
       
     %% ===================================ERP (split different conditions)===================================
     numSub = [1:20];
     Roi_chan = 12; % channel number  
     
     show_conds  = 3; % 1 = modality; 2 = pain; 3 = color; 4 = colorLp; 5 = colorHp 6 = vision only
     
     if show_conds  == 1
         % vision  
         dataV_temp  = mean(mean(EEG_avg_cond(numSub, [1 2 3], Roi_chan, :), 1),2); % vision
         mean_dataV_temp = squeeze(dataV_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % pain
         dataP_temp  = mean(mean(EEG_avg_cond(numSub, [5 6], Roi_chan, :), 1),2); % pain
         mean_dataP_temp = squeeze(dataP_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % vision-pain
         dataVP_temp = mean(mean(EEG_avg_cond(numSub, [7 8 9 10 11 12], Roi_chan, :), 1),2); % vision-pain
         mean_dataVP_temp = squeeze(dataVP_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % null
         dataNu_temp = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2); % vision-pain
         mean_dataNu_temp = squeeze(dataNu_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % plot 3 modalities
         figure;
         hold on
         plot(EEG.times, mean_dataV_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataP_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataVP_temp,'Color',[0 0 1],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataNu_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Vision','Pain','Vision-Pain','Null'); % low pain
         hold off
     elseif show_conds  == 2
         % low pain   5 7 9 11 
         dataLp_temp  = mean(mean(EEG_avg_cond(numSub, [5], Roi_chan, :), 1),2); % vision
         mean_dataLp_temp = squeeze(dataLp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % high pain  6 8 10 12
         dataHp_temp  = mean(mean(EEG_avg_cond(numSub, [6], Roi_chan, :), 1),2); % vision
         mean_dataHp_temp = squeeze(dataHp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot 2 levels
         figure;
         hold on
         plot(EEG.times, mean_dataLp_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataHp_temp,'Color',[0 0 1],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Low pain','High pain'); % low pain
         hold off
     elseif show_conds  == 3
         % red with pain      7 8
         dataRp_temp  = mean(mean(EEG_avg_cond(numSub, [7 8], Roi_chan, :), 1),2); % vision
         mean_dataRp_temp = squeeze(dataRp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % green with pain    9 10
         dataGp_temp  = mean(mean(EEG_avg_cond(numSub, [9 10], Roi_chan, :), 1),2); % vision
         mean_dataGp_temp = squeeze(dataGp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % gray with pain     11 12
         dataGYp_temp  = mean(mean(EEG_avg_cond(numSub, [11 12], Roi_chan, :), 1),2); % vision
         mean_dataGYp_temp = squeeze(dataGYp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % black with pain    5 6
         dataBp_temp  = mean(mean(EEG_avg_cond(numSub, [5 6], Roi_chan, :), 1),2); % vision
         mean_dataBp_temp = squeeze(dataBp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot 4 conditions
         figure;
         hold on         
         plot(EEG.times, mean_dataRp_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGp_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGYp_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBp_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title('ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red with pain','Green with pain','Gray with pain','Pain Only '); % low pain
         hold off
     elseif show_conds  == 4
         % red with low pain  7 
         dataRp_temp  = mean(mean(EEG_avg_cond(numSub, [7], Roi_chan, :), 1),2); % vision
         mean_dataRp_temp = squeeze(dataRp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % green with low pain    9 
         dataGp_temp  = mean(mean(EEG_avg_cond(numSub, [9], Roi_chan, :), 1),2); % vision
         mean_dataGp_temp = squeeze(dataGp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % gray with low pain     11 
         dataGYp_temp  = mean(mean(EEG_avg_cond(numSub, [11], Roi_chan, :), 1),2); % vision
         mean_dataGYp_temp = squeeze(dataGYp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % only low pain    5 
         dataBp_temp  = mean(mean(EEG_avg_cond(numSub, [5], Roi_chan, :), 1),2); % vision
         mean_dataBp_temp = squeeze(dataBp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot 4 conditions
         figure;
         hold on
         plot(EEG.times, mean_dataRp_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGp_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGYp_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBp_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title('ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red with low pain','Green with low pain','Gray with low pain','Low pain Only '); % low pain
         hold off
     elseif show_conds  == 5
         % red with high pain  8
         dataRp_temp  = mean(mean(EEG_avg_cond(numSub, [8], Roi_chan, :), 1),2); % vision
         mean_dataRp_temp = squeeze(dataRp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % green with high pain    10
         dataGp_temp  = mean(mean(EEG_avg_cond(numSub, [10], Roi_chan, :), 1),2); % vision
         mean_dataGp_temp = squeeze(dataGp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % gray with high pain     12
         dataGYp_temp  = mean(mean(EEG_avg_cond(numSub, [12], Roi_chan, :), 1),2); % vision
         mean_dataGYp_temp = squeeze(dataGYp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % only high pain    6
         dataBp_temp  = mean(mean(EEG_avg_cond(numSub, [6], Roi_chan, :), 1),2); % vision
         mean_dataBp_temp = squeeze(dataBp_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot 4 conditions
         figure;
         hold on
         plot(EEG.times, mean_dataRp_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGp_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGYp_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBp_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title('ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red with high pain','Green with high pain','Gray with high pain','High pain Only'); % low pain
         hold off
     elseif show_conds  == 6
         % red 
         dataR_temp  = mean(mean(EEG_avg_cond(numSub, [1], Roi_chan, :), 1),2); % vision
         mean_dataR_temp = squeeze(dataR_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % green 
         dataG_temp  = mean(mean(EEG_avg_cond(numSub, [2], Roi_chan, :), 1),2); % vision
         mean_dataG_temp = squeeze(dataG_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % gray 
         dataGY_temp  = mean(mean(EEG_avg_cond(numSub, [3], Roi_chan, :), 1),2); % vision
         mean_dataGY_temp = squeeze(dataGY_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % black
         dataB_temp  = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2); % vision
         mean_dataB_temp = squeeze(dataB_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot 4 conditions
         figure;
         hold on
         plot(EEG.times, mean_dataR_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataG_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGY_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataB_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title('ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red','Green','Gray','null'); % low pain
         hold off
     end
    
     % ================traverse all electrode channels=========================
     % traverse all electrode channels
     %     for iChan = 1: EEG.nbchan
     %         figure;
     %         hold on
     %         plot(EEG.times, squeeze(mean(mean(EEG_avg_cond(:, 1, iChan, :), 1) ,3)),'r','linewidth', 0.8); % 'r'= red
     %         plot(EEG.times, squeeze(mean(mean(EEG_avg_cond(:, 2, iChan, :), 1) ,3)),'b','linewidth', 0.8);  % 'b' = blue
     %         set(gca,'YDir','reverse');     % reverse y axis
     %         axis([-500 1000 -15 10]);  %% define the region to display
     %         % xlim([-500 1000]);  %% define the region of X axis
     %         % ylim([-15 10]); %% define the region of Y axis
     %         title(['Group-level at ',EEG.chanlocs(iChan).labels],'fontsize',16); %% specify the figure name%% specify the figure name
     %         xlabel('Latency (ms)','fontsize',16); %% name of X axis
     %         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
     %         legend('low pain','high pain');
     %         hold off
     %     end
     
     %% contrast ERP 
     numSub = [1:20];
     Roi_chan = 12; % channel number      
     show_conds  = 2; % 1 = pain - null; 2 = color with pain - color - null; 3 = color with low pain; 4 = color with high pain
     if show_conds  == 1
         % black
         dataB_temp  = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2); % vision
         %mean_dataB_temp = squeeze(dataB_temp);
         % lp  
         dataV_temp  = mean(mean(EEG_avg_cond(numSub, [5], Roi_chan, :), 1),2); % vision
         mean_datalp_temp = squeeze(dataV_temp) - squeeze(dataB_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         % hp
         dataP_temp  = mean(mean(EEG_avg_cond(numSub, [6], Roi_chan, :), 1),2); % pain
         mean_dataHp_temp = squeeze(dataP_temp)- squeeze(dataB_temp);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
         
         % plot
         figure;
         hold on
         plot(EEG.times, mean_datalp_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataHp_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz (P - null)','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Low pain','High pain'); % low pain
         hold off
     elseif show_conds  == 2
         % null
         dataB_temp        = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2);
         % red
         dataR_temp       = mean(mean(EEG_avg_cond(numSub, [1], Roi_chan, :), 1),2); 
         dataRP_temp      = mean(mean(EEG_avg_cond(numSub, [7 8], Roi_chan, :), 1),2); 
         mean_dataRP_temp = squeeze(dataRP_temp) - squeeze(dataR_temp) ;
         % green
         dataG_temp       = mean(mean(EEG_avg_cond(numSub, [2], Roi_chan, :), 1),2); 
         dataGP_temp      = mean(mean(EEG_avg_cond(numSub, [9 10], Roi_chan, :), 1),2);
         mean_dataGP_temp = squeeze(dataGP_temp)- squeeze(dataG_temp) ;
         % gray
         dataGy_temp       = mean(mean(EEG_avg_cond(numSub, [3], Roi_chan, :), 1),2);
         dataGyP_temp      = mean(mean(EEG_avg_cond(numSub, [11 12], Roi_chan, :), 1),2);
         mean_dataGyP_temp  = squeeze(dataGyP_temp)- squeeze(dataGy_temp) ;
         % pain 
         dataBP_temp       = mean(mean(EEG_avg_cond(numSub, [5 6], Roi_chan, :), 1),2);
         mean_dataBP_temp  = squeeze(dataBP_temp) ;
         % plot
         figure; 
         hold on
         plot(EEG.times, mean_dataRP_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGP_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGyP_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBP_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('RP-null - R-null','GP-null - G-null','GyP-null - Gy-null','Pain only - null'); % low pain
         hold off
     elseif show_conds == 3
         % red
         dataR_temp        = mean(mean(EEG_avg_cond(numSub, [1], Roi_chan, :), 1),2);
         dataRLP_temp      = mean(mean(EEG_avg_cond(numSub, [7], Roi_chan, :), 1),2);
         mean_dataRLP_temp = squeeze(dataRLP_temp) - squeeze(dataR_temp);
         % green
         dataG_temp        = mean(mean(EEG_avg_cond(numSub, [2], Roi_chan, :), 1),2);
         dataGLP_temp      = mean(mean(EEG_avg_cond(numSub, [9], Roi_chan, :), 1),2);
         mean_dataGLP_temp = squeeze(dataGLP_temp)- squeeze(dataG_temp);
         % gray
         dataGy_temp        = mean(mean(EEG_avg_cond(numSub, [3], Roi_chan, :), 1),2);
         dataGyLP_temp      = mean(mean(EEG_avg_cond(numSub, [11], Roi_chan, :), 1),2);
         mean_dataGyLP_temp  = squeeze(dataGyLP_temp)- squeeze(dataGy_temp);
         % black
         dataB_temp         = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2);
         dataBLP_temp       = mean(mean(EEG_avg_cond(numSub, [5], Roi_chan, :), 1),2);
         mean_dataBLP_temp   = squeeze(dataBLP_temp)- squeeze(dataB_temp );
         % plot
         figure;
         hold on
         plot(EEG.times, mean_dataRLP_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGLP_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGyLP_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBLP_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red with low pain - Red','Green with low pain - Green','Gray with low pain - Gray','Low pain only - Null'); % low pain
         hold off
     elseif show_conds == 4
         % red
         dataR_temp         = mean(mean(EEG_avg_cond(numSub, [1], Roi_chan, :), 1),2);
         dataRHP_temp       = mean(mean(EEG_avg_cond(numSub, [8], Roi_chan, :), 1),2);
         mean_dataRHP_temp  = squeeze(dataRHP_temp) - squeeze(dataR_temp);
         % green
         dataG_temp         = mean(mean(EEG_avg_cond(numSub, [2], Roi_chan, :), 1),2);
         dataGHP_temp       = mean(mean(EEG_avg_cond(numSub, [10], Roi_chan, :), 1),2);
         mean_dataGHP_temp  = squeeze(dataGHP_temp)- squeeze(dataG_temp);
         % gray
         dataGy_temp         = mean(mean(EEG_avg_cond(numSub, [3], Roi_chan, :), 1),2);
         dataGyHP_temp       = mean(mean(EEG_avg_cond(numSub, [12], Roi_chan, :), 1),2);
         mean_dataGyHP_temp  = squeeze(dataGyHP_temp)- squeeze(dataGy_temp);
         % black
         dataB_temp         = mean(mean(EEG_avg_cond(numSub, [4], Roi_chan, :), 1),2);
         dataBHP_temp       = mean(mean(EEG_avg_cond(numSub, [6], Roi_chan, :), 1),2);
         mean_dataBHP_temp  = squeeze(dataBHP_temp)- squeeze(dataB_temp );
         % plot
         figure;
         hold on
         plot(EEG.times, mean_dataRHP_temp,'Color',[1 0 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGHP_temp,'Color',[0 1 0],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataGyHP_temp,'Color',[0.8 0.8 0.8],'linewidth', 1.2); % 'r'= red
         plot(EEG.times, mean_dataBHP_temp,'Color',[0 0 0],'linewidth', 1.2); % 'r'= red
         
         % set parameters
         set(gca,'YDir','reverse');     % reverse y axis
         axis([-1000 2000 -8 8]);  %% define the region to display
         % xlim([-500 1000]);  %% define the region of X axis
         % ylim([-15 10]); %% define the region of Y axis
         title(' ERP at Cz','fontsize',16); %% specify the figure name
         xlabel('Latency (ms)','fontsize',16); %% name of X axis
         ylabel('Amplitude (uV)','fontsize',16);  %% name of Y axis
         legend('Red with high pain - Red','Green with high pain - Green','Gray with high pain - Gray','High pain only - Null'); % low pain
         hold off
     end
     
     %% ===================================scalp map===================================
     % find peak point trough axis
     N2_peak = 248; P2_peak = 447; %% dominant peaks on waveforms
     % define the N2 intervals [peak-10 peak+10]
     N2_interval = find((EEG.times>=(N2_peak-30))&(EEG.times<=(N2_peak+30))); %%
     %N2_interval = EEG.times((EEG.times>=(N2_peak-10))&(EEG.times<=(N2_peak+10)));
     % define the P2 intervals [peak-10 peak+10]
     P2_interval = find((EEG.times>=(P2_peak-30))&(EEG.times<=(P2_peak+30))); %%
     %P2_interval = EEG.times((EEG.times>=(P2_peak-10))&(EEG.times<=(P2_peak+10)));
     title_pool = {'red','green','blue','gray'};
     show_conds  = 4; % 1 = only lp; 2 = only hp; 3 = color; 4 = pain 
     for iCond = 1:2
         if show_conds == 1
             % N2 amplitude for each subject and each channel  sub*chan*amplitude
             N2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,iCond,:,N2_interval),4),2));
             % P2 amplitude for each subject and each channel
             P2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,iCond,:,P2_interval),4),2));
         elseif show_conds == 2
             N2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,iCond+4,:,N2_interval),4),2));
             P2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,iCond+4,:,P2_interval),4),2));
         elseif show_conds == 3
             N2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond iCond+4],:,N2_interval),4),2));
             P2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond iCond+4],:,P2_interval),4),2));
         elseif show_conds == 4
             if iCond == 1
                 N2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond iCond+1 iCond+2 iCond+3],:,N2_interval),4),2));
                 P2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond iCond+1 iCond+2 iCond+3],:,P2_interval),4),2));
             elseif iCond == 2
                 N2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond+3 iCond+4 iCond+5 iCond+6],:,N2_interval),4),2));
                 P2_amplitude = squeeze(mean(mean(EEG_avg_cond(:,[iCond+3 iCond+4 iCond+5 iCond+6],:,P2_interval),4),2));
             end
         end
         figure;
         % subplot 1
         subplot(1,2,1);
         topoplot(mean(N2_amplitude,1),EEG.chanlocs,'maplimits',[-6 6]);
         if show_conds == 1
             title(['N2 Amplitude-lp ' title_pool{iCond}],'fontsize',16); %% N2 scalp map (group-level)
         elseif show_conds == 2
             title(['N2 Amplitude-hp ' title_pool{iCond}],'fontsize',16); %% N2 scalp map (group-level)
         elseif show_conds == 3
             title(['N2 Amplitude-' title_pool{iCond}],'fontsize',16); %% N2 scalp map (group-level)
         elseif show_conds == 4
             if iCond == 1
                 title(['N2 Amplitude-' 'lp'],'fontsize',16); %% N2 scalp map (group-level)
             elseif iCond == 2
                 title(['N2 Amplitude-' 'hp'],'fontsize',16); %% N2 scalp map (group-level)
             end
         end
         colorbar;
         % subplot 2
         subplot(1,2,2);
         topoplot(mean(P2_amplitude,1),EEG.chanlocs,'maplimits',[-6 6]);
         if show_conds == 1
             title(['P2 Amplitude-lp ' title_pool{iCond}],'fontsize',16); %% P2 scalp map (group-level)
         elseif show_conds == 2
             title(['P2 Amplitude-hp ' title_pool{iCond}],'fontsize',16); %% P2 scalp map (group-level)
         elseif show_conds == 3
             title(['P2 Amplitude-' title_pool{iCond}],'fontsize',16);
         elseif show_conds == 4
             if iCond == 1
                 title(['P2 Amplitude-' 'lp'],'fontsize',16);
             elseif iCond == 2
                 title(['P2 Amplitude-' 'hp'],'fontsize',16);
             end
         end
         colorbar;
     end
     %% ===================================series of scalp mps===================================
     % 定义显示地形图的时间窗间隔
     time_interval = [100:100:500]; %% specify the time intervals to display (to be changed)
     figure;    
     for iFig = 1:length(time_interval)
         latency_range = [time_interval(iFig) time_interval(iFig)+50]; %% lower and upper limits
         latency_idx = find((EEG.times>=latency_range(1))&(EEG.times<=latency_range(2))); %% interval of the specific regions
         Amplitude = squeeze(mean(mean(EEG_avg_cond(:,:,:,latency_idx),4),2)); %% 1*channel (averaged across subjects and interval)
         subplot(3,3,iFig);
         topoplot(mean(Amplitude,1),EEG.chanlocs,'maplimits',[-6 6]); %% topoplot(Amplitude,EEG.chanlocs);
         fig_name = [num2str(latency_range(1)),'--',num2str(latency_range(2)),'ms']; %% specify the name of subplots
         title(fig_name,'fontsize',16); %% display the names of subplots
         colorbar;
     end
     
     %% difference wave
     % ===================================ERP===================================
     Cz = 13;
     dataCond_1 = mean(EEG_avg_cond(:, 1, Cz, :), 1);
     dataCond_2 = mean(EEG_avg_cond(:, 2, Cz, :), 1);
     mean_dataCond_1 = squeeze(dataCond_1);% squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3))
     mean_dataCond_2 = squeeze(dataCond_2);% squeeze(mean(mean(EEG_avg_cond(:, 2, Cz, :), 1) ,3))
     dif_21 = mean_dataCond_2 - mean_dataCond_1;
     %dif_conds = squeeze(mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3) - mean(mean(EEG_avg_cond(:, 1, Cz, :), 1) ,3));
     figure;
     hold on;
     plot(EEG.times, dif_21,'k','linewidth', 1); %% plot waveforms for different conditions
     set(gca,'YDir','reverse');  %% reverse Y axis
     axis([-1000 2000 -4 4]);  %% define the region to display
     title('Group level data at CZ','fontsize',16);
     xlabel('Latency (ms)','fontsize',16);
     ylabel('Amplitude (uV)','fontsize',16);
     legend('low pain - high pain'); 
     hold off;
      % ================traverse all electrode channels=========================
     %     for iChan = 1 : EEG.nbchan
     %         dif_conds = EEG_avg_cond(:, 1, iChan, :) - EEG_avg_cond(:, 2, iChan, :);
     %         figure;
     %         plot(EEG.times, dif_conds,'k','linewidth', 1); %% plot waveforms for different conditions
     %         set(gca,'YDir','reverse');  %% reverse Y axis
     %         axis([-500 1000 -35 25]);  %% define the region to display
     %         title('Group level data at CZ','fontsize',16);
     %         xlabel('Latency (ms)','fontsize',16);
     %         ylabel('Amplitude (uV)','fontsize',16);
     %         legend(Cond,'low pain - high pain');
     %     end
     % ===================================scalp map===================================
     % 通过在组水平图上用游标卡尺寻找峰值点
     N2_peak = 207; P2_peak = 374; %% dominant peaks on waveforms
     % define the N2 intervals [peak-10 peak+10]
     N2_interval = find((EEG.times>=197)&(EEG.times<=217)); %%
     % define the P2 intervals [peak-10 peak+10]
     P2_interval = find((EEG.times>=364)&(EEG.times<=384)); %%
     % N2 amplitude for each subject and each channel  被试*电极 的平均波幅
     N2_amplitude = squeeze(mean(dif_12(:,:,:,N2_interval),3));
     % P2 amplitude for each subject and each channel
     P2_amplitude = squeeze(mean(dif_12(:,:,:,P2_interval),3));
     figure;
     subplot(1,2,1);
     topoplot(mean(N2_amplitude,1),EEG.chanlocs,'maplimits',[-10 10]);
     title('N2 Amplitude','fontsize',16); %% N2 scalp map (group-level)
     colorbar;
     subplot(1,2,2);
     topoplot(mean(P2_amplitude,1),EEG.chanlocs,'maplimits',[-10 10]);
     title('P2 Amplitude','fontsize',16); %% P2 scalp map (group-level)
     colorbar;
     % ===================================series of scalp mps===================================
     % 定义显示地形图的时间窗间隔
     time_interval = [100:50:500]; %% specify the time intervals to display (to be changed)
     figure;    
     for iFig = 1:length(time_interval)
         latency_range = [time_interval(iFig) time_interval(iFig)+50]; %% lower and upper limits
         latency_idx = find((EEG.times>=latency_range(1))&(EEG.times<=latency_range(2))); %% interval of the specific regions
         Amplitude = squeeze(mean(mean(dif_12(:,:,:,latency_idx),4),2)); %% 1*channel (averaged across subjects and interval)
         subplot(3,3,iFig);
         topoplot(mean(Amplitude,1),EEG.chanlocs,'maplimits',[-10 10]); %% topoplot(Amplitude,EEG.chanlocs);
         fig_name = [num2str(latency_range(1)),'--',num2str(latency_range(2)),'ms']; %% specify the name of subplots
         title(fig_name,'fontsize',16); %% display the names of subplots
         colorbar;
     end
catch Me
    disp(Me.message)
end
return