
function yaw = magb2yaw(att,Magb)

    %%���ݴ����Ƶ������ˮƽ��̬����ź���
    
    Roll = att(1);  %%�����
    Pitch =att(2);  %%������
    
    Cb2 = [ cos(Pitch)    sin(Pitch)*sin(Roll)    sin(Pitch)*cos(Roll);
                0              cos(Roll)                 -sin(Roll);
           -sin(Pitch)    cos(Pitch)*sin(Roll)    cos(Pitch)*cos(Roll)];
       
       
     Magn = Cb2*Magb;   
     
     yaw = atan2(-Magn(2), Magn(1));


end