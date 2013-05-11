program extinction

	use constants_module
	use prolate_subfun_module

	real(8) :: tau0
	real(8),dimension(1:10) :: uu
	real(8),dimension(0:num) :: tau,P,Ptau
	real(8),dimension(6) :: all_alphas
	integer k

	all_alphas(1) = pi/2
	all_alphas(2) = pi/3
	all_alphas(3) = pi/4
	all_alphas(4) = pi/6
	all_alphas(5) = pi/12
	all_alphas(6) = pi/18
	
	
	open(unit = 7,file = '../tau/tau_1.dat',action = 'write',status = 'replace')
	open(unit = 8,file = '../P/P-to-tau_1.dat',action = 'write',status = 'replace')
	open(unit = 9,file = '../tau/tau_2.dat',action = 'write',status = 'replace')
	open(unit = 10,file = '../P/P-to-tau_2.dat',action = 'write',status = 'replace')
	open(unit = 11,file = '../tau/tau_3.dat',action = 'write',status = 'replace')
	open(unit = 12,file = '../P/P-to-tau_3.dat',action = 'write',status = 'replace')
	open(unit = 13,file = '../tau/tau_4.dat',action = 'write',status = 'replace')
	open(unit = 14,file = '../P/P-to-tau_4.dat',action = 'write',status = 'replace')
	open(unit = 15,file = '../tau/tau_5.dat',action = 'write',status = 'replace')
	open(unit = 16,file = '../P/P-to-tau_5.dat',action = 'write',status = 'replace')
	open(unit = 17,file = '../tau/tau_6.dat',action = 'write',status = 'replace')
	open(unit = 18,file = '../P/P-to-tau_6.dat',action = 'write',status = 'replace')
	
	call readandassign()


	eps = 1d-7
	write(6,*) "We consider ice particle with silicate core"
	write(6,*) "ice particle : a = ",a_ice,"mkm b = ",b_ice,"mkm" 
	write(6,*) "silicate core : a = ",a_sil,"mkm b = ",b_sil,"mkm" 
	
	write(6,*) "number of steps for building spectr is ",num
	Write(6,*) "if you change num in constant.f95 you must check data2.txt"
	write(6,*) "if length data2.txt is not num you should change interpolation .m and run "
	write(6,*) "octave interpolation.m in your command line"
	
	
	
	k = 4
	do j = 1,6
		lambda = 3.0
		alpha = all_alphas(j)
		tau0 = - Q_TE_ABS_ice(alpha,lambda,0) - Q_TE_ABS_sil(alpha,lambda,0) &
			& - Q_TM_ABS_ice(alpha,lambda,0) - Q_TM_ABS_sil(alpha,lambda,0)&
			& + Q_TE_SCA_ice(alpha,lambda,0) + Q_TM_SCA_ice(alpha,lambda,0)
		write(*,*) "angle of incedent light (alpha) = ",alpha*180.0d0/pi," degrees"
		do i = 0,num
			lambda = (3.0d0 + i*(25.d0 - 3.d0)/num)*1.d0 
			tau(i) = (- Q_TE_ABS_ice(alpha,lambda,i) - Q_TE_ABS_sil(alpha,lambda,i) &
				& - Q_TM_ABS_ice(alpha,lambda,i) - Q_TM_ABS_sil(alpha,lambda,i)&
				 + Q_TE_SCA_ice(alpha,lambda,i) + Q_TM_SCA_ice(alpha,lambda,i))
			!tau(i) = -Q_TE_ABS_ice(alpha,lambda,i) + Q_TM_ABS_ice(alpha,lambda,i)
			P(i) = (+ Q_TE_ABS_ice(alpha,lambda,i) + Q_TE_ABS_sil(alpha,lambda,i) &
				& - Q_TM_ABS_ice(alpha,lambda,i) - Q_TM_ABS_sil(alpha,lambda,i)&
				& - Q_TE_SCA_ice(alpha,lambda,i) + Q_TM_SCA_ice(alpha,lambda,i))
			!P(i) =  Q_TE_SCA_ice(alpha,lambda,i) - Q_TM_SCA_ice(alpha,lambda,i)
			write(2*k-1,*) lambda,tau(i)/tau0
			!if(2*k+1 == 5) then
				!k=k+1
			!endif
			write(2*k,*) lambda,P(i)/tau(i) ,P(i)
			
		enddo
		k=k+1
	enddo
	
end
