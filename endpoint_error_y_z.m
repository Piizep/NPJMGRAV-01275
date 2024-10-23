%% ------------------ Endpoint error ---------------------------
% calcul ecart à la cible y et z
% importation de la position des cibles (calibration) pour chaque
% participant

load('coda_cut.mat')
load('cine_cut.mat')
load('calib_cibles.mat')
load('protocole.mat')

%%

for s = 1:9
    
    % moyenne de la valeur z de Tfar et Tclose pour différencier les cibles
    % par la suite
    entre_2_cibles = mean([calib_cible(s).Tclose(3),calib_cible(s).Tfar(3)]);
    
    for p = 1:10
        
        for e = 1:size(coda_cut(s).para(p).essai,2)
            
            if isempty(coda_cut(s).para(p).essai(e).Index) % si pas données coda alors NaN
                
                endpoint_error(s).para(p).essai(e).ecart_z = NaN;
                endpoint_error(s).para(p).essai(e).ecart_y = NaN;
                
            else
                         
                if coda_cut(s).para(p).essai(e).Index(end,3) < entre_2_cibles % si valeur final index < à la moyenne Tfar + Tclose

                    % alors c'est la cible la plus basse (Tfar)
                    endpoint_error(s).para(p).essai(e).ecart_z = coda_cut(s).para(p).essai(e).Index(end,3)-calib_cible(s).Tfar(3);
                    endpoint_error(s).para(p).essai(e).ecart_y = coda_cut(s).para(p).essai(e).Index(end,2)-calib_cible(s).Tfar(2);

                else % sinon Tclose

                    endpoint_error(s).para(p).essai(e).ecart_z = coda_cut(s).para(p).essai(e).Index(end,3)-calib_cible(s).Tclose(3);
                    endpoint_error(s).para(p).essai(e).ecart_y = coda_cut(s).para(p).essai(e).Index(end,2)-calib_cible(s).Tclose(2);

                end
            end
            
        
        end
    end
end 