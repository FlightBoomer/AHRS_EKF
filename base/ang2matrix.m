function R = ang2matrix(ang)
    
    %%��תʸ�� -> ��ת����
    
    %% R = I + [skew(u)]*sin(sita) + [u'*u]*(1 - cos(sita))

    sita = norm(ang);
    sp = sin(sita);
    cp = cos(sita);
    u = ang / sita;
    ucross = skew(u);
    
    R = eye(3) + ucross * sp + ucross' * ucross * (1 - cp);
    

end