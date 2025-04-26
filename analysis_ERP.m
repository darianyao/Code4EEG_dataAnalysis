%% Name: analysis_ERP.m
%% Description: a function for analyzing ERP
%% Author: Yao Yipeng
%% Contact: darianyao@gmail.com
%% Date: 2023,11,30
function analysis_ERP()
try
    %% initialization
    eeglab;
    clc;
    clear all;
    close all;
    commandwindow;
    
    %% set paths to load preprocessed data
    dir_path  = 'D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing\group_A_Ref';
    save_path = 'D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\ERP_analysis\group_A_ERP';
    cd(dir_path);
    files = dir([dir_path,filesep,'refAvg*.set']);%refTP;refAvg
    Cond = {'130','135','140','145','150','155','160','165','170','175','180','185'}; %% condition name
    
    %% calculate ERP dataset for all subjects
    % define parameters for time window
    timeEpoch = [-1 5];
    timeBaseline = [-1000  0];
    for iSub = 1:length(files)
        % get the current subject .set file name   
        setname = files(iSub).name;
        % load dataset
        EEG = pop_loadset('filename',setname,'filepath',dir_path);
        % change the dataset format into a 3D format, namely subs*channels*time points  
        EEG_avg(iSub,:,:) = squeeze(mean(EEG.data,3));
        for iCond = 1:length(Cond)
            % split diffrent epoch with exprimental conditions
            EEG_new = pop_epoch(EEG, Cond(iCond), timeEpoch, 'newname', 'Merged datasets pruned with ICA', 'epochinfo', 'yes');
            EEG_new = pop_rmbase(EEG_new, timeBaseline); %% baseline correction for EEG_new
            % average across trials for EEG_new, namely subj*cond*channel*time
            EEG_avg_cond(iSub,iCond,:,:) = squeeze(mean(EEG_new.data, 3));  
        end
    end
    
    %% save data
    save([save_path, filesep, 'Group_level_ERP.mat'],'EEG_avg','EEG_avg_cond','Cond','EEG');
    
    

   
catch Me
    disp(Me.message)
end
return
