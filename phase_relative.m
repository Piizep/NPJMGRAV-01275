%% ------------------ Calcul phase relative hanche cheville ---------------------------
% voir méthode de bardy ou Hamill, Palmer and Von Emmerik, 2012

clc; clear all; close all

%%
load('angles_norm_Y.mat')
load('protocole.mat')

%%

c = 0;
% phase_relat_line = protocole;



for s = 1:9
             
    for p = 1:10
               
        for e = 1:size(angles_norm_Y(s).para(p).essai,2)
            
            %% Hanche-Cheville
                       
                phase_relat(s).para(p).essai(e).hanche_cheville = atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_cheville),angles_norm_Y(s).para(p).essai(e).angle_cheville) - atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_hanche),angles_norm_Y(s).para(p).essai(e).angle_hanche);

                phase_relat(s).para(p).essai(e).hanche_cheville = abs(phase_relat(s).para(p).essai(e).hanche_cheville);

                phase_relat(s).para(p).essai(e).hanche_cheville = wrapTo360(phase_relat(s).para(p).essai(e).hanche_cheville);

                phase_relat(s).para(p).essai(e).hanche_cheville(phase_relat(s).para(p).essai(e).hanche_cheville>270) = 360 - phase_relat(s).para(p).essai(e).hanche_cheville(phase_relat(s).para(p).essai(e).hanche_cheville>270);

                phase_relat(s).para(p).essai(e).hanche_cheville(phase_relat(s).para(p).essai(e).hanche_cheville>180) = 180 -(phase_relat(s).para(p).essai(e).hanche_cheville(phase_relat(s).para(p).essai(e).hanche_cheville>180)-180);
                                        

%%
% figure;
% % 
% subplot(2,1,1)
% hold on
% plot(angles_norm_Y(s).para(p).essai(e).angle_cheville)
% plot(angles_norm_Y(s).para(p).essai(e).angle_hanche)
% legend('Ankle', 'Hip')
% ylabel('Normalized Angle')
%  
% subplot(2,1,2)
% plot(phase_relat(s).para(p).essai(e).hanche_cheville)
% 
% xlabel('Normalized time')
% ylabel('Continue Relative Phase (deg)')

            %% Hanche-Cheville/hanche
                       
                phase_relat(s).para(p).essai(e).hanche_cheville_hanche = atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_cheville_hanche),angles_norm_Y(s).para(p).essai(e).angle_cheville_hanche) - atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_hanche),angles_norm_Y(s).para(p).essai(e).angle_hanche);

                phase_relat(s).para(p).essai(e).hanche_cheville_hanche = abs(phase_relat(s).para(p).essai(e).hanche_cheville_hanche);

                phase_relat(s).para(p).essai(e).hanche_cheville_hanche = wrapTo360(phase_relat(s).para(p).essai(e).hanche_cheville_hanche);

                phase_relat(s).para(p).essai(e).hanche_cheville_hanche(phase_relat(s).para(p).essai(e).hanche_cheville_hanche>270) = 360 - phase_relat(s).para(p).essai(e).hanche_cheville_hanche(phase_relat(s).para(p).essai(e).hanche_cheville_hanche>270);

                phase_relat(s).para(p).essai(e).hanche_cheville_hanche(phase_relat(s).para(p).essai(e).hanche_cheville_hanche>180) = 180 -(phase_relat(s).para(p).essai(e).hanche_cheville_hanche(phase_relat(s).para(p).essai(e).hanche_cheville_hanche>180)-180);
                                        

%%
% figure;
% % 
% subplot(2,1,1)
% hold on
% plot(angles_norm_Y(s).para(p).essai(e).angle_cheville_hanche)
% plot(angles_norm_Y(s).para(p).essai(e).angle_hanche)
% legend('Ankle to Hip', 'Hip')
% ylabel('Normalized Angle')
% 
% subplot(2,1,2)
% plot(phase_relat(s).para(p).essai(e).hanche_cheville_hanche)
% 
% xlabel('Normalized time')
% ylabel('Continue Relative Phase (deg)')

%% Hanche-Genou
                phase_relat(s).para(p).essai(e).hanche_genou = atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_genou),angles_norm_Y(s).para(p).essai(e).angle_genou) - atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_hanche),angles_norm_Y(s).para(p).essai(e).angle_hanche);

                phase_relat(s).para(p).essai(e).hanche_genou = abs(phase_relat(s).para(p).essai(e).hanche_genou);

                phase_relat(s).para(p).essai(e).hanche_genou = wrapTo360(phase_relat(s).para(p).essai(e).hanche_genou);

                phase_relat(s).para(p).essai(e).hanche_genou(phase_relat(s).para(p).essai(e).hanche_genou>270) = 360 - phase_relat(s).para(p).essai(e).hanche_genou(phase_relat(s).para(p).essai(e).hanche_genou>270);

                phase_relat(s).para(p).essai(e).hanche_genou(phase_relat(s).para(p).essai(e).hanche_genou>180) = 180 -(phase_relat(s).para(p).essai(e).hanche_genou(phase_relat(s).para(p).essai(e).hanche_genou>180)-180);
                                        

