num = 220
sil_dat  = load("-ascii","../data/eps_sil.dat") ;
ice_dat = load("-ascii","../data/eps_ice.dat") ;

sil_len = sil_dat(:,1);
sil_n = sil_dat(:,4)+1;
sil_k = -sil_dat(:,5);

ice_len = 10000./ice_dat(:,1);
ice_n = ice_dat(:,2);
ice_k = -ice_dat(:,3);

fin_len = [3:(25-3)/num:25];

fin_ice_n = interp1(ice_len,ice_n,fin_len);
fin_ice_k = interp1(ice_len,ice_k,fin_len);

fin_sil_n = interp1(sil_len,sil_n,fin_len);
fin_sil_k = interp1(sil_len,sil_k,fin_len);

data = [fin_len' fin_ice_n' fin_ice_k' fin_sil_n' fin_sil_k']
plot (sil_len, sil_n, "r", fin_len, fin_sil_n, "g", sil_len, sil_k, "b",
                fin_len, fin_sil_k, "c", ice_len, ice_n, "m", fin_len, fin_ice_n, "r*");
legend ("sil n", "fin sil n", "sil k", "ice n", "fin ice n");
save('-ascii','../data/data2.txt','data'); 
