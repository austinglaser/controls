%% Clear out everything
clear all
close all
clc

%% Bring in Data
load('data_combined_new.mat')

%% Extract relevant experiments
%[2 (3)  4  6 7]
%[2 (3)  5  6 7]
%[2 (3) (5) 6 7]
experiments_top = [2 4 6 7];      % Which experiments to use for top
experiments_mid = [2 5 6 7];        % Which experiments to use for middle
experiments_bot = [2];      % Which experiments to use for bottom

name_comb_top   = name_comb_top(:,experiments_top);
name_comb_mid   = name_comb_mid(:,experiments_mid);
name_comb_bot   = name_comb_bot(:,experiments_bot);

y_comb_top      = y_comb_top(:,experiments_top);
y_comb_mid      = y_comb_mid(:,experiments_mid);
y_comb_bot      = y_comb_bot(:,experiments_bot);

u_comb_top      = u_comb_top(:,experiments_top);
u_comb_mid      = u_comb_mid(:,experiments_mid);
u_comb_bot      = u_comb_bot(:,experiments_bot);

intr_smpl_val_top = repmat({'zoh'}, size(name_comb_top));
intr_smpl_val_mid = repmat({'zoh'}, size(name_comb_mid));
intr_smpl_val_bot = repmat({'zoh'}, size(name_comb_bot));

%% Create Objects
u_t_id_top = iddata(y_comb_top,u_comb_top,[],'ExperimentName',name_comb_top,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val_top,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
u_t_id_mid = iddata(y_comb_mid,u_comb_mid,[],'ExperimentName',name_comb_mid,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val_mid,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
u_t_id_bot = iddata(y_comb_bot,u_comb_bot,[],'ExperimentName',name_comb_top,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val_bot,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
opt = compareOptions('InitialCondition','zero');

%% Black Box Identification
iodelay = NaN;
TF_top_est=tfest(u_t_id_top,6,5,iodelay,'Feedthrough','false');
TF_mid_est=tfest(u_t_id_mid,6,5,iodelay,'Feedthrough','false');
TF_bot_est=tfest(u_t_id_bot,6,5,iodelay,'Feedthrough','false');

%% Comparison for Black Box
figure(1)
compare(u_t_id_top,TF_top_est,Inf,opt)
figure(2)
compare(u_t_id_mid,TF_mid_est,Inf,opt)
figure(3)
compare(u_t_id_bot,TF_bot_est,Inf,opt)
par = getpvec(TF_top_est)
%advice(uin_tin_id);
%% Grey Box Identification
%{
K1=par(1,1);
J1=par(2,1);
C1=par(3,1);
J2=par(4,1);
K2=par(5,1);
C2=par(6,1);
J3=par(7,1);
C3=par(8,1);
kh=par(9,1);
%}
% par = [2.7;
%        0.02;
%        0.01;
%        0.02;
%        2.7;
%        0.01;
%        0.02;
%        0.01;
%        2.35]
aux = {};
T = 0;
sys1_grey_id_top = idgrey('TDS_top',par,'c',aux,T);
sys1_grey_id_mid = idgrey('TDS_mid',par,'c',aux,T);
sys1_grey_id_bot = idgrey('TDS_bot',par,'c',aux,T);

sys1_grey_est_top = greyest(u_t_id_top,sys1_grey_id_top);
sys1_grey_est_mid = greyest(u_t_id_mid,sys1_grey_id_mid);
sys1_grey_est_bot = greyest(u_t_id_bot,sys1_grey_id_bot);

%% Comparison for Grey Box
figure(4)
compare(u_t_id_top,sys1_grey_est_top,Inf,opt)
figure(5)
compare(u_t_id_mid,sys1_grey_est_mid,Inf,opt)
figure(6)
compare(u_t_id_bot,sys1_grey_est_bot,Inf,opt)
% getpvec(sys1_grey_est)