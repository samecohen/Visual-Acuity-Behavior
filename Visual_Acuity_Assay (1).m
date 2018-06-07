%% Visual Acuity Behavioral Assay 
close all;
clear all;

% Set up 4 different spatial frequencies of counterphase gratings
Screen('Preference', 'SkipSyncTests', 1);

% Define arena space
screen_size = [1400, 770];

% TO DO: figure out whether simply reducing the grating width suffices

% Spatial frequency 1
grating_width1 = 7; %pixels
num_bars1 = round(screen_size(1)/grating_width1);

% Spatial Frequency 2
grating_width2 = 5;
num_bars2 = round(screen_size(1)/grating_width2);

% Spatial Frequency 3
grating_width3 = 3;
num_bars3 = round(screen_size(1)/grating_width3);

% Spatial Frequency 4
grating_width4 = 1.5;
num_bars4 = round(screen_size(1)/grating_width4);

%Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
%JN = switched to 1: max(screens)
screenNumber = 1;

% Define black and white 
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
gray = white/2;
% Adjust above parameters to change bar/background colors

% Generate timing information for flipping grating back and forth
% NOTE: counterphase appears after static phase
init_blank_time = 0;	% initial blank time (sec)
final_blank_time = 0;	% blank time at end (sec)
flicker_freq = 4;	%flicker frequency for full black-white cycle (hz)
stim_dur = 4;	% length of stimulus alternation (sec)
nalts = stim_dur*flicker_freq;	% number of alterations
% Adjust stim_dur to change number of counterphasings

% Open an on screen window 
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); 

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect (generate bar)
baseRect1 = [-500 0 grating_width1 screen_size(1,2)];
baseRect2 = [-500 0 grating_width2 screen_size(1,2)];
baseRect3 = [-500 0 grating_width3 screen_size(1,2)];
baseRect4 = [-500 0 grating_width4 screen_size(1,2)];

% Screen X positions of our multiple
% This should represent the center of where you want the rectangle in X (so
% for 2 squares, you want 0.25 and 0.75 of screen width, not 0 and .5).

% For spatial freq 1
for i = 1:num_bars1
    squareXpos1(1,i) = (xCenter-(screen_size(1,2)/2))+(grating_width1*i);
end 
numSquares1 = length(squareXpos1);

% For spatial freq 2
for i = 1:num_bars2
    squareXpos2(1,i) = (xCenter-(screen_size(1,2)/2))+(grating_width2*i);
end 
numSquares2 = length(squareXpos2);

% For spatial freq 3
for i = 1:num_bars3
    squareXpos3(1,i) = (xCenter-(screen_size(1,2)/2))+(grating_width3*i);
end 
numSquares3 = length(squareXpos3);

% For spatial freq 4
for i = 1:num_bars4
    squareXpos4(1,i) = (xCenter-(screen_size(1,2)/2))+(grating_width4*i);
end 
numSquares4 = length(squareXpos4);

% Set the colors to 75% contrast
% This is a vertical matrix - a square's color is set by the column, so it
% must have number of columns = number of squares.

% Spatial freq 1
for j=1:num_bars1
    if mod(j,2) == 0 % even
        allColorsFirst1_100(:,j) = [0.2; 0.2; 0.2];
    else %odd
        allColorsFirst1_100(:,j) = [0.8; 0.8; 0.8];
    end
end
% Grating 2 (opposite phase)
for j=1:num_bars1
    if mod(j,2) == 0 % odd
        allColorsSecond1_100(:,j) = [0.8; 0.8; 0.8];
    else %odd
        allColorsSecond1_100(:,j) = [0.2; 0.2; 0.2];
    end
end

% Spatial freq 2
for j=1:num_bars2
    if mod(j,2) == 0 % even
        allColorsFirst2_100(:,j) = [0.2; 0.2; 0.2];
    else %odd
        allColorsFirst2_100(:,j) = [0.8; 0.8; 0.8];
    end
end
% Grating 2 (opposite phase)
for j=1:num_bars2
    if mod(j,2) == 0 % odd
        allColorsSecond2_100(:,j) = [0.8; 0.8; 0.8];
    else %odd
        allColorsSecond2_100(:,j) = [0.2; 0.2; 0.2];
    end
end

% Spatial freq 3
for j=1:num_bars3
    if mod(j,2) == 0 % even
        allColorsFirst3_100(:,j) = [0.2; 0.2; 0.2];
    else %odd
        allColorsFirst3_100(:,j) = [0.8; 0.8; 0.8];
    end
end
% Grating 2 (opposite phase)
for j=1:num_bars3
    if mod(j,2) == 0 % odd
        allColorsSecond3_100(:,j) = [0.8; 0.8; 0.8];
    else %odd
        allColorsSecond3_100(:,j) = [0.2; 0.2; 0.2];
    end
end

% Spatial freq 4
for j=1:num_bars4
    if mod(j,2) == 0 % even
        allColorsFirst4_100(:,j) = [0.2; 0.2; 0.2];
    else %odd
        allColorsFirst4_100(:,j) = [0.8; 0.8; 0.8];
    end
end
% Grating 2 (opposite phase)
for j=1:num_bars4
    if mod(j,2) == 0 % odd
        allColorsSecond4_100(:,j) = [0.8; 0.8; 0.8];
    else %odd
        allColorsSecond4_100(:,j) = [0.2; 0.2; 0.2];
    end
end

% Make our rectangle coordinates

% Rectangle 1
allRects1 = nan(4, num_bars1);
for i = 1:numSquares1
    allRects1(:, i) = CenterRectOnPointd(baseRect1, squareXpos1(i), yCenter);
end

% Rectangle 2
allRects2 = nan(4, num_bars2);
for i = 1:numSquares2
    allRects2(:, i) = CenterRectOnPointd(baseRect2, squareXpos2(i), yCenter);
end

% Rectangle 3
allRects3 = nan(4, num_bars3);
for i = 1:numSquares3
    allRects3(:, i) = CenterRectOnPointd(baseRect3, squareXpos3(i), yCenter);
end

% Rectangle 4
allRects4 = nan(4, num_bars4);
for i = 1:numSquares4
    allRects4(:, i) = CenterRectOnPointd(baseRect4, squareXpos4(i), yCenter);
end

% Trial Parameters

% 4 input spatial frequencies presented at random 
numStim = 4; 
reps = 12; % Adjust this parameter to change the number of stim reps

% Present stimuli
start=tic;
% NOTE: Modify block below -- should start with gray background (5 sec?)
% instead of 100% contrast gratings
Screen('FillRect', window, gray, allRects1);
Screen('flip', window);
WaitSecs(5); % pauses after warning sign, allows time to insert tadpole and close tent
freqLog={}; % set up variable to store the order of stimuli
timeLog=[]; % set up variable to store the time elapsed from LED light

% NOTE: For stimuli presentation, have static bars hold for some amount
% of time, then start counterphasing 

% Will be "rest" (i.e. gray screen) in between each different stimulus type
% Rest period lasts for 30 seconds

% For now, static condition is commented out for each stimulus type
for i = 1:reps
    p = randperm(numStim); % Randomize stimulize order within each rep
    for j = 1:numStim;
        if p(j) == 1 % Spatial freq 1
            %{
            timeLog=[timeLog toc(start)];
            Screen('FillRect', window, allColorsFirst1_100, allRects1);
            Screen('flip', window);
            WaitSecs(5); % For now, hold static gratings for 5 sec
            %}
            % Counterphase
            for i=1:nalts/2
                Screen('FillRect', window, allColorsFirst1_100, allRects1);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
                Screen('FillRect', window, allColorsSecond1_100, allRects1);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
            end
            Screen('FillRect', window, gray, allRects1); 
            Screen('flip', window);
            WaitSecs(30);
        elseif p(j) == 2 % Spatial freq 2
            %{
            timeLog=[timeLog toc(start)];
            Screen('FillRect', window, allColorsFirst2_100, allRects2);
            Screen('flip', window);
            WaitSecs(5); % For now, hold static gratings for 5 sec
            %}
            % Counterphase
            for i=1:nalts/2
                Screen('FillRect', window, allColorsFirst2_100, allRects2);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
                Screen('FillRect', window, allColorsSecond2_100, allRects2);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
            end
            Screen('FillRect', window, gray, allRects1); 
            Screen('flip', window);
            WaitSecs(30);
        elseif p(j) == 3 % Spatial freq 3
            %{
            timeLog=[timeLog toc(start)];
            Screen('FillRect', window, allColorsFirst3_100, allRects3);
            Screen('flip', window);
            WaitSecs(5); % For now, hold static gratings for 5 sec
            %}
            % Counterphase
            for i=1:nalts/2
                Screen('FillRect', window, allColorsFirst3_100, allRects3);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
                Screen('FillRect', window, allColorsSecond3_100, allRects3);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
            end
            Screen('FillRect', window, gray, allRects1); 
            Screen('flip', window);
            WaitSecs(30);
        elseif p(j) == 4 % Spatial freq 4
            %{
            timeLog=[timeLog toc(start)];
            Screen('FillRect', window, allColorsFirst4_100, allRects4);
            Screen('flip', window);
            WaitSecs(5); % For now, hold static gratings for 5 sec
            %}
            % Counterphase
            for i=1:nalts/2
                Screen('FillRect', window, allColorsFirst4_100, allRects4);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
                Screen('FillRect', window, allColorsSecond4_100, allRects4);
                Screen('flip', window);
                WaitSecs(1/flicker_freq);
            end
            Screen('FillRect', window, gray, allRects1); 
            Screen('flip', window);
            WaitSecs(30);
        end
    end
end
Screen('CloseAll')