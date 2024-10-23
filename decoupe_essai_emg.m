%%--------------- Fonction de découpe de chaque essai EMG ------------
% identification des essais à partir du trigger
% découpe et enregistrement de chaque essai dans un repertoire 
% Fe emg = 2000 Hz
% 15 essais par par parabole

clc;clear all; close all

sujet = 1:9;
para = 1:10;
% mark = 4:10; %1:10
muscle = 1:8; %1:8

% function emg_all_essai = decoupe_essai_emg(sujet,para,muscle)
% 
load('emg.mat'); load('trig_emg.mat') % chargement des données brutes + trig

load('coda.mat'); load('trig_coda.mat'); % chargement des données coda + id essai pour vérifier décallage trigger

emg_all_essai = [];

musc = { 'ta' 'abd' 'bic' 'da' 'sol' 'es' 'tric' 'dp'};



for s = sujet
    
    for p = para

        %% Vecteur temporel

        time_emg = 0:1/2000:(length(trig_emg_all(s).sujet(p).trigtrial(1:end))-1)/2000;
        
        time_coda = 0:1/100:(length(trig_coda_all(s).anals(p).TrigTrial(1:end))-1)/100;

        %% Dérivation pour id front montant
       
        deriv_emg = gradient(trig_emg_all(s).sujet(p).trigtrial(1:end)>1); % derivation du trig coda (front montant à l'appui sur le bouton) pour identifier chaque essai
        deriv_emg(1:1000,:) = 0;
        deriv_emg([102 103],:) = 1; % Ajout de deux valeur de départ factice pour identifier le premier essai dans la boucle
        deriv_emg = deriv_emg ~= 0; % ajustement pour pc perso qui met 0.5 lors de gradient au lieu de 1
        id_deriv_emg = find(deriv_emg == 1); % trouver les index des front montant

        id_essai = [];

        % recherche des index du début de chaque essai

        for i = 1:4:sum(deriv_emg) % prendre uniquement la première valeur du front montant pour identifier le debut de l'essai (1 valeur sur 4)

            id_essai = [id_essai;id_deriv_emg(i)]; % concatenantion des index de la 1ere valeur des fronts montant

        end
        
        if s == 6 && p == 4
                
                id_essai(11) = id_essai(12)-2000; % - 1 sec car 2000 hz
                id_essai(12) = id_essai(12)+2000;
                
            else if s == 7 && p == 3
                    
                id_essai(10) = id_essai(11);
                id_essai(11) = id_essai(12)-3000;
                
                else if s == 4 && p == 8
                                                                
                        id_essai(5) = id_essai(6);
                        id_essai(6) = id_essai(7)-1000;
                        id_essai(7) = id_essai(7)+3000;
                    end                      
                
                end
         end

        %% découpe de chaque essai à partir des index précédent

        for e = 1:length(id_essai)-1 % boucle allant de 1 jusqu'au nombre d'essai dans la parabole

            emg_essai = [];
            emg_essai_end = [];

            for m = muscle % boucle pour le nombre de muscle

                    emg_essai = emg_all(s).sujet(p).(musc{m})(id_essai(e):id_essai(e+1)); % crée un vecteur contenant les données emg de l'essai en cours dans la boucle

                    emg_all_essai(s).para(p).essai(e).(musc{m}) = emg_essai; % crée une struct dans laquelle on insert chaque vecteur par sujet/parabole/essai/muscle

                    if e == length(id_essai)-1 % cas particulier pour le dernier essai, il faut preciser d'aller du dernier index jusqu'à la fin du vecteur

                        emg_essai_end = emg_all(s).sujet(p).(musc{m})(id_essai(e+1):end);

                        emg_all_essai(s).para(p).essai(e+1).(musc{m}) = emg_essai_end; % insertion du 15 essai dans la sous partie essai

                    end
            end
        end
    end

end
% end

%%

% figure;
% % subplot(2,1,1)
% hold on 
% plot(time_emg,emg_all(s).sujet(p).da(:,1)./max(emg_all(s).sujet(p).da(:,1))+1);
% plot(time_emg,trig_emg_all(s).sujet(p).trigtrial./max(trig_emg_all(s).sujet(p).trigtrial)+1);

% subplot(2,1,2)
% plot(time_coda,trig_coda_all(s).anals(p).TrigTrial./max(trig_coda_all(s).anals(p).TrigTrial));
% hold on
% plot(time_coda,coda_all(s).marks(p).Index(:,3)./max(coda_all(s).marks(p).Index(:,3)));


% hold on
% plot(time_emg,trig_emg_all(s).sujet(p).trigtrial(1:end)*1000);

% figure;
% plot(time_emg,deriv_emg,'.');
