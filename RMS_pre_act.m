%% -------- RMS EMG -------

clc; close all; clear all;

%%

load('emg_normY.mat')
load('pre_act.mat')
load('TR_all.mat')

muscle = 1:8;
musc = {'ta' 'abd' 'tric' 'da' 'sol' 'es' 'bic' 'dp'};


%%

for s = 1:9
    for p = 1:10
        for e = 1:size(emg_normY(s).para(p).essai,2)
                                    
            time_emg = 0:1/2000:(size(emg_normY(s).para(p).essai(e).da,1)-1)/2000;

            for m = muscle
                
                if isnan(emg_normY(s).para(p).essai(e).(musc{m}))  % si NaN dans data alors (NaN)

                    RMS(s).para(p).essai(e).pre_act.(musc{m}) = NaN;


                else if pre_act(s).para(p).essai(e).id_pre_act.(musc{m}) == 1
                    
                    RMS(s).para(p).essai(e).pre_act.(musc{m}) = NaN;

                    
                    else                    
                
                % 200 ms window from pre activation time
                RMS(s).para(p).essai(e).pre_act.(musc{m}) = sqrt(sum(emg_normY(s).para(p).essai(e).(musc{m})(pre_act(s).para(p).essai(e).id_pre_act.(musc{m}):pre_act(s).para(p).essai(e).id_pre_act.(musc{m})+200)).^2./(time_emg(pre_act(s).para(p).essai(e).id_pre_act.(musc{m})+200) - time_emg(pre_act(s).para(p).essai(e).id_pre_act.(musc{m}))));

                
                    end
                end
            end
        end
    end
end