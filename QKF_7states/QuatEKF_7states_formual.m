clear
clc

if(ispc)
    addpath E:\EFY_GNSS_INS\base;
else
    addpath E:/EFY_GNSS_INS/base;
end 

q0 = sym('q0','real');      %%��Ԫ��
q1 = sym('q1','real');
q2 = sym('q2','real');
q3 = sym('q3','real');

bwx = sym('bwx','real');    %%������ƫ
bwy = sym('bwy','real');
bwz = sym('bwz','real');

wx = sym('wx','real');      %%
wy = sym('wy','real');
wz = sym('wz','real');

dt = sym('dt','real');

mx = sym('mx','real');
my = sym('my','real');
mz = sym('mz','real');

bx = sym('bx','real');
bz = sym('bz','real');

quat = [q0,q1,q2,q3];
bw = [bwx,bwy,bwz];

stateVector = [quat,bw];

deltQuat = [         1;
                0.5*wx;
                0.5*wy;
                0.5*wz];    %%������Ԫ������

quatNew = quatmulsyms(quat,deltQuat);
bwNew = bw;

stateVectorNew = [quatNew , bwNew];


PHI = jacobian(stateVectorNew, stateVector);      %%�õ�״̬ת�ƾ���
matlabFunction(PHI,'file','calcPHI.m');

cbn = quat2cbn(quat);
mR = cbn * [mx;my;mz];

pred = [cbn'*[0;0;-1];cbn'*[bx;0;bz]];

H = jacobian(pred, stateVector);      %%�õ�״̬ת�ƾ���
matlabFunction(H,'file','calcH.m');



