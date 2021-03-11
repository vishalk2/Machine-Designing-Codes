function [sigma_r,sigma_t,sigma_l] = Pressure_Vessel(t,Di,Pi)
    Do = Di + 2*t;
    r = (Di/2):10:((Di/2)+t);
    if (t/Di) < 0.1
        fprintf('Thin Pressure Vessel is required.');
        sigma_r = 0; % Radial Stress
        sigma_t = Pi*Di/(2*t); % Hoop / Circumferential Stress
        sigma_l = Pi*Di/(4*t); % Longitudinal Stress
        
    else
        fprintf('Thick Pressure Vessel is required.')
        sigma_r = (-Pi*(Di^2)/(Do^2 - Di^2))*(((Do^2)./(4*(r.^2)))-1);
        sigma_t = (Pi*(Di^2)/(Do^2 - Di^2))*(((Do^2)./(4*(r.^2)))+1);
        sigma_l = (Pi*(Di^2)/(Do^2 - Di^2));
        
        % Plotting
        figure(1);
        
        % x & y axes
        x = linspace(-(Do/2)-50,(Do/2)+50,100);
        y = linspace(-(Do/2)-50,(Do/2)+50,100);
        z = zeros(1,100);
        X = plot(x,z,'--',"Color","black"); XL = "x-axis";
        hold on
        Y = plot(z,y,'--',"Color","black"); YL = "y-axis";
        
        % Inner and Outer Circles
        theta = 0:pi/50:2*pi;
        % Inner Circle
        IC = plot((Di/2)*cos(theta),(Di/2)*sin(theta),"Color","red"); ICL="Inner Circle";
        % Outer Circle
        OC = plot((Do/2)*cos(theta),(Do/2)*sin(theta),"Color","red"); OCL="Outer Circle";
        
        xlim([-(Do/2)-50,(Do/2)+50])
        ylim([-(Do/2)-50,(Do/2)+50])
        title('Variation of Radial & Hoop Stresses with r')
        
        % Stresses variation with r
        SR = plot(-r,sigma_r,"Color","blue","LineWidth",2); SRL = "Radial Stress";
        ST = plot(r,sigma_t,"Color","yellow","LineWidth",2); STL = "Hoop Stress";
        hold off
        % Adding Legend
        legend([X,Y,IC,OC,SR,ST],[XL,YL,ICL,OCL,SRL,STL],"Location","bestoutside")
        
        figure(2);
        subplot(1,2,1);
        plot(-r,sigma_r,'o-',"Color","blue");
        xlim([-(Do/2)-20,-(Di/2)+20])
        ylim([min(sigma_r)-15,max(sigma_r)+15])
        xlabel('r'),ylabel('Sigma r'),title('Radial Stress VS r');
        subplot(1,2,2);
        plot(r,sigma_t,'o-',"Color","yellow");
        xlim([(Di/2)-20,(Do/2)+20])
        ylim([min(sigma_t)-15,max(sigma_t)+15])
        xlabel('r'),ylabel('Sigma t'),title('Hoop Stress VS r');
end