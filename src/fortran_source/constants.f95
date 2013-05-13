module constants_module
	
	integer,parameter :: num = 220 !parameter of resolution 
	
	! refractive indexes
	complex,dimension(0:num) :: eps_ice	
	complex,dimension(0:num) :: eps_sil    
	
	!real(8),parameter :: a_ice = 3d0 ! large axis of Spheroid particle 
	!real(8),parameter :: b_ice = 0.1 ! small ----------//-------------
	!real(8),parameter :: a_sil = 0.3 
	!real(8),parameter :: b_sil = 0.01
	real(8),parameter :: ratio = 5d0 ! ratio of a_total/ b_ total
	real(8),parameter :: r_V = 0.1d0 ! radius of ball with equal volume as particle
	real(8),parameter :: r_of_vol = 0.5d0 !0.5 0.8 ratio of volumes of core and core+mantle
	real(8),parameter :: pi = 3.14159265359
	
	
	 
end module
