%% Name: preprocessing_EEG.m
%% Description: a function for processing EEG data using batch
%% Author: Yao Yipeng
%% Contact: daraianyao@gmail.com
%% Date: 2023,11,29

function preprocessing_EEG()
    try
    %% initialization
    eeglab;
    clc;
    clear all;
    close all;
    commandwindow;
    
    %% set paths to the wanted processing data
    % the path for raw data
    ori_path = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\EEG_Data\imported_data'];
    %cd(ori_path);
    % the path for saving processed data
    dir_path = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing'];
    dir_path_ERP = [dir_path filesep 'group_A_BeforeICA'];
    dir_path_TFA = [dir_path filesep 'group_TFA_BeforeICA'];
    % the path to location template
    locTem_path = 'D:\toolbox\eeglab14_1_1b\plugins\dipfit2.3\standard_BEM\elec\standard_1005.elc';
    % the path for the specific files
    %files = dir('*.set');      %dir([ori_path,filesep,'*.set'])    
    
    %% connect to the subjects
    subFiles.s1  = 'Sub01_yrm';
    subFiles.s2  = 'Sub02_jsy';
    subFiles.s3  = 'Sub03_hjl';
    subFiles.s4  = 'Sub04_yyr';
    subFiles.s5  = 'Sub05_ljp';
    subFiles.s6  = 'Sub06_gff';
    subFiles.s7  = 'Sub07_ztt';
    subFiles.s8  = 'Sub08_cjh';
    subFiles.s9  = 'Sub09_gpx';
    subFiles.s10 = 'Sub10_zxc';
    subFiles.s11 = 'Sub11_lgh';
    subFiles.s12 = 'Sub12_zhc';
    subFiles.s13 = 'Sub13_wy';
    subFiles.s14 = 'Sub14_ly';
    subFiles.s15 = 'Sub15_xxt';
    subFiles.s16 = 'Sub16_yyq';
    subFiles.s17 = 'Sub17_sxk';
    subFiles.s18 = 'Sub18_wzy';
    subFiles.s19 = 'Sub19_cmj';
    subFiles.s20 = 'Sub20_ch';
    subFiles.s21 = 'Sub21_lrn';
    subFiles.s22 = 'Sub22_zxd';
    subFiles.s23 = 'Sub23_yx';
    subFiles.s24 = 'Sub24_lzy';
    subFiles.s25 = 'Sub25_ljn';
    subFiles.s26 = 'Sub26_zyz';
    subFiles.s27 = 'Sub27_fwh';
    subFiles.s28 = 'Sub28_ly';
%     subFiles.s29 = 'sub30_yzx';
%     subFiles.s30 = 'sub31_zkx';
%     subFiles.s31 = 'sub32_ywj';
%     subFiles.s32 = 'sub33_xwh';
%     subFiles.s33 = 'sub34_ydm';
%     subFiles.s34 = 'sub35_spz';
%     subFiles.s35 = '30qianfenglin59F30A2';
    fieldsOfSubFiles = fieldnames(subFiles);
    numSub = length(fieldsOfSubFiles);
    
    %% define parameters for preprocessing
    elecChan_useless = {'EOG'};
    bandPass_filt_ERP = [1 30];  
    bandPass_filt_TFA = [0.5 100]; % for TFA
    notchPass_filt = [48 52];
    eventList = {'130','135','140','145','150','155','160','165','170','175','180','185'};
    epochTime = [-1  5];
    baseCorTime = [-1000   0];
    
    %% before ICA but including load, check, channel locations, delete channel(i.e. EOG),
    %filtering, segment(epoch and rmbaseline),
    for iSub = 28: numSub
        %waitbar(iSub/length(numSub),'Dont touch me!!');
        % load dataset
        curFile_name = [subFiles.(fieldsOfSubFiles{iSub}) '.set'];
        EEG = pop_loadset('filename',curFile_name,'filepath',ori_path);
        %EEG = pop_loadset(ori_path, curFile_name); %pop_loadbv for loading .vhd files£¬pop_loadset for loading .set files
        % check the dataset whether it is unbroken or not
        EEG = eeg_checkset( EEG );
        % save data
        % %!!!     EEG = pop_saveset( EEG, 'filename',['Sub_',num2str(subj,'%02d'),'.set'],'filepath',dir_path);
        % channel location
        EEG = pop_chanedit(EEG, 'lookup',locTem_path);
        % %!!!     EEG = pop_saveset( EEG, 'filename',['Loc_Sub_',num2str(subj,'%02d'),'.set'],'filepath',dir_path);
        % delete useless electrode channel
        EEG = pop_select( EEG,'nochannel',elecChan_useless);
        % filter data with lowpass and high pass      
        EEG_ERP = pop_eegfiltnew(EEG, bandPass_filt_ERP(1), bandPass_filt_ERP(2), 33000, 0, [], 0);
        EEG_TFA = pop_eegfiltnew(EEG, bandPass_filt_TFA(1), bandPass_filt_TFA(2), 33000, 0, [], 0);
        % filter data with notch bandpass data
        EEG_TFA = pop_eegfiltnew(EEG_TFA, notchPass_filt(1), notchPass_filt(2), 1650, 1, [], 0);
        % %!!!     EEG = pop_saveset( EEG, 'filename',['FE140_delchan_Loc_Sub_',num2str(subj,'%02d'),'.set'],'filepath',dir_path);
        % segment for epoch
        EEG_ERP = pop_epoch(EEG_ERP, eventList, epochTime, 'epochinfo', 'yes');% inputpara is mark and timeline
        EEG_TFA = pop_epoch( EEG_TFA, eventList, epochTime, 'epochinfo', 'yes');% inputpara is mark and timeline
        % prune  for baseline
        EEG_ERP  = pop_rmbase(EEG_ERP, baseCorTime);
        EEG_TFA  = pop_rmbase(EEG_TFA, baseCorTime);
        pop_saveset(EEG_ERP, 'filename',['beforeICA_',subFiles.(fieldsOfSubFiles{iSub})],'filepath',dir_path_ERP);
        pop_saveset(EEG_TFA, 'filename',['beforeICA_',subFiles.(fieldsOfSubFiles{iSub})],'filepath',dir_path_TFA);
    end

        %% manual operation including interpolate electrodes£¬delete epoch with low signal-noise ratio 
        % ===================================save it with name starting with 'Rej_sub_'to A and TFA===================================
        % for example, Rej_subname
        % alert: please save current data as A and TFA two times!!!
        %%% please use eeglab GUI to conduct this step %%%
        %%% please use eeglab GUI to conduct this step %%%
        %%% please use eeglab GUI to conduct this step %%%
        
        %% run ica
        eeglab; 
        clc;    
        clear all;  
        close all;   
        anaWhat = 2; % 1 = ERP; 2 = TFA   
        if anaWhat == 1
            path_dirTemp  = 'group_A_Rej'; 
            path_saveTemp = 'group_A_ICA';
        elseif anaWhat == 2
            path_dirTemp  = 'group_TFA_Rej';
            path_saveTemp = 'group_TFA_ICA';
        end
        dir_path  = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_dirTemp]; 
        save_path = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_saveTemp]; 
        files = dir([dir_path,filesep,'Rej*.set']);
        tic
        parfor iSub = 28:length(files)
            EEG = pop_loadset('filename',files(iSub).name,'filepath',dir_path);
            % alert: delete less componets and input right parameters for runica 
            EEG = pop_runica(EEG, 'extended',1,'pca',32,'interupt','on');            
            % store EEG data in a cell array
            EEGCell{iSub} = EEG;    
        end 
        toc
        % save the results after ICA
        for iSub = 28:length(files)
            EEG = EEGCell{iSub};
            pop_saveset(EEG, 'filename',['ica_',files(iSub).name],'filepath',save_path);
        end
        
        %% delete ICA components with manual operation
        % ===================================save it with name starting with 'Rica_'===================================
        % for example, Rica_subname
        %%% please use eeglab GUI conduct this step%%%
        %%% please use eeglab GUI conduct this step%%%
        %%% please use eeglab GUI conduct this step%%%
        
        %% delete broken epochs automatically with cutoff
        clc; 
        clear all; 
        close all; 
        anaWhat = 2 ;% 1 = ERP; 2 = TFA
        if anaWhat == 1
            path_dirTemp  = 'group_A_Rica';
            path_saveTemp = 'group_A_AJ';
        elseif anaWhat == 2
            path_dirTemp  = 'group_TFA_Rica';
            path_saveTemp = 'group_TFA_AJ';
        end
        dir_path  = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_dirTemp];
        save_path = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_saveTemp];
        files = dir([dir_path,filesep,'Rica_*.set']);
        
        for iSub = 1:length(files)
            EEG = pop_loadset('filename',files(iSub).name,'filepath',dir_path);
            % get rid of beyond -100 and 100
            EEG = pop_eegthresh(EEG,1,[1:32] ,-300,300,-1,1.999,1,1);
            % save data
            pop_saveset( EEG, 'filename',['AJ_',files(iSub).name],'filepath', save_path);
        end
             
        %% re-reference       
        clc; 
        clear all;
        close all; 
        anaWhat = 2; % 1 = ERP; 2 = TFA
        if anaWhat == 1
            path_dirTemp  = 'group_A_AJ';
            path_saveTemp = 'group_A_Ref';
        elseif anaWhat == 2
            path_dirTemp  = 'group_TFA_AJ';
            path_saveTemp = 'group_TFA_Ref';
        end
        dir_path  = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_dirTemp];
        save_path = ['D:\ResearchProjects\Yaoyipeng\Pain_VisionInteg\program\supThreshold\Pain_heat\Pain_VisionInteg_heatV4_EEG\code\Process_EEGData\preprocessing' filesep path_saveTemp];
        files = dir([dir_path,filesep,'AJ_*.set']);
        channelNum_bilMas = [17 18]; % please check the number of channel of bilateral mastoids for your data
        for iSub = 28:length(files)
            EEG = pop_loadset('filename',files(iSub).name,'filepath',dir_path);
            % create a average reference for possible brainnet analysis  
            EEG = pop_reref( EEG, [ ] );
            pop_saveset( EEG, 'filename',['refAvg_',files(iSub).name],'filepath',save_path);
            % create a bilMas reference
            EEG = pop_reref( EEG, channelNum_bilMas);
            pop_saveset( EEG, 'filename',['refTP_',files(iSub).name],'filepath',save_path);
        end
        
    catch Me
        disp(Me.message)
    end



return