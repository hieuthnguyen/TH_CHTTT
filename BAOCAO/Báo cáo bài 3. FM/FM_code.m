clc; clear; close all;
ts = 1/30000; % Thoi gian lay may
fs = 1/ts;
t = 0:ts:0.2;
% ============== Thong tin ==========
Vm = 2; fm = 500;
mt = Vm*sin(2*pi*fm*t);

% ============== Song mang ==========
Vc = 5; fc = 5000; omegac = 2*pi*fc;
xct = Vc*cos(omegac*t);
% ============== Nhat tan so =====
kf = 1500;
% ============== Dieu cge FM ========`
yFM = zeros(1,length(t));
for i = 1:length(t)
to = 0:ts:t(i);
mt = Vm*sin(2*pi*fm*to);
TP = sum(mt)*ts;
yFM(i) = Vc*sin(omegac*t(i)+2*pi*kf*TP);
end
yFM;
% ========= Giai dieu che FM =======
yFM_dh = diff(yFM); % Dao ham
yFM_bp = yFM_dh.^2; % Binh phuong
fc = 1050; % Tan so cat
[b,a] = butter(12, fc/(fs/2));
mDem = filter( b, a, yFM_bp);% Loc thap qua
mDem = (mDem -12.5)/12.5; % Can chinh bien
% ===========================
startp = 50;
endp = 300;
figure(1)
subplot(4,1,1)
plot(t(startp:endp),mt(startp:endp),'b-','linewidth',1.6); hold on;
legend('m(t)');
xlabel('t'); ylabel('V');
subplot(4,1,2)
plot(t(startp:endp),xct(startp:endp),'g-','linewidth',1.6); hold on;
legend('x_c(t)');
xlabel('t'); ylabel('V');
subplot(4,1,3)
plot(t(startp:endp),yFM(startp:endp),'r-','linewidth',1.6); hold on;
legend('y_{FM}(t)');
xlabel('t'); ylabel('V');
subplot(4,1,4)
plot(t(startp:endp),mDem(startp:endp),'c-','linewidth',1.6); hold on;
legend('m_{de}(t)');
xlabel('t'); ylabel('V');