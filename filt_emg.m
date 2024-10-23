%%--------------- Fonction filtrage EMG ------------
% Fe emg = 2000 Hz

clc; clear all; close all
% function emg_filt = filt_emg

load('emg_all_essai_corr.mat')

Fe_emg = 2000;
Te_emg = 1/Fe_emg;

sujet = 1 %:9;
para = 1 %:10;
muscle = 1 %:8; %1:8
musc = {'ta' 'abd' 'bic' 'da' 'sol' 'es' 'tric' 'dp'};

for s = sujet
    for p = para
        for e = 1:size(emg_all_essai(s).para(p).essai,2)
            
            if isnan(emg_all_essai(s).para(p).essai(e).ta)
               
                emg_filt(s).para(p).essai(e) = emg_all_essai(s).para(p).essai(e);
                
            else
                
                
                for m = muscle

% Nombre d'échantillon

N = size(emg_all_essai(s).para(p).essai(e).(musc{m}),1);

% Vecteurs A et B

[B,A] = butter(4,[20 400]/(Fe_emg/2),'bandpass');

% Filtrage des données emg

emg_filt(s).para(p).essai(e).(musc{m}) = filtfilt(B,A,emg_all_essai(s).para(p).essai(e).(musc{m}));                            % filtrage 20-100Hz pour précision temporelle (20-400Hz pour les bouffés)
emg_filt(s).para(p).essai(e).(musc{m}) = emg_filt(s).para(p).essai(e).(musc{m}) - ones(length(emg_filt(s).para(p).essai(e).(musc{m})),1)*mean(emg_filt(s).para(p).essai(e).(musc{m}),1); % centrage du signal emg autour de la moyenne individuelle de chaque muscle
emg_filt(s).para(p).essai(e).(musc{m}) = abs(emg_filt(s).para(p).essai(e).(musc{m})); % redressement du signal emg

% [b,a] = butter(4,4/(Fe_emg/2),'lowpass');
% emg_filt(s).para(p).essai(e).(musc{m}) = filtfilt(b,a,emg_filt(s).para(p).essai(e).(musc{m}));         % filtrage à 75Hz (cf Horita, Regueme, Morio)


emg_filt(s).para(p).essai(e).(musc{m}) = lpfilter(emg_filt(s).para(p).essai(e).(musc{m}),4,Fe_emg,'damped',2);         % filtrage à 75Hz (cf Horita, Regueme, Morio)

% emg_filt(s).para(p).essai(e).(musc{m}) = emg_filt(s).para(p).essai(e).(musc{m})/max_DELT_all(s);                   % normalise signal par rapport à la moyenne des max en PRE uniquement T0saut réussi


                end
            end
        end
    end
end
% end


%% ---------------------------- Graphe verif filtrage ---------------------------------
% 
figure;
hold on
plot(emg_all_essai(s).para(p).essai(e).ta)
plot(emg_filt(s).para(p).essai(e).ta)
legend('Raw data','Filt')

% end