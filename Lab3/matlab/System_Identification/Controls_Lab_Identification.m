clear all
close all
clc
%% Define Parameters
load('data_combined.mat')
intr_smpl_val={'zoh','zoh','zoh','zoh','zoh','zoh','zoh','zoh'};
%% Black Box Simulation
u_t_id_top = iddata(y_comb_top,u_comb,[],'ExperimentName',name_comb,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
u_t_id_mid = iddata(y_comb_mid,u_comb,[],'ExperimentName',name_comb,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
u_t_id_bot = iddata(y_comb_bot,u_comb,[],'ExperimentName',name_comb,'Domain','Time','SamplingInstants',t,'InterSample',intr_smpl_val,'TimeUnit','seconds','InputName',{'Torque'},'InputUnit',{'Nm'},'OutputName',{'Angular Position'},'OutputUnit',{'Radians'});
iodelay = NaN;
TF_top_est=tfest(u_t_id_top,6,5,iodelay,'Feedthrough','false');
TF_mid_est=tfest(u_t_id_mid,6,5,iodelay,'Feedthrough','false');
TF_bot_est=tfest(u_t_id_bot,6,5,iodelay,'Feedthrough','false');
opt = compareOptions('InitialCondition','zero');
figure(1)
compare(u_t_id_top,TF_top_est,Inf,opt)
figure(2)
compare(u_t_id_mid,TF_top_mid,Inf,opt)
figure(3)
compare(u_t_id_bot,TF_top_bot,Inf,opt)
%getpvec(TF1_est)
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
% par = [2.7;0.02;0.01;0.02;2.7;0.01;0.02;0.01;1];
% aux = {};
% T = 0;
% sys1_grey_id = idgrey('TDS',par,'c',aux,T);
% sys1_grey_est = greyest(u_t_id_dbl_stp_top,sys1_grey_id);
% figure(2)
% compare(u_t_id_dbl_stp_top,sys1_grey_est,Inf,opt)
% getpvec(sys1_grey_est)