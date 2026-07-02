%Diffusion Drift Model (DDM) Simulation of a 5-Step Speech Continuum (/ba/ to /pa/) (Pisoni & Tash, Perception and Psychophysics, 1974).  
% Model inspired by:
% Ratcliff, R., & McKoon, G. (2008). The diffusion decision model: Theory and data for two-choice decision tasks. Neural Computation, 20(4), 873–922.
%
% Author: Gavin Bidelman, PhD [7/2/26] gbidel@iu.edu
%
clear all; clc; close all; 


% 1. Global Parameters (Shared)
nTrialsPerStep = 500;       % Number of trials per continuum step
dt = 0.001;                 % Time step size (1 ms)
maxTime = 2.0;              % Maximum trial duration (2 seconds)
tSteps = maxTime / dt;      % Max discrete time steps per trial
c = 0.1;                    % Within-trial diffusion noise coefficient

% 2. Set DDM params---------
%Parameters to simulate VOWEL labeling*******
a_classic = 0.12;           % Boundary separation
ter_classic = 0.250;        % Mean non-decision time
s_ter_classic = 0.060;      % Non-decision variability
s_v_classic = 0.08;         % Drift variability
drift_classic = [-0.4, -0.18, 0.0, 0.18, 0.4]; % Inverted-V drift profile
% Ambiguous tokens have drift rates near zero, causing prolonged evidence accumulation.
% Negative values → evidence accumulates toward the lower (/ba/) boundary.
% Positive values → evidence accumulates toward the upper (/pa/) boundary.
% Larger absolute values (v) → faster accumulation.
% Values near zero → slow accumulation, more diffusion-driven decisions.

%Parameters to simulate CV labeling*******
a_flat = a_classic;       %same params as above; only drift rates differ      
ter_flat=ter_classic;
s_ter_flat = s_ter_classic;         
s_v_flat = s_v_classic;    
drift_flat = [-0.6, -0.6, 0.6, 0.6, 0.6]; % Uniform high-speed drift profile 
%-------------------------------------

meanRTs_classic = zeros(1, 5);
percentPa_classic = zeros(1, 5);
allRTs_classic = cell(1, 5);

%rng(42); % Seed for exact across-mode reproducibility
for step = 1:5
    v_mean = drift_classic(step); 
    stepRTs = zeros(nTrialsPerStep, 1);
    stepChoices = zeros(nTrialsPerStep, 1); 
    
    for trial = 1:nTrialsPerStep
        v_trial = v_mean + s_v_classic * randn();
        ter_trial = (ter_classic - s_ter_classic/2) + s_ter_classic * rand();
        evidence = a_classic / 2;
        rt = maxTime; choice = NaN;
        
        for t = 1:tSteps
            evidence = evidence + v_trial * dt + c * sqrt(dt) * randn();
            if evidence >= a_classic
                rt = t * dt + ter_trial; choice = 1; break;
            elseif evidence <= 0
                rt = t * dt + ter_trial; choice = 0; break;
            end
        end
        stepRTs(trial) = rt; stepChoices(trial) = choice;
    end
    allRTs_classic{step} = stepRTs;
    meanRTs_classic(step) = mean(stepRTs);
    percentPa_classic(step) = (sum(stepChoices == 1) / nTrialsPerStep) * 100;
end

% 3. Run Condition 2: Flat Configuration
% Storage arrays for flat condition
meanRTs_flat = zeros(1, 5);
percentPa_flat = zeros(1, 5);
allRTs_flat = cell(1, 5);

rng(42); % Re-seed for consistency
for step = 1:5
    v_mean = drift_flat(step); 
    stepRTs = zeros(nTrialsPerStep, 1);
    stepChoices = zeros(nTrialsPerStep, 1); 
    
    for trial = 1:nTrialsPerStep
        v_trial = v_mean + s_v_flat * randn();
        ter_trial = (ter_flat - s_ter_flat/2) + s_ter_flat * rand();
        evidence = a_flat / 2;
        rt = maxTime; choice = NaN;
        
        for t = 1:tSteps
            evidence = evidence + v_trial * dt + c * sqrt(dt) * randn();
            if evidence >= a_flat
                rt = t * dt + ter_trial; choice = 1; break;
            elseif evidence <= 0
                rt = t * dt + ter_trial; choice = 0; break;
            end
        end
        stepRTs(trial) = rt; stepChoices(trial) = choice;
    end
    allRTs_flat{step} = stepRTs;
    meanRTs_flat(step) = mean(stepRTs);
    percentPa_flat(step) = (sum(stepChoices == 1) / nTrialsPerStep) * 100;
end


%%
figure;
set(gcf, 'Units', 'normalized','position',[0.3 0.2 0.4 0.5]);

% --- ROW 1: CLASSIC MODEL OUTPUTS ---
subplot(2, 2, 1);
plot(1:5, percentPa_classic, '-o', 'LineWidth', 2, 'Color', rgb('IndianRed'), 'MarkerFaceColor',rgb('IndianRed'), 'MarkerSize', 6);
xlim([0.5, 5.5]); ylim([-5, 105]); %grid on;
set(gca, 'XTick', 1:5, 'XTickLabel', {'S1 (/ba/)', 'S2', 'S3', 'S4', 'S5 (/pa/)'});
ylabel('Percent /pa/ (%)'); %title('A. Classic Psychometric Function');

% Subplot 2: Classic Inverted-V RT Curve
subplot(2, 2, 2); hold on;
for step = 1:5
    jitter = (rand(nTrialsPerStep, 1) - 0.5) * 0.18;
    scatter(step + jitter, allRTs_classic{step} * 1000, 3, [0.75 0.75 0.75], 'filled', 'MarkerFaceAlpha', 0.12);
end
plot(1:5, meanRTs_classic * 1000, '-s', 'LineWidth', 2.5, 'Color', rgb('IndianRed'), 'MarkerFaceColor',rgb('IndianRed'), 'MarkerSize', 7);
xlim([0.5, 5.5]); ylim([150, 950]); %grid on;
set(gca, 'XTick', 1:5, 'XTickLabel', {'S1', 'S2', 'S3', 'S4', 'S5'});
ylabel('RT (ms)'); %title('B. Classic Chronometric Curve (Inverted-V)');

% --- ROW 2: FLAT MODEL OUTPUTS ---
% Subplot 3: Flat Model Categorization
subplot(2, 2, 3);
plot(1:5, percentPa_flat, '-o', 'LineWidth', 2, 'Color',  rgb('DodgerBlue'), 'MarkerFaceColor',  rgb('DodgerBlue'), 'MarkerSize', 6);
xlim([0.5, 5.5]); ylim([-5, 105]); %grid on;
set(gca, 'XTick', 1:5, 'XTickLabel', {'S1 (/ba/)', 'S2', 'S3', 'S4', 'S5 (/pa/)'});
xlabel('Continuum Step'); ylabel('Percent /pa/ (%)'); %title('C. Flat Model Psychometric Function');

% Subplot 4: Flat Model Uniform RT Curve
subplot(2, 2, 4); hold on;
for step = 1:5
    jitter = (rand(nTrialsPerStep, 1) - 0.5) * 0.18;
    scatter(step + jitter, allRTs_flat{step} * 1000, 3, [0.75 0.75 0.75], 'filled', 'MarkerFaceAlpha', 0.12);
end
plot(1:5, meanRTs_flat * 1000, '-s', 'LineWidth', 2.5, 'Color',  rgb('DodgerBlue'), 'MarkerFaceColor',  rgb('DodgerBlue'), 'MarkerSize', 7);
xlim([0.5, 5.5]); ylim([150, 950]);% grid on; % Kept Y-Axis matched to Row 1 for clear scaling comparison
set(gca, 'XTick', 1:5, 'XTickLabel', {'S1', 'S2', 'S3', 'S4', 'S5'});
xlabel('Continuum Step'); ylabel('RT (ms)'); %title('D. Flat Model Chronometric Curve (Uniform)');

sgtitle('Diffusion model simlations of vowel (top) vs. CV (bottom) identification', 'FontSize', 12, 'FontWeight', 'bold');


ylim([200 800])
fontsize(8,'points')

%%
%Plot 20 trajectories from a single continuum step
figure;
set(gcf, 'Units', 'normalized','position',[0.05 0.2 0.85 0.2]);

nPlotTrials = 20;
v_mean = 0; % Token 3
a = a_classic;  
 
for step = 1:5
    subplot(1,5,step)
    hold on
    v_mean = drift_classic(step);

    for tr = 1:nPlotTrials
        v_trial = v_mean + s_v_classic*randn();
        evidence = a_classic/2;
        x = 0;
        y = evidence;

        for t = 1:tSteps
            evidence = evidence + v_trial*dt + c*sqrt(dt)*randn();
            x(end+1) = t*dt;
            y(end+1) = evidence;

            if evidence >= a_classic || evidence <= 0
                break
            end
        end
        plot(x,y)
    end

    yline(a_classic,'k--'); yline(0,'k--')
    title(sprintf('S%d',step))
    ylim([-0.02 a_classic+0.02]);
    xlim([0 1.2])

end

yline(a,'r--','Upper Bound')
yline(0,'b--','Lower Bound')
xlabel('Time (s)')
ylabel('Accumulated Evidence')

figure
step = 3;

subplot(1,2,1)
hold on
title('Classic S3')

for tr = 1:20
    evidence = a_classic/2;
    v_trial = drift_classic(step) + s_v_classic*randn();
    x = 0;
    y = evidence;

    for t = 1:tSteps
        evidence = evidence + v_trial*dt + c*sqrt(dt)*randn();
        x(end+1) = t*dt;
        y(end+1) = evidence;
        if evidence>=a_classic || evidence<=0
            break
        end
    end
    plot(x,y);
    xlim([0 1])
end

yline(a_classic,'k--')
yline(0,'k--')

subplot(1,2,2)
hold on
title('Flat S3')

for tr = 1:20
    evidence = a_flat/2;
    v_trial = drift_flat(step) + s_v_flat*randn();
    x = 0;
    y = evidence;

    for t = 1:tSteps
        evidence = evidence +  v_trial*dt +  c*sqrt(dt)*randn();
        x(end+1) = t*dt;
        y(end+1) = evidence;

        if evidence>=a_flat || evidence<=0
            break
        end
    end
    plot(x,y);
     xlim([0 1])
      
end

yline(a_flat,'k--')
yline(0,'k--')


%tracts color coded figure
figure
hold on

step = 3;
N = 500;

allRT = zeros(N ,1);
trajX = cell(N,1);
trajY = cell(N,1);

for tr = 1:N
    evidence = a_classic/2;
    v_trial = drift_classic(step) +s_v_classic*randn();
    x = 0;
    y = evidence;

    for t = 1:tSteps
        evidence = evidence + v_trial*dt +  c*sqrt(dt)*randn();
        x(end+1) = t*dt;
        y(end+1) = evidence;

        if evidence>=a_classic || evidence<=0
            allRT(tr) = t*dt;
            break
        end
    end
    trajX{tr}=x;
    trajY{tr}=y;
end

cmap = turbo(256);
rtNorm = rescale(allRT,1,256);

for tr = 1:N
    clr = cmap(round(rtNorm(tr)),:);
    plot(trajX{tr},trajY{tr},'Color',[clr 0.15])
end

yline(a_classic,'k--')
yline(0,'k--')

cb = colorbar;
cb.Label.String = 'Decision Time';

xlabel('Time (s)')
ylabel('Evidence')
title('Classic Model S3: Trajectories Colored by RT')

%%
%animate single trial trajectory

%{
figure;
drawnow;

v_trial = 0.18;
evidence = a_classic/2;

for t = 1:tSteps
    evidence = evidence + v_trial*dt + c*sqrt(dt)*randn();

    plot(t*dt,evidence,'bo')
    hold on

    yline(a_classic,'r--')
    yline(0,'b--')
    xlim([0 1.0])
    ylim([-0.02 a_classic+0.02])

    drawnow
    if evidence>=a_classic || evidence<=0
        break
    end
end


%}





