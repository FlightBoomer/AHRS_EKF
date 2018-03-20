function [att2,exyzOut] = MahonyUpdate(att1,gyro,acc,mag,ts,Ki,Kp,exyzInt)

    %%AHRS��̬�����㷨
    %%gyro unit rad/s
    %%acc unit m/s^2
    
    nm = norm(acc);
    if nm>0
        acc = acc/nm;
    else
        acc = [0;0;0];
    end
    
    nm = norm(mag);
    if nm>0
        mag = mag/nm;
    else
        mag = [0,0,0];
    end
    
    cbn = att2cbn(att1);    %%��̬��ת��Ϊ��̬����
    q1 = att2quat(att1);    %%��̬��ת��Ϊ��Ԫ��
    
    exyz = (cross(cbn(3,:)',acc'))';
    exyzOut = exyzInt + exyz*Ki*ts;
    ang = (gyro + Kp*exyz + exyzOut)*ts;
    q = quatmul(q1,ang2quat(ang'));   %%��Ԫ������
    att2 = quat2att(q);     %%������̬��
    
end