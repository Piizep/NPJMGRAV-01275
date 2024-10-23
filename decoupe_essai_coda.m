%%--------------- Fonction de découpe de chaque essai ------------
% identification des essais à partir du trigger
% découpe et enregistrement de chaque essai dans un repertoire 
% Fe coda = 100 Hz / Fe emg = 2000 Hz
% 15 essais par par parabole

clc;close all;clear all

sujet = 1:9; %1:9
para = 1:10; %1:10
n_mark = 1:10; %1:10

% function coda_all_essai = decoupe_essai_coda(sujet,para,marker)

load('coda.mat') ; load('trig_coda.mat') % chargement des données brutes + trig

coda_all_essai = [];

mark = {'Origine' 'X' 'Y' 'Malleole' 'Genoux' 'Hanche' 'Epaule' 'Index' 'TeteAR' 'TeteAV'};


for s = sujet
    
    if s > 6
        mark{5} = 'Genou'; % correction du changement d'orthographe après le sujet 6
    end
    
        for p = para
            
            
        %% Vecteur temporel

        
        time_coda = 0:1/100:(length(trig_coda_all(s).anals(p).TrigTrial(1:end))-1)/100;
        
        


            % Dérivation pour id front montant

       
            if s == 3 && p == 2 || s == 4 && p == 8 % pour s3 et s4 le trigger n'est pas manquant au départ donc pas d'ajout de valeur
                                        
                deriv_coda = gradient(trig_coda_all(s).anals(p).TrigTrial(1:end)>10000); % derivation du trig coda (front montant à l'appui sur le bouton) pour identifier chaque essai
            else
                
                deriv_coda = gradient(trig_coda_all(s).anals(p).TrigTrial(1:end)>10000); % derivation du trig coda (front montant à l'appui sur le bouton) pour identifier chaque essai

                deriv_coda(1:2,:) = 1; % Ajout de deux valeur de départ factice pour identifier le premier essai dans la boucle
            end
            
            deriv_coda = deriv_coda ~= 0; % ajustement pour pc perso qui met 0.5 lors de gradient au lieu de 1
            
            id_deriv_coda = find(deriv_coda == 1); % trouver les index des front montant

            id_essai = [];

%             recherche des index du début de chaque essai

            for i = 1:4:sum(deriv_coda) % prendre uniquement la première valeur du front montant pour identifier le debut de l'essai (1 valeur sur 4)

                id_essai = [id_essai;id_deriv_coda(i)]; % concatenantion des index de la 1ere valeur des fronts montant

            end
            
            % reajustement du trigger lors de certain essais
            
            if s == 6 && p == 4
                
                id_essai(11) = id_essai(12)-100; % - 1 sec car 100hz
                id_essai(12) = id_essai(12)+100; % + 1 sec
                
            else if s == 7 && p == 3
                    
                id_essai(10) = id_essai(11);
                id_essai(11) = id_essai(12)-150;
%                 
                else if s == 4 && p == 8
                                                                
                        id_essai(5) = id_essai(6);
                        id_essai(6) = id_essai(7)-50;
                        id_essai(7) = id_essai(7)+150;
                    end                      
                
                end
            end
            
%             for m = marker
%                  
%                 subplot(3,2,m-3)
%                 plot(coda_all(s).marks(p).(mark{m}),'k')
%                 title(['sujet ' num2str(s) ' para ' num2str(p) ' ' mark{m}])
%                 
%             end

            % découpe de chaque essai à partir des index précédent



            for e = 1:length(id_essai)-1 % boucle allant de 1 jusqu'au nombre d'essai dans la parabole

                coda_essai = [];
                coda_essai_end = [];
                
                for m = n_mark % boucle pour le nombre de marqueur (certains en ont plus que 10) PENSER A AJUSTER / SUJET
                
                    for xyz = 1:3

                        coda_essai(:,xyz) = coda_all(s).marks(p).(mark{m})(id_essai(e):id_essai(e+1),xyz); % crée un vecteur contenant les données xyz de l'essai en cours dans la boucle
    %                     coda_essai = coda_all_cell{s}{m,:,p}(id_essai(e):id_essai(e+1),:);

                        coda_all_essai(s).para(p).essai(e).(mark{m}) = coda_essai; % crée une struct dans laquelle on insert chaque vecteur par sujet/parabole/essai/marqueurs
    %                     coda_all_essai{s}{p}{e,m} = coda_essai; % crée une cellule dans laquelle on insert chaque vecteur par sujet/parabole/essai/marqueurs


                        if e == length(id_essai)-1 % cas particulier pour le dernier essai, il faut preciser d'aller du dernier index jusqu'à la fin du vecteur

                            coda_essai_end(:,xyz) = coda_all(s).marks(p).(mark{m})(id_essai(e+1):end,xyz);
    %                           coda_essai_end = coda_all_cell{s}{m,:,p}(id_essai(e+1):end,:);

                            coda_all_essai(s).para(p).essai(e+1).(mark{m}) = coda_essai_end; % insertion du 15 essai dans la sous partie essai
    %                           coda_all_essai{s}{p}{e+1,m} = coda_essai_end;

                        end
                        
                                            % cas particulier pour les 1er essai ou la durée du trig est plus courte que les autres (0.1 normalement)
                        if e == 1

                            based_value(1:(100-id_deriv_coda(3)),xyz) = coda_all_essai(s).para(p).essai(e).(mark{m})(1,xyz); % matrice xyz qui reprend la 1ere valeur coda n fois pour ajouter au début de l'essai et arriver à 100 valeur (duré normal du trigger sauf essai 1 et éviter le décalage avec les données EMG)
                        
                        end
              

                    end
     
                                            % cas particulier pour les 1er essai ou la durée du trig est plus courte que les autres (0.1 normalement)
                    if e == 1

                        coda_all_essai(s).para(p).essai(e).(mark{m}) = [based_value ; coda_all_essai(s).para(p).essai(e).(mark{m})]; % concaténation des 43 valeurs avec les données

                    end
                
                end
   
            end
            
%             figure;
%             plot(time_coda,trig_coda_all(s).anals(p).TrigTrial(1:end));
%             hold on
%             plot(time_coda,coda_all(s).marks(p).Index(:,3)*5);



            
        end

end
%% end


figure;
plot(time_coda,trig_coda_all(s).anals(p).TrigTrial(1:end));
hold on
plot(time_coda,coda_all(s).marks(p).Index(:,3)*5);
plot(time_coda,deriv_coda);
% 
% 
% figure;
% plot(time_coda,deriv_coda,'.');