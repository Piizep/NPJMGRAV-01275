%%--------------- Fonction d'ajustement des essais 1 entre la para 5 et 10 ------------
% identification des 5 derniers essais de la para 10 qui sont en fait les essais 16:20 de la para 5
% Fe coda = 100 Hz / Fe emg = 2000 Hz

%% /!\ POUR LES ESSAIS SUIVANT LES DONNEE DOCO NE SERONT PAS VALABLES CAR DECALAGE PAR RAPPORT AU TRIGGER
% S6 P4 E11 et E12
% S7 P3 E10 et E11
% S4 P8 E5 6 7

clc;clear all;close all



% function [doco_all_essai] = decoupe_essai_doco(sujet)

load('doco.mat');

rec_doco = {'Button' 'Button1' 'Button2' 'CloseSmall' 'Electro' 'FarSmall' 'TrigTrial'}; % label des données doco enregistrées



for s = 1 %sujet
    
                doco_all(s).para(5).essai(16:20) = doco_all(s).para(10).essai(11:15);
                doco_all(s).para(10).essai(11:15) = [];

    for p = 1 %:10
       
        for e = 10 %:size(doco_all(s).para(p).essai,2) % boucle allant de 1 jusqu'au nombre d'essai dans la parabole
            

                %% Dérivation pour id front montant

                    deriv_doco = gradient(doco_all(s).para(p).essai(e).TrigTrial(1:end)>1); % derivation du trig coda (front montant à l'appui sur le bouton) pour identifier chaque essai

                    id_deriv_emg = find(deriv_doco == 1); % trouver les index des front montant
                    
                    if size(id_deriv_emg,1) == 2 
                        id_deriv_emg = 1;
                    end
                    
                    if isempty(id_deriv_emg) % si le trigger n'a jamais déclenché durant l'essai
                        
                        for d = 1:7 % boucle pour chaque enregistrement doco (cible, aimant, trig,... x7)

                        doco_all_essai(s).para(p).essai(e).(rec_doco{d}) = doco_essai; % reprend la même valeur que les données importées

                        end
                        
                    else     
                        
                        
                    % recherche des index du début de chaque essai
                        id_essai = id_deriv_emg(1);
                    
                        for d = 1:7 % boucle pour chaque enregistrement doco (cible, aimant, trig,... x7)

                        %% découpe de chaque essai à partir des index précédent

                        doco_essai = doco_all(s).para(p).essai(e).(rec_doco{d})(id_essai:end); % crée un vecteur contenant les données doco de l'essai en cours dans la boucle

                        doco_all_essai(s).para(p).essai(e).(rec_doco{d}) = doco_essai; % crée une struct dans laquelle on insert chaque vecteur par sujet/parabole/essai/muscle

                        end
                    
                    end

                    for d = 1:7 % boucle pour chaque enregistrement doco (cible, aimant, trig,... x7)

                    %% découpe de chaque essai à partir des index précédent

                    doco_essai = doco_all(s).para(p).essai(e).(rec_doco{d})(id_essai:end); % crée un vecteur contenant les données doco de l'essai en cours dans la boucle

                    doco_all_essai(s).para(p).essai(e).(rec_doco{d}) = doco_essai; % crée une struct dans laquelle on insert chaque vecteur par sujet/parabole/essai/muscle


                    end
%            %%
                figure;
                hold on
                plot(doco_all(s).para(p).essai(e).Button)
                plot(doco_all(s).para(p).essai(e).Electro)
                plot(doco_all(s).para(p).essai(e).TrigTrial)
                plot(doco_all(s).para(p).essai(e).CloseSmall)
                plot(doco_all(s).para(p).essai(e).FarSmall)
                legend('Button' ,'Electro', 'TrigTrial', 'CloseSmall', 'FarSmall')
                title(['Sujet ' num2str(s) ' Para ' num2str(p) ' Essai ' num2str(e)]);
                
                
        end
    end
end

%% doco_all_essai = doco_all;

