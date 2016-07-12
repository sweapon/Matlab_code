%% Created by Bent O. Arnesen, Summer 2016, NTNU

%Creates a box in which you can place arbitrary text.
%Box position and size can be chosen as desired.

% Probably works best if written as a function with box position (and size)
% as input, together with the function in which you want to plot the text. 
% For plotting into the current figure, use "gcf" as input argument.

figure();
clf;
hold on;
set(0, 'defaultfigurewindowstyle', 'docked');

%Create the box
pos = [0.4 0.2 0.22 0.14];
axes('position',pos); set(gca,'box','on')

%Set axis limits for the box to "blank"
set(gca,'xtick',[],'xticklabel',[],'ytick',[],'yticklabel',[])

%Insert text into box
delta = 0.5;
txt_delta = strcat('\Delta     = ', '{ }', num2str(delta), 'm');
R_acc = 0.2;
txt_Racc = strcat('R_{acc} =', '{ }', num2str(R_acc), 'm');

%Write the text
text(0.05,0.5,{txt_delta, txt_Racc})