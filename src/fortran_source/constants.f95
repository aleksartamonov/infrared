module constants_module
	
	integer,parameter :: num = 220 !parameter of resolution 
	
	! refractive indexes
	complex,dimension(0:num) :: eps_ice	
	complex,dimension(0:num) :: eps_sil    
	
	real(8),parameter :: a_ice = 3d0 ! large axis of Spheroid particle 
	real(8),parameter :: b_ice = 0.1 ! small ----------//-------------
	real(8),parameter :: a_sil = 0.3 
	real(8),parameter :: b_sil = 0.01
	
	real(8),parameter :: pi = 3.14159265359
	
	
	 
end module
