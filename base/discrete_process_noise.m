function Q_k = discrete_process_noise(F,G,dt,Q)


%%������ɢ�������������������

    [r,c] = size(F);
    Q_k = (eye(r) + dt*F)*(dt*G*Q*G');

 end
