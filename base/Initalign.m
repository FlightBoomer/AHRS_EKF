function att = Initalign(Accelermeter,Yaw)

%%��ʼ��׼����

    g = 9.81;

    att(1) = atan(Accelermeter(2)/Accelermeter(3)); %%�����
    att(2) = asin(Accelermeter(1)/g);               %%������
    att(3) = Yaw;                                   %%�����

end