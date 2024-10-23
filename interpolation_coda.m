%%--------------- Fonction d'interpolation des données coda ------------
% Identification des 0 (perte du signal)
% Remplacement par NaN et interpolation
clc;clear all;close all
% 
%%
sujet = 1:9; %1:9
para = 1:10; %1:10
marker = 1:10; %1:10

% function coda_all = interpolation_coda(sujet,para,marker)

load('coda_all_essai.mat')

mark = {'Origine' 'X' 'Y' 'Malleole' 'Genoux' 'Hanche' 'Epaule' 'Index' 'TeteAR' 'TeteAV'};

for s = sujet
    
    if s > 6
        mark{5} = 'Genou'; % correction du changement d'orthographe après le sujet 6
    end
    
    for p = para

        for e = 1:length(coda_all_essai(s).para(p).essai) % boucle en fonction du nombre d'essai de chaqe sujet/para
            
%             figure;
%             fig=gcf; % ouvre figure en plein écran
%             fig.Units='normalized';
%             fig.OuterPosition=[0 0 1 1];  
            for m = marker % boucle marqueurs
                
                coda_all_essai(s).para(p).essai(e).(mark{m})(coda_all_essai(s).para(p).essai(e).(mark{m}) == 0) = NaN; % remplacer les 0 pour NaN pour fonction d'interp
                
                if sum(isnan(coda_all_essai(s).para(p).essai(e).(mark{m})(:,1))) > size(coda_all_essai(s).para(p).essai(e).(mark{m}),1)-2 % si le marker a que des 0 (perte marker) alors pas d'interpolation car marker a jeter 
                
                    coda_all_interp(s).para(p).essai(e).(mark{m}) = coda_all_essai(s).para(p).essai(e).(mark{m});
                
                else
                    
                    
                    coda_all_interp(s).para(p).essai(e).(mark{m}) = fillgapspline(coda_all_essai(s).para(p).essai(e).(mark{m})'); % interpolation (xyz en ligne pour fonction)

                    coda_all_interp(s).para(p).essai(e).(mark{m}) = coda_all_interp(s).para(p).essai(e).(mark{m})'; % transposition en colonne après fonction
                  
                    
%                     subplot(3,2,m-3)
%                     plot(coda_all_interp(s).para(p).essai(e).(mark{m}),'r')
%                     hold on
%                     plot(coda_all_essai(s).para(p).essai(e).(mark{m}),'k')
%                     title(['sujet ' num2str(s) ' para ' num2str(p) ' essai ' num2str(e) ' ' mark{m}])
%                 
                end
   


            end


        end
    end
    disp s
end

%%

coda_all = coda_all_interp;

% end