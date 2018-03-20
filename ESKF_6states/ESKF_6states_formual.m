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

rotErr1 = sym('rotErr1','real');    %%��������
rotErr2 = sym('rotErr2','real');    %%���������
rotErr3 = sym('rotErr3','real');    %%��������

wx = sym('wx','real');      %%
wy = sym('wy','real');
wz = sym('wz','real');

dt = sym('dt','real');

mx = sym('mx','real');
my = sym('my','real');
mz = sym('mz','real');

bx = sym('bx','real');
bz = sym('bz','real');

rotErr = [rotErr1,rotErr2,rotErr3]; %%��̬�����
bw = [bwx,bwy,bwz];


quat = [q0,q1,q2,q3];       %%��Ԫ��
Quat = [quat];
deltQuat = [1;0.5*wx;0.5*wy;0.5*wz];    %%������Ԫ������
quatNew = quatmulsyms(quat,deltQuat);   %%��Ԫ������


rotErrNew = -(eye(3) + skew([wx,wy,wz]))*rotErr' - bw'; %%��̬��������
bwnew = bw;

stateVector = [rotErr , bw];
stateVectorNew = [rotErrNew'  bwnew];

PHI = jacobian(stateVectorNew', stateVector);      %%�õ�״̬ת�ƾ���
matlabFunction(PHI,'file','calcPHI.m');




%%�����������
cbn = quat2cbn(quat);
mR = cbn * [mx;my;mz];
pred = [cbn'*[0;0;-1];cbn'*[bx;0;bz]]; %%Ԥ��ֵ(��������תʸ�����֮��Ĺ�ϵ)

Ham = jacobian(pred,quat);      %%��������Ԫ��֮��Ĺ�ϵ

%%������Ԫ������תʸ�����֮����ſ˱Ⱦ���

quatErr = [1;0.5*rotErr1;0.5*rotErr2;0.5*rotErr3];

quatErrNewRot = quatmulsyms(quat,quatErr);

Hxrot = jacobian(quatErrNewRot ,stateVector);
Hrot = Ham*Hxrot;
matlabFunction(Hrot,'file','calcHrotErr.m');

quatErrNewang = quatmulsyms(quatErr,quat);
Hxang = jacobian(quatErrNewang ,stateVector);
Hang = Ham*Hxang;
matlabFunction(Hang,'file','calcHrotang.m');