%%
% figure;
% % 
% subplot(2,1,1)
% hold on
% plot(angles_norm_Y(s).para(p).essai(e).angle_genou)
% plot(angles_norm_Y(s).para(p).essai(e).angle_hanche)
% legend('Knee', 'Hip')
% ylabel('Normalized Angle')
% 
% subplot(2,1,2)
% plot(phase_relat(s).para(p).essai(e).hanche_genou)
% 
% xlabel('Normalized time')
% ylabel('Continue Relative Phase (deg)')





%% Cheville-Genou
                phase_relat(s).para(p).essai(e).cheville_genou = atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_genou),angles_norm_Y(s).para(p).essai(e).angle_genou) - atan2d(gradient(angles_norm_Y(s).para(p).essai(e).angle_cheville),angles_norm_Y(s).para(p).essai(e).angle_cheville);

                phase_relat(s).para(p).essai(e).cheville_genou = abs(phase_relat(s).para(p).essai(e).cheville_genou);

                phase_relat(s).para(p).essai(e).cheville_genou = wrapTo360(phase_relat(s).para(p).essai(e).cheville_genou);

                phase_relat(s).para(p).essai(e).cheville_genou(phase_relat(s).para(p).essai(e).cheville_genou>270) = 360 - phase_relat(s).para(p).essai(e).cheville_genou(phase_relat(s).para(p).essai(e).cheville_genou>270);

                phase_relat(s).para(p).essai(e).cheville_genou(phase_relat(s).para(p).essai(e).cheville_genou>180) = 180 -(phase_relat(s).para(p).essai(e).cheville_genou(phase_relat(s).para(p).essai(e).cheville_genou>180)-180);
                                        

%%
% figure;
% % 
% subplot(2,1,1)
% hold on
% plot(angles_norm_Y(s).para(p).essai(e).angle_genou)
% plot(angles_norm_Y(s).para(p).essai(e).angle_cheville)
% legend('Knee', 'Hip')
% ylabel('Normalized Angle')
% 
% subplot(2,1,2)
% plot(phase_relat(s).para(p).essai(e).cheville_genou)
% 
% xlabel('Normalized time')
% ylabel('Continue Relative Phase (deg)')

%% in line


%             c = c+1;
% %             
% %            
%             phase_relat_line(c).hanche_cheville = phase_relat(s).para(p).essai(e).hanche_cheville';
%             phase_relat_line(c).hanche_cheville_hanche = phase_relat(s).para(p).essai(e).hanche_cheville_hanche';
%             phase_relat_line(c).hanche_genou = phase_relat(s).para(p).essai(e).hanche_genou';
%             phase_relat_line(c).cheville_genou = phase_relat(s).para(p).essai(e).cheville_genou';
% 
% 
% 
% 
%   



        end
    end
end





%% méthode calcul phase relative en continue

% clear all
% close all 
% 
% % création des signaux 
% 
% cos_pi = cos((1*-pi:0.01:1*pi)+1.5);
% sin_pi = sin((1*-pi:0.01:1*pi));
% 
% 
% % portait de phase
% 
% v_cos_pi = gradient(cos_pi);
% v_sin_pi = gradient(sin_pi);
% 
% figure;
% subplot(4,2,1)
% plot(v_cos_pi,cos_pi)
% title('Portrait de phase')
% 
% subplot(4,2,2)
% plot(v_sin_pi,sin_pi)
% title('Portrait de phase')
% 
% 
% 
% 
% % phase angle
% 
% PA_cos = atan2d(v_cos_pi,cos_pi);
% PA_sin = atan2d(v_sin_pi,sin_pi);
% 
% 
% subplot(4,2,3)
% plot(PA_cos)
% title('Phase angulaire')
% 
% 
% subplot(4,2,4)
% plot(PA_sin)
% title('Phase angulaire')
% 
% 
% 
% 
% % Continue relative phase
% 
% phase_relat_sin_cos = PA_cos - PA_sin;

% % Correction probleme des 4 cadres (360° to 180°)
% 
% phase_relat_sin_cos = abs(phase_relat_sin_cos);
% 
% phase_relat_sin_cos = wrapTo360(phase_relat_sin_cos);
% 
% phase_relat_sin_cos(phase_relat_sin_cos>270) = 360-phase_relat_sin_cos(phase_relat_sin_cos>270);
% 
% phase_relat_sin_cos(phase_relat_sin_cos>180) = 180-(phase_relat_sin_cos(phase_relat_sin_cos>180)-180);
% 
% subplot(4,2,[5 6])
% hold on
% plot(cos_pi,'b')
% plot(sin_pi,'r')
% title('Signal')
% 
% 
% subplot(4,2,[7 8])
% plot(phase_relat_sin_cos)
% title('Phase relative continue')
% 
% 
