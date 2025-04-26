%% Name: statistic.m
%% Description: a function for outputing dataset format for statistical analysis
%% Author: Yao Yipeng
%% Contact: darianyao@gmail.com
%% Date: 2023,12,9

function statistic_output()
try
    %% initialization
    %eeglab;
    clc;
    clear all;
    close all;
    commandwindow;
    
    %% load dataset
    load('D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\ERP_analysis\group_A_ERP\Group_level_ERP.mat');
    
    %% extract values for statistic analysis 
    %% time window at group level
    t_N1 = [110 170]; 
    tN1_idx = find(EEG.times>=t_N1(1) & EEG.times<=t_N1(2));
    t_N2 = [230 260]; 
    tN2_idx = find(EEG.times>=t_N2(1) & EEG.times<=t_N2(2));
    t_P2 = [360 400];
    tP2_idx = find(EEG.times>=t_P2(1) & EEG.times<=t_P2(2));
    
    Roi_chan = 12;
    num_sub  = size(EEG_avg_cond,1);
    num_cond = size(EEG_avg_cond,2);

    for iSub = 1:num_sub
        for iCond = 1: num_cond
            % N1
            N1_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,tN1_idx)),4));
            % N2
            N2_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,tN2_idx)),4));
            % P2
            P2_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,tP2_idx)),4));
            
%             N2_amp(iSub,iCond,:) = min(squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx))); 
%             P2_amp(iSub,iCond,:) = max(squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx)));
%             N2_lat(iSub,iCond,:) = find(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx) == N2_amp(iSub))+t1-1;
%             P2_lat(iSub,iCond,:) = find(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx) == P2_amp(iSub))+t1-1;
        end
    end
    % save results
    % N1
%     Results_ERPbyWinG.N1amp.Pain      = [mean(N1_amp(:,[5 7 9 11]),2),mean(N1_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWinG.N1amp.PainOnly  = [mean(N1_amp(:,5),2),mean(N1_amp(:,6),2)];
%     Results_ERPbyWinG.N1amp.Dpain     = [mean(N1_amp(:,5),2),mean(N1_amp(:,6),2)] - [mean(N1_amp(:,4),2)];
    Results_ERPbyWinG.N1amp.Modality  = [mean(N1_amp(:,1:4),2),mean(N1_amp(:,5:6),2),mean(N1_amp(:,7:12),2)];
%     Results_ERPbyWinG.N1amp.DModality = [mean(N1_amp(:,1:3),2),mean(N1_amp(:,5:6),2),mean(N1_amp(:,7:12),2)]- [mean(N1_amp(:,4),2)];
    Results_ERPbyWinG.N1amp.Color     = [mean(N1_amp(:,7:8),2),mean(N1_amp(:,9:10),2),mean(N1_amp(:,11:12),2), mean(N1_amp(:,5:6),2)];
    Results_ERPbyWinG.N1amp.D1Color    = [mean(N1_amp(:,7:8)-N1_amp(:,1),2),mean(N1_amp(:,9:10)-N1_amp(:,2),2),mean(N1_amp(:,11:12)-N1_amp(:,3),2), mean(N1_amp(:,5:6)-N1_amp(:,4),2)];
    Results_ERPbyWinG.N1amp.D2Color    = [mean(N1_amp(:,7:8)-N1_amp(:,4)-N1_amp(:,1)-N1_amp(:,4),2),...
                                          mean(N1_amp(:,9:10)-N1_amp(:,4)-N1_amp(:,2)-N1_amp(:,4),2),...
                                          mean(N1_amp(:,11:12)-N1_amp(:,4)-N1_amp(:,3)-N1_amp(:,4),2),...
                                          mean(N1_amp(:,5:6)-N1_amp(:,4)-N1_amp(:,4)-N1_amp(:,4),2)];
%     Results_ERPbyWinG.N1amp.ColorLp   = [mean(N1_amp(:,7),2),mean(N1_amp(:,9),2),mean(N1_amp(:,11),2), mean(N1_amp(:,5),2)];
%     Results_ERPbyWinG.N1amp.DColorLp  = [mean(N1_amp(:,7)-N1_amp(:,1),2),mean(N1_amp(:,9)-N1_amp(:,2),2),mean(N1_amp(:,11),2)-N1_amp(:,3), mean(N1_amp(:,5)-N1_amp(:,4),2)];    
%     Results_ERPbyWinG.N1amp.ColorHp   = [mean(N1_amp(:,8),2),mean(N1_amp(:,10),2),mean(N1_amp(:,12),2), mean(N1_amp(:,6),2)];
%     Results_ERPbyWinG.N1amp.DColorHp  = [mean(N1_amp(:,8)-N1_amp(:,1),2),mean(N1_amp(:,10)-N1_amp(:,2),2),mean(N1_amp(:,12)-N1_amp(:,3),2), mean(N1_amp(:,6)-N1_amp(:,4),2)];
    % N2
%     Results_ERPbyWinG.N2amp.Pain      = [mean(N2_amp(:,[5 7 9 11]),2),mean(N2_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWinG.N2amp.PainOnly  = [mean(N2_amp(:,5),2),mean(N2_amp(:,6),2)];
%     Results_ERPbyWinG.N2amp.DPain     = [mean(N2_amp(:,5),2),mean(N2_amp(:,6),2)]-[mean(N2_amp(:,4),2)];
    Results_ERPbyWinG.N2amp.Modality  = [mean(N2_amp(:,1:4),2),mean(N2_amp(:,5:6),2),mean(N2_amp(:,7:12),2)];
%     Results_ERPbyWinG.N2amp.DModality = [mean(N2_amp(:,1:3)-N2_amp(:,4),2),mean(N2_amp(:,5:6)-N2_amp(:,4),2),mean(N2_amp(:,7:12)-N2_amp(:,4),2)];
    Results_ERPbyWinG.N2amp.Color     = [mean(N2_amp(:,7:8),2),mean(N2_amp(:,9:10),2),mean(N2_amp(:,11:12),2), mean(N2_amp(:,5:6),2)];
    Results_ERPbyWinG.N2amp.D1Color    = [mean(N2_amp(:,7:8)-N2_amp(:,1),2),mean(N2_amp(:,9:10)-N2_amp(:,2),2),mean(N2_amp(:,11:12)-N2_amp(:,3),2), mean(N2_amp(:,5:6)-N2_amp(:,4),2)];
    Results_ERPbyWinG.N2amp.D2Color    = [mean(N2_amp(:,7:8)-N2_amp(:,4)-N2_amp(:,1)-N2_amp(:,4),2),...
                                          mean(N2_amp(:,9:10)-N2_amp(:,4)-N2_amp(:,2)-N2_amp(:,4),2),...
                                          mean(N2_amp(:,11:12)-N2_amp(:,4)-N2_amp(:,3)-N2_amp(:,4),2),...
                                          mean(N2_amp(:,5:6)-N2_amp(:,4)-N2_amp(:,4)-N2_amp(:,4),2)];
%     Results_ERPbyWinG.N2amp.ColorLp   = [mean(N2_amp(:,7),2),mean(N2_amp(:,9),2),mean(N2_amp(:,11),2), mean(N2_amp(:,5),2)];
%     Results_ERPbyWinG.N2amp.DColorLp  = [mean(N2_amp(:,7)-N2_amp(:,1),2),mean(N2_amp(:,9)-N2_amp(:,2),2),mean(N2_amp(:,11)-N2_amp(:,3),2), mean(N2_amp(:,5)-N2_amp(:,4),2)];
%     Results_ERPbyWinG.N2amp.ColorHp   = [mean(N2_amp(:,8),2),mean(N2_amp(:,10),2),mean(N2_amp(:,12),2), mean(N2_amp(:,6),2)];
%     Results_ERPbyWinG.N2amp.DColorHp  = [mean(N2_amp(:,8)-N2_amp(:,1),2),mean(N2_amp(:,10)-N2_amp(:,2),2),mean(N2_amp(:,12)-N2_amp(:,3),2), mean(N2_amp(:,6)-N2_amp(:,4),2)];
    % P2
%     Results_ERPbyWinG.P2amp.Pain      = [mean(P2_amp(:,[5 7 9 11]),2),mean(P2_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWinG.P2amp.PainOnly  = [mean(P2_amp(:,5),2),mean(P2_amp(:,6),2)];
%     Results_ERPbyWinG.P2amp.DPain     = [mean(P2_amp(:,5),2),mean(P2_amp(:,6),2)]-[mean(P2_amp(:,4),2)];
    Results_ERPbyWinG.P2amp.Modality  = [mean(P2_amp(:,1:4),2),mean(P2_amp(:,5:6),2),mean(P2_amp(:,7:12),2)];
%     Results_ERPbyWinG.P2amp.DModality = [mean(P2_amp(:,1:3),2),mean(P2_amp(:,5:6),2),mean(P2_amp(:,7:12),2)]-[mean(P2_amp(:,4),2)];
    Results_ERPbyWinG.P2amp.Color     = [mean(P2_amp(:,7:8),2),mean(P2_amp(:,9:10),2),mean(P2_amp(:,11:12),2), mean(P2_amp(:,5:6),2)];
    Results_ERPbyWinG.P2amp.D1Color   = [mean(P2_amp(:,7:8)-P2_amp(:,1),2),mean(P2_amp(:,9:10)-P2_amp(:,2),2),mean(P2_amp(:,11:12)-P2_amp(:,3),2), mean(P2_amp(:,5:6)-P2_amp(:,4),2)];
    Results_ERPbyWinG.P2amp.D2Color   = [mean(P2_amp(:,7:8)-P2_amp(:,4)-P2_amp(:,1)-P2_amp(:,4),2),...
                                         mean(P2_amp(:,9:10)-P2_amp(:,4)-P2_amp(:,2)-P2_amp(:,4),2),...
                                         mean(P2_amp(:,11:12)-P2_amp(:,4)-P2_amp(:,3)-P2_amp(:,4),2),...
                                         mean(P2_amp(:,5:6)-P2_amp(:,4)-P2_amp(:,4)-P2_amp(:,4),2)];
%     Results_ERPbyWinG.P2amp.ColorLp   = [mean(P2_amp(:,7),2),mean(P2_amp(:,9),2),mean(P2_amp(:,11),2), mean(P2_amp(:,5),2)];
%     Results_ERPbyWinG.P2amp.DColorLp  = [mean(P2_amp(:,7)-P2_amp(:,1),2),mean(P2_amp(:,9)-P2_amp(:,2),2),mean(P2_amp(:,11)-P2_amp(:,3),2), mean(P2_amp(:,5)-P2_amp(:,4),2)];
%     Results_ERPbyWinG.P2amp.ColorHp   = [mean(P2_amp(:,8),2),mean(P2_amp(:,10),2),mean(P2_amp(:,12),2), mean(P2_amp(:,6),2)];
%     Results_ERPbyWinG.P2amp.DColorHp  = [mean(P2_amp(:,8)-P2_amp(:,1),2),mean(P2_amp(:,10)-P2_amp(:,2),2),mean(P2_amp(:,12)-P2_amp(:,3),2), mean(P2_amp(:,6)-P2_amp(:,4),2)];
    save('Results_ERPbyWinG.mat','Results_ERPbyWinG')
    
    %% time window individually
    Roi_chan = 12;
    num_sub  = size(EEG_avg_cond,1);
    num_cond = size(EEG_avg_cond,2);
    ts = 75; tp = 125;
    tN1_idx = find(EEG.times>=ts & EEG.times<=tp);
    t1 = 150;t2 = 500; 
    tN2p2_idx = find(EEG.times>=t1 & EEG.times<=t2);
    for iSub = 1:num_sub
        for iCond = 1: num_cond
            % N1
            data_tstp   = squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,tN1_idx));
            N1_peak     = min(data_tstp);
            N1_peak_idx = find(data_tstp == N1_peak);
            N1_interval = find(EEG.times>=(N1_peak_idx+t1)-25 & EEG.times<=(N1_peak_idx+t1)+25);
            N1_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,N1_interval)),4));
            % N2
            data_t1t2 = squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,tN2p2_idx));
            N2_peak  = min(data_t1t2);  
            N2_peak_idx = find(data_t1t2 == N2_peak);
            N2_interval = find(EEG.times>=(N2_peak_idx+t1)-25 & EEG.times<=(N2_peak_idx+t1)+25);
            N2_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,N2_interval)),4));
            % P2
            P2_peak  = max(data_t1t2);
            P2_peak_idx = find(data_t1t2 == P2_peak);
            P2_interval = find(EEG.times>=(P2_peak_idx+t1)-25 & EEG.times<=(P2_peak_idx+t1)+25);
            P2_amp(iSub,iCond,:) = squeeze(mean(double(EEG_avg_cond(iSub,iCond,Roi_chan,P2_interval)),4));
            
%             N2_amp(iSub,iCond,:) = min(squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx))); 
%             P2_amp(iSub,iCond,:) = max(squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx)));
%             N2_lat(iSub,iCond,:) = find(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx) == N2_amp(iSub))+t1-1;
%             P2_lat(iSub,iCond,:) = find(EEG_avg_cond(iSub,iCond,Roi_chan,t1_idx) == P2_amp(iSub))+t1-1;
        end
    end
    % save results
    % N1
    Results_ERPbyWin.N1amp.Pain      = [mean(N1_amp(:,[5 7 9 11]),2),mean(N1_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWin.N1amp.PainOnly  = [mean(N1_amp(:,5),2),mean(N1_amp(:,6),2)];
    Results_ERPbyWin.N1amp.Dpain     = [mean(N1_amp(:,5),2),mean(N1_amp(:,6),2)] - [mean(N1_amp(:,4),2)];
    Results_ERPbyWin.N1amp.Modality  = [mean(N1_amp(:,1:4),2),mean(N1_amp(:,5:6),2),mean(N1_amp(:,7:12),2)];
    Results_ERPbyWin.N1amp.DModality = [mean(N1_amp(:,1:3),2),mean(N1_amp(:,5:6),2),mean(N1_amp(:,7:12),2)]- [mean(N1_amp(:,4),2)];
    Results_ERPbyWin.N1amp.Color     = [mean(N1_amp(:,7:8),2),mean(N1_amp(:,9:10),2),mean(N1_amp(:,11:12),2), mean(N1_amp(:,5:6),2)];
    Results_ERPbyWin.N1amp.DColor    = [mean(N1_amp(:,7:8)-N1_amp(:,1),2),mean(N1_amp(:,9:10)-N1_amp(:,2),2),mean(N1_amp(:,11:12)-N1_amp(:,3),2), mean(N1_amp(:,5:6)-N1_amp(:,4),2)];
    Results_ERPbyWin.N1amp.ColorLp   = [mean(N1_amp(:,7),2),mean(N1_amp(:,9),2),mean(N1_amp(:,11),2), mean(N1_amp(:,5),2)];
    Results_ERPbyWin.N1amp.DColorLp  = [mean(N1_amp(:,7)-N1_amp(:,1),2),mean(N1_amp(:,9)-N1_amp(:,2),2),mean(N1_amp(:,11),2)-N1_amp(:,3), mean(N1_amp(:,5)-N1_amp(:,4),2)];    
    Results_ERPbyWin.N1amp.ColorHp   = [mean(N1_amp(:,8),2),mean(N1_amp(:,10),2),mean(N1_amp(:,12),2), mean(N1_amp(:,6),2)];
    Results_ERPbyWin.N1amp.DColorHp  = [mean(N1_amp(:,8)-N1_amp(:,1),2),mean(N1_amp(:,10)-N1_amp(:,2),2),mean(N1_amp(:,12)-N1_amp(:,3),2), mean(N1_amp(:,6)-N1_amp(:,4),2)];
    % N2
    Results_ERPbyWin.N2amp.Pain      = [mean(N2_amp(:,[5 7 9 11]),2),mean(N2_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWin.N2amp.PainOnly  = [mean(N2_amp(:,5),2),mean(N2_amp(:,6),2)];
    Results_ERPbyWin.N2amp.DPain     = [mean(N2_amp(:,5),2),mean(N2_amp(:,6),2)]-[mean(N2_amp(:,4),2)];
    Results_ERPbyWin.N2amp.Modality  = [mean(N2_amp(:,1:4),2),mean(N2_amp(:,5:6),2),mean(N2_amp(:,7:12),2)];
    Results_ERPbyWin.N2amp.DModality = [mean(N2_amp(:,1:3)-N2_amp(:,4),2),mean(N2_amp(:,5:6)-N2_amp(:,4),2),mean(N2_amp(:,7:12)-N2_amp(:,4),2)];
    Results_ERPbyWin.N2amp.Color     = [mean(N2_amp(:,7:8),2),mean(N2_amp(:,9:10),2),mean(N2_amp(:,11:12),2), mean(N2_amp(:,5:6),2)];
    Results_ERPbyWin.N2amp.DColor    = [mean(N2_amp(:,7:8)-N2_amp(:,1),2),mean(N2_amp(:,9:10)-N2_amp(:,2),2),mean(N2_amp(:,11:12)-N2_amp(:,3),2), mean(N2_amp(:,5:6)-N2_amp(:,4),2)];
    Results_ERPbyWin.N2amp.ColorLp   = [mean(N2_amp(:,7),2),mean(N2_amp(:,9),2),mean(N2_amp(:,11),2), mean(N2_amp(:,5),2)];
    Results_ERPbyWin.N2amp.DColorLp  = [mean(N2_amp(:,7)-N2_amp(:,1),2),mean(N2_amp(:,9)-N2_amp(:,2),2),mean(N2_amp(:,11)-N2_amp(:,3),2), mean(N2_amp(:,5)-N2_amp(:,4),2)];
    Results_ERPbyWin.N2amp.ColorHp   = [mean(N2_amp(:,8),2),mean(N2_amp(:,10),2),mean(N2_amp(:,12),2), mean(N2_amp(:,6),2)];
    Results_ERPbyWin.N2amp.DColorHp  = [mean(N2_amp(:,8)-N2_amp(:,1),2),mean(N2_amp(:,10)-N2_amp(:,2),2),mean(N2_amp(:,12)-N2_amp(:,3),2), mean(N2_amp(:,6)-N2_amp(:,4),2)];
    % P2
    Results_ERPbyWin.P2amp.Pain      = [mean(P2_amp(:,[5 7 9 11]),2),mean(P2_amp(:,[6 8 10 12]),2)];
    Results_ERPbyWin.P2amp.PainOnly  = [mean(P2_amp(:,5),2),mean(P2_amp(:,6),2)];
    Results_ERPbyWin.P2amp.DPain     = [mean(P2_amp(:,5),2),mean(P2_amp(:,6),2)]-[mean(P2_amp(:,4),2)];
    Results_ERPbyWin.P2amp.Modality  = [mean(P2_amp(:,1:4),2),mean(P2_amp(:,5:6),2),mean(P2_amp(:,7:12),2)];
    Results_ERPbyWin.P2amp.DModality = [mean(P2_amp(:,1:3),2),mean(P2_amp(:,5:6),2),mean(P2_amp(:,7:12),2)]-[mean(P2_amp(:,4),2)];
    Results_ERPbyWin.P2amp.Color     = [mean(P2_amp(:,7:8),2),mean(P2_amp(:,9:10),2),mean(P2_amp(:,11:12),2), mean(P2_amp(:,5:6),2)];
    Results_ERPbyWin.P2amp.DColor    = [mean(P2_amp(:,7:8)-P2_amp(:,1),2),mean(P2_amp(:,9:10)-P2_amp(:,2),2),mean(P2_amp(:,11:12)-P2_amp(:,3),2), mean(P2_amp(:,5:6)-P2_amp(:,4),2)];
    Results_ERPbyWin.P2amp.ColorLp   = [mean(P2_amp(:,7),2),mean(P2_amp(:,9),2),mean(P2_amp(:,11),2), mean(P2_amp(:,5),2)];
    Results_ERPbyWin.P2amp.DColorLp  = [mean(P2_amp(:,7)-P2_amp(:,1),2),mean(P2_amp(:,9)-P2_amp(:,2),2),mean(P2_amp(:,11)-P2_amp(:,3),2), mean(P2_amp(:,5)-P2_amp(:,4),2)];
    Results_ERPbyWin.P2amp.ColorHp   = [mean(P2_amp(:,8),2),mean(P2_amp(:,10),2),mean(P2_amp(:,12),2), mean(P2_amp(:,6),2)];
    Results_ERPbyWin.P2amp.DColorHp  = [mean(P2_amp(:,8)-P2_amp(:,1),2),mean(P2_amp(:,10)-P2_amp(:,2),2),mean(P2_amp(:,12)-P2_amp(:,3),2), mean(P2_amp(:,6)-P2_amp(:,4),2)];
    save('Results_ERPbyWin.mat','Results_ERPbyWin')
    
    %% peak to peak amplitude individually
    Roi_chan = 12;
    num_sub  = size(EEG_avg_cond,1);
    num_cond = size(EEG_avg_cond,2); 
    baseline_pnt = 1000;% ms
    for iSub = 1:num_sub  
        for iCond = 1: num_cond
            figure;
            hold on;
            set(gca,'YDir','reverse');           
            data_t1t2 = squeeze(EEG_avg_cond(iSub,iCond,Roi_chan,:)); % sub*cond*chan*time
            plot(EEG.times,squeeze(mean(EEG_avg_cond(:,iCond,Roi_chan,:),1)),'k');% group average            
            plot(EEG.times,data_t1t2,'r');% single subject
                       
            [x,y] = ginput(2); % please click the peak point within the red line for single suject
            N2_amp = min(double(data_t1t2(baseline_pnt+1+round(x(1)-20:x(1)+20)))); % search the min value during the time point
            N2_lat = find(data_t1t2==N2_amp) - baseline_pnt;
            P2_amp = max(double(data_t1t2(baseline_pnt+1+round(x(2)-20:x(2)+20)))); % search the max value during the time point
            P2_lat = find(data_t1t2==P2_amp) - baseline_pnt;
            Amp_N2(iSub,iCond,:) = N2_amp;
            Amp_P2(iSub,iCond,:) = P2_amp;
            Lat_N2(iSub,iCond,:) = N2_lat;
            Lat_P2(iSub,iCond,:) = P2_lat;
            close;
        end
        disp(['The subject ' sprintf('%02d',iSub) ' has Done'])
    end
    % spss format
    Results_ERPbyPeak.N2amp_pain     = [mean(Amp_N2(:,[5 7 9 11]),2),mean(Amp_N2(:,[6 8 10 12]),2)];
    Results_ERPbyPeak.N2amp_modality = [mean(Amp_N2(:,1:4),2),mean(Amp_N2(:,5:6),2),mean(Amp_N2(:,7:12),2)];
    Results_ERPbyPeak.N2amp_interC   = [mean(Amp_N2(:,7:8),2),mean(Amp_N2(:,9:10),2),mean(Amp_N2(:,11:12),2), mean(Amp_N2(:,5:6),2)];
    Results_ERPbyPeak.N2amp_interLp  = [mean(Amp_N2(:,7),2),mean(Amp_N2(:,9),2),mean(Amp_N2(:,11),2), mean(Amp_N2(:,5),2)];
    Results_ERPbyPeak.N2amp_interHp  = [mean(Amp_N2(:,8),2),mean(Amp_N2(:,10),2),mean(Amp_N2(:,12),2), mean(Amp_N2(:,6),2)];
    
    Results_ERPbyPeak.P2amp_pain     = [mean(Amp_P2(:,[5 7 9 11]),2),mean(Amp_P2(:,[6 8 10 12]),2)];
    Results_ERPbyPeak.P2amp_modality = [mean(Amp_P2(:,1:4),2),mean(Amp_P2(:,5:6),2),mean(Amp_P2(:,7:12),2)];
    Results_ERPbyPeak.P2amp_interC   = [mean(Amp_P2(:,7:8),2),mean(Amp_P2(:,9:10),2),mean(Amp_P2(:,11:12),2), mean(Amp_P2(:,5:6),2)];
    Results_ERPbyPeak.P2amp_interLp  = [mean(Amp_P2(:,7),2),mean(Amp_P2(:,9),2),mean(Amp_P2(:,11),2), mean(Amp_P2(:,5),2)];
    Results_ERPbyPeak.P2amp_interHp  = [mean(Amp_P2(:,8),2),mean(Amp_P2(:,10),2),mean(Amp_P2(:,12),2), mean(Amp_P2(:,6),2)];
    
    save('Results_ERPbyPeak.mat','Results_ERPbyPeak')

    %%  沿着时间轴进行逐点比较，其实也可以一次选择多个通道进行平均以后比较(即看所有时间点下对应的差异值，固定通道看时间点)
    dir_path = 'D:\Docu\MC_Course\MC_EEG1\MC_day2\Example_data';
    mkdir([dir_path,filesep,'ERP_fig']);
    erp_path = [dir_path,filesep,'ERP_fig'];
    
    for chan_roi = 1:length(EEG.chanlocs)  %外部循环用来看不同电极点
        data_test = squeeze(mean(EEG_avg_cond(:,:,chan_roi,:),3));
        %     data_test = squeeze(EEG_avg_cond(:,:,Cz,:)); %% select the data at Cz, data_test: subj*cond*time
        %     data_test = squeeze(mean(EEG_avg_cond(:,:,Cz,:),3));
        for iSub = 1:size(data_test,3)  %子循环在算固定电极点时，挨个时间点算两个条件的下差异
            data_1 = squeeze(data_test(:,3,iSub)); %% select condition L3 for each time point 出来一列数据，每个被试一个数据
            data_2 = squeeze(data_test(:,4,iSub)); %% select condition L4 for each time point
            [h,p,ci,stats] = ttest(data_1,data_2); %% ttest comparison 出来该时间点下两组被试的平均波幅的差异值，一个时间点一个p值，
            %中括号里的顺序不能变
            P_ttest(iSub) = p; %% save the p value from ttest
            T_ttest(iSub) = stats.tstat;
        end
        figure;
        subplot(2,1,1);
        % 先画条件3
        plot(EEG.times,squeeze(mean(data_test(:,3,:),1)),'b'); %% plot the average waveform for Condition L3
        hold on;
        % 再画条件4
        plot(EEG.times,squeeze(mean(data_test(:,4,:),1)),'r'); %% plot the average waveform for Condition L4
        subplot(2,1,2);
        % 再画条件3和4的比较；
        plot(EEG.times,P_ttest); ylim([0 0.05]); %%plot the p values from ttest
        title(['标题',EEG.chanlocs(chan_roi).labels]);
        % 保存图片
        print(gcf,'-dtiff',[erp_path,filesep,'ERP-fig-at-the-channel',EEG.chanlocs(chan_roi).labels,'.tif']);
    end
    close all;
    
    %% 进行逐个通道比较（即固定一个时间段，同时看所有电极上3和4两个条件间下的所有被试平均数上的差异）    
    test_idx = find((EEG.times>=197)&(EEG.times<=217)); %% define the intervals
    data_test = squeeze(mean(EEG_avg(:,:,:,test_idx),4)); %% select the data in [197 217]ms, subj*cond*channel
    for iSub = 1:size(data_test,3)
        data_1 = squeeze(data_test(:,3,iSub)); %% select condition L3 for each channel
        data_2 = squeeze(data_test(:,4,iSub)); %% select condition L4 for each channel
        [h,p,ci,stats] = ttest(data_1,data_2); %% ttest comparison 配对样本T检验
        P_ttest2(iSub) = p; %% save the p value from ttest
        T_ttest2(iSub) = stats.tstat;
    end
    
    figure;
    subplot(1,4,1);
    topoplot(squeeze(mean(data_test(:,3,:),1)),EEG.chanlocs,'maplimits',[-15 0]);
    subplot(1,4,2);
    topoplot(squeeze(mean(data_test(:,4,:),1)),EEG.chanlocs,'maplimits',[-15 0]);
    subplot(1,4,3);
    topoplot(T_ttest2,EEG.chanlocs);
    subplot(1,4,4);
    % 给P值画地形图，做一个log转化，图会更加好看，也便于观察显著区域
    % [1,0.1,0.01,0.001] -> [0,1,2,3]
    plog = -log10(P_ttest2);
    % 'electrodes' ,'off',是去除电极点，'style' ,'map'是去除等高线
    topoplot(plog, EEG.chanlocs,'maplimits',[0 3], 'electrodes' ,'off',   'verbose' ,'off', 'style' ,'map');
    colorbar('YLim',[0 3], 'YTick',[0,1,2,3],'YTickLabel',{'1','0.1','0.01','0.001'});
    
    %% 沿着时间进行方差分析（针对多个条件）
    Cz = 13;
    % 取通道CZ的数据，被试*条件*时间点
    data_test = squeeze(EEG_avg(:,:,Cz,:)); %% select the data at Cz, data_test: subj*cond*time
    for iSub = 1:size(data_test,3)
        % 选取第i个时间点的数据 被试*条件数，10*4
        data_anova = squeeze(data_test(:,:,iSub)); %% select the data at time point i
        % 需要用到这个函数，要在当前路径
        [p, table] = anova_rm(data_anova,'off');  %% perform repeated measures ANOVA
        P_anova(iSub) = p(1); %% save the data from ANOVA
    end
    
    mean_data = squeeze(mean(data_test,1)); %% dimension: cond*time
    figure;
    subplot(211);plot(EEG.times, mean_data,'linewidth', 1.5); %% waveform for different condition
    set(gca,'YDir','reverse');
    axis([-500 1000 -35 25]);
    subplot(212);plot(EEG.times,P_anova);
    axis([-500 1000 0 0.05]); %% plot the p values from ANOVA
    
    %% 沿着通道进行方差分析（针对多个条件）
    
    test_idx = find((EEG.times>=197)&(EEG.times<=217)); %% define the intervals
    data_test = squeeze(mean(EEG_avg(:,:,:,test_idx),4)); %% select the data in [197 217]ms, subj*cond*channel
    for iSub = 1:size(data_test,3)
        data_anova = squeeze(data_test(:,:,iSub)); %% select the data at channel i
        [p, table] = anova_rm(data_anova,'off');  %% perform repeated measures ANOVA
        P_anova2(iSub) = p(1); %% save the data from ANOVA
        F_anova2(iSub) = table{2,5};
    end
    figure;
    for iSub = 1:4
        subplot(1,5,iSub);
        topoplot(squeeze(mean(data_test(:,iSub,:),1)),EEG.chanlocs,'maplimits',[-20 20]);
        title(['N2 amplitude at L',num2str(iSub)]);
    end
    % subplot(1,5,5); topoplot( P_anova2,EEG.chanlocs,'maplimits',[0 0.05]);
    subplot(1,5,5); topoplot( F_anova2,EEG.chanlocs);
    title(['F value']);
    
catch Me
    disp(Me.message)
end
return