%% ------------------ Calcul angles ---------------------------
clc; clear all; close all

%%
load('coda_cut.mat')
load('cine_cut.mat')
load('angles_cut.mat') % angle epaule pour comparaison

Te = 1/100;

%%

% calcul angle index/épaule

for s = 1:9
      
    for p = 1:10
        
% figure;
        
        for e = 1:size(coda_cut(s).para(p).essai,2)
            

            
            iDx = []; iDz = []; droite_b = []; droite_c =[]; angle_teta = [];
            
%             remplace par NaN
            if isempty(coda_cut(s).para(p).essai(e).Index)
                
                angle_teta = NaN;
                
            else  
                
%             Si NaN sur un marqueur au début = tout le calcul ang mort donc
                                       
            if isnan(coda_cut(s).para(p).essai(e).Epaule(1))
                    
                coda_cut(s).para(p).essai(e).Epaule = NaN(100,3);
            
            else
               
            droite_a = [];  droite_b = []; droite_c = []; iDx = []; iDz = []; angle_tete = [];

                
            droite_a = sqrt((coda_cut(s).para(p).essai(e).Index(1,1)-coda_cut(s).para(p).essai(e).Epaule(1,1)).^2 + (coda_cut(s).para(p).essai(e).Index(1,3) - coda_cut(s).para(p).essai(e).Epaule(1,3)).^2);
               
            
                for a = 1:size(coda_cut(s).para(p).essai(e).Index,1)
                                      
                        iDx(a,1) = coda_cut(s).para(p).essai(e).Index(1,1) + (coda_cut(s).para(p).essai(e).Epaule(a,1) - coda_cut(s).para(p).essai(e).Epaule(1,1));
                        
                        iDz(a,1) = coda_cut(s).para(p).essai(e).Index(1,3) + (coda_cut(s).para(p).essai(e).Epaule(a,3) - coda_cut(s).para(p).essai(e).Epaule(1,3));

                        droite_b(a,1) = sqrt((coda_cut(s).para(p).essai(e).Index(a,1)-coda_cut(s).para(p).essai(e).Epaule(a,1)).^2 + (coda_cut(s).para(p).essai(e).Index(a,3) - coda_cut(s).para(p).essai(e).Epaule(a,3)).^2);

                        droite_c(a,1) = sqrt((coda_cut(s).para(p).essai(e).Index(a,1)-iDx(a)).^2 + (coda_cut(s).para(p).essai(e).Index(a,3) - iDz(a)).^2);

                        angle_teta(a,1) = acosd(((droite_a.^2 + droite_b(a).^2 - droite_c(a).^2)/(2*droite_a*droite_b(a))));

                end
            

            cine_cut(s).para(p).essai(e).vit_teta = gradient(angle_teta)/Te; % Dérivation angle pour vitesse
            
            cine_cut(s).para(p).essai(e).id_pv_teta = find(cine_cut(s).para(p).essai(e).vit_teta == (max(cine_cut(s).para(p).essai(e).vit_teta)));
            
            cine_cut(s).para(p).essai(e).acc_teta = gradient(cine_cut(s).para(p).essai(e).vit_teta)/Te;
            
            cine_cut(s).para(p).essai(e).id_pa_teta = find(cine_cut(s).para(p).essai(e).acc_teta == (max(cine_cut(s).para(p).essai(e).acc_teta)));
            
            
%%     %% Méthode de Thomas (avec une erreur au niveu de l'iDx et iDz car utilise "a" pour le dernier marker alors qu'il faudrait mettre "1" car c'est le marker de départ qui doit être utilisé

%             droite_a_T = [];  droite_b_T = []; droite_c_T = []; iDx_T = []; iDz_T = []; angle_teta_T = [];
% 
%                 
% %             droite_a_T = sqrt((coda_cut(s).para(p).essai(e).Index(1,1)-coda_cut(s).para(p).essai(e).Epaule(1,1)).^2 + (coda_cut(s).para(p).essai(e).Index(1,3) - coda_cut(s).para(p).essai(e).Epaule(1,3)).^2);
%            
% % figure;
% 
%                 for a = 1:size(coda_cut(s).para(p).essai(e).Index,1)-1
%                                       
%                         iDx_T(a,1) = coda_cut(s).para(p).essai(e).Index(1,1) + (coda_cut(s).para(p).essai(e).Epaule(a+1,1) - coda_cut(s).para(p).essai(e).Epaule(a,1));
%                         
%                         iDz_T(a,1) = coda_cut(s).para(p).essai(e).Index(1,3) + (coda_cut(s).para(p).essai(e).Epaule(a+1,3) - coda_cut(s).para(p).essai(e).Epaule(a,3));
% 
%                         droite_a_T(a,1) = sqrt((coda_cut(s).para(p).essai(e).Epaule(a,1)-iDx_T(a)).^2 + (coda_cut(s).para(p).essai(e).Epaule(a,3) - iDz_T(a)).^2);
%       
%                         droite_b_T(a,1) = sqrt((coda_cut(s).para(p).essai(e).Index(a,1)-coda_cut(s).para(p).essai(e).Epaule(a,1)).^2 + (coda_cut(s).para(p).essai(e).Index(a,3) - coda_cut(s).para(p).essai(e).Epaule(a,3)).^2);
% 
%                         droite_c_T(a,1) = sqrt((coda_cut(s).para(p).essai(e).Index(a,1)-iDx_T(a)).^2 + (coda_cut(s).para(p).essai(e).Index(a,3) - iDz_T(a)).^2);
% 
%                         angle_teta_T(a,1) = acosd(((droite_a_T(a).^2 + droite_b_T(a).^2 - droite_c_T(a).^2)/(2*droite_a_T(a)*droite_b_T(a))));
% 
%                         
% 
% %                         hold on
% %                         plot(coda_cut(s).para(p).essai(e).Index(:,1),coda_cut(s).para(p).essai(e).Index(:,3),'k')
% %                         plot(coda_cut(s).para(p).essai(e).Epaule(:,1),coda_cut(s).para(p).essai(e).Epaule(:,3),'k')
% %                         plot([coda_cut(s).para(p).essai(e).Epaule(a,1),iDx(a)],[coda_cut(s).para(p).essai(e).Epaule(a,3),iDz(a)],'b-')
% %                         plot([coda_cut(s).para(p).essai(e).Index(a,1),coda_cut(s).para(p).essai(e).Epaule(a,1)],[coda_cut(s).para(p).essai(e).Index(a,3),coda_cut(s).para(p).essai(e).Epaule(a,3)],'b-')

%                end
            

%             cine_cut(s).para(p).essai(e).vit_teta_T = gradient(angle_teta_T)/Te; % Dérivation angle pour vitesse
%             
%             cine_cut(s).para(p).essai(e).id_pv_teta_T = find(cine_cut(s).para(p).essai(e).vit_teta_T == (max(cine_cut(s).para(p).essai(e).vit_teta_T)));
%             
%             cine_cut(s).para(p).essai(e).acc_teta_T = gradient(cine_cut(s).para(p).essai(e).vit_teta_T)/Te;
%             
%             cine_cut(s).para(p).essai(e).id_pa_teta_T = find(cine_cut(s).para(p).essai(e).acc_teta_T == (max(cine_cut(s).para(p).essai(e).acc_teta_T)));
%                         
            end
            end
            

%%
% figure;
% hold on
% plot(coda_cut(s).para(p).essai(e).Index(:,1),coda_cut(s).para(p).essai(e).Index(:,3),'k')
% plot(coda_cut(s).para(p).essai(e).Epaule(:,1),coda_cut(s).para(p).essai(e).Epaule(:,3),'k')
% plot([coda_cut(s).para(p).essai(e).Epaule(a,1),iDx(a)],[coda_cut(s).para(p).essai(e).Epaule(a,3),iDz(a)],'b-')
% plot([coda_cut(s).para(p).essai(e).Index(a,1),coda_cut(s).para(p).essai(e).Epaule(a,1)],[coda_cut(s).para(p).essai(e).Index(a,3),coda_cut(s).para(p).essai(e).Epaule(a,3)],'b-')
% % Thomas avec erreur
% plot([coda_cut(s).para(p).essai(e).Epaule(a,1),iDx_T(a)],[coda_cut(s).para(p).essai(e).Epaule(a,3),iDz_T(a)],'r-')
% % Angle epaule
% plot([coda_cut(s).para(p).essai(e).Epaule(a,1),coda_cut(s).para(p).essai(e).Hanche(a,1)],[coda_cut(s).para(p).essai(e).Epaule(a,3),coda_cut(s).para(p).essai(e).Hanche(a,3)],'k-')


%%
% figure;
% subplot(1,3,1)
% hold on
% plot(angle_teta,'b')
% plot(angle_teta_T,'r')
% plot(angles_cut(s).para(p).essai(e).angle_epaule,'k')
% subplot(1,3,2)
% hold on
% plot(cine_cut(s).para(p).essai(e).vit_teta,'b')
% plot(cine_cut(s).para(p).essai(e).vit_teta_T,'r')
% plot(gradient(angles_cut(s).para(p).essai(e).angle_epaule)./(1/100),'k')
% subplot(1,3,3)
% hold on
% plot(cine_cut(s).para(p).essai(e).acc_teta,'b')
% plot(cine_cut(s).para(p).essai(e).acc_teta_T,'r')
% plot(gradient(gradient(angles_cut(s).para(p).essai(e).angle_epaule)./(1/100))./(1/100),'k')



%%
                
            
                                
            

            
        end
    end
end