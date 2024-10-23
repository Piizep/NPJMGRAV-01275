%%--------------- Fonction filtrage position ------------
% Fe coda = 100 Hz
% passe bas 10 Hz ordre 3

clc; clear all; close all

% function coda_filt = filt_coda

load('coda_all.mat')

Fe_coda = 100;
Te_coda = 1/Fe_coda;

mark = {'Origine' 'X' 'Y' 'Malleole' 'Genoux' 'Hanche' 'Epaule' 'Index' 'TeteAR' 'TeteAV'};
n_mark = 1:10; %1:10

%%

% pre attribution de la structure coda_filt avant de l'�craser avec les
% donn�es filtr�s sans les NaN

coda_filt = coda_all;

for s = 1:9
    
    % correction du Genoux en Genou apr�s sujet 6
    if s > 6
                mark = {'Origine' 'X' 'Y' 'Malleole' 'Genou' 'Hanche' 'Epaule' 'Index' 'TeteAR' 'TeteAV'};
    end
            
    for p = 1:10
        for e = 1:size(coda_all(s).para(p).essai,2)
            for m = n_mark
                
                % Nombre d'�chantillon

                N = size(coda_all(s).para(p).essai(e).(mark{m}),1);

                % Vecteurs A et B

                [B,A] = butter(3,10/(Fe_coda/2),'low');
                

                % Filtrage des donn�es positionelles xyz
                
                % si le vecteur contient moins de 10 valeur, alors pas la peine de filtrer car marker HS
                if sum(~isnan(coda_all(s).para(p).essai(e).(mark{m})(:,1))) < 10
                    
                    coda_filt(s).para(p).essai(e).(mark{m}) = coda_all(s).para(p).essai(e).(mark{m});
                    
                else                    
                            
                % vecteur temporaire contenant les donn�es filtr�es en excluant les NaN avant et/ou apr�s les donn�es positionnelles
                filt_tempo = filtfilt(B,A,coda_all(s).para(p).essai(e).(mark{m})(~isnan(coda_all(s).para(p).essai(e).(mark{m})(:,1)),1:3));%~isnan permet de chercher l'inverse des NaN c'est � dire les data

                % insertion des valeurs filtr�es dans data_filt par �crasement des valeur non filtr�es (pr� allocation au d�but) pour garder les NaN avant et apr�s 
                coda_filt(s).para(p).essai(e).(mark{m})(~isnan(coda_all(s).para(p).essai(e).(mark{m})(:,1)),1:3) = filt_tempo;
                
                end
                
            end
        end
    end
end


%% ---------------------------- Graphe verif filtrage ---------------------------------

figure;
hold on
plot(coda_all(3).para(1).essai(1).Index)
plot(coda_filt(3).para(1).essai(1).Index)
legend('Raw data','Filt')

