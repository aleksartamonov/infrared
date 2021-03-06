module prolate_subfun_module
	
	use constants_module
	use integration_module
	real(8),parameter :: ff = 1 ! for prolate sferoids
	double precision :: eps=1d-3 
	real(8),parameter :: a_ice = r_v*ratio**(1d0/3d0)
	real(8),parameter :: b_ice = r_v*ratio**(-2d0/3d0)
	real(8),parameter :: r_C = r_V*r_of_vol
	real(8),parameter :: a_sil = r_C*ratio**(1d0/3d0)
	real(8),parameter :: b_sil = r_C*ratio**(-2d0/3d0)
	real(8),parameter :: e_ice = sqrt(1 - b_ice**2/a_ice**2) ! excentricity in prolate case
	real(8),parameter :: ratio_ice = a_ice/b_ice ! ratio of axises
	real(8),parameter :: e_sil = sqrt(1 - b_sil**2/a_sil**2) ! excentricity in prolate case
	real(8),parameter :: ratio_sil = a_sil/b_sil ! ratio of axises
	!real(8),parameter :: r_of_vol = a_sil**2*b_sil/a_ice**2/b_ice
	real(8) :: lambda ! wavelength of incident radiation
	real(8) :: alpha ! angle between rotation axis and wave-vector of radiation
	
	
	
	real(8),parameter :: L_3_ice  = (1 - e_ice**2)/e_ice**2*( log( (1+e_ice)/(1-e_ice) )/( 2*e_ice) -1)
	real(8),parameter :: L_1_ice  = (1 - L_3_ice)/2
	
	real(8),parameter :: L_3_sil = (1-e_sil**2)/e_sil**2*( log( (1+e_sil)/(1-e_sil) )/( 2*e_sil) -1)
	real(8),parameter :: L_1_sil  = (1 - L_3_sil)/2
	
	complex,dimension(0:num):: alpha_pol_1 ! polarizability
	complex,dimension(0:num) :: alpha_pol_3 ! polarizability
	
	complex,parameter ::  ksi_0 = (ratio_ice)**2*(((ratio_ice)**2-1)**(-0.5))
	complex,parameter ::  ksi_0_sil = (ratio_sil)**2*(((ratio_sil)**2-1)**(-0.5))
	
	contains
	
	subroutine readandassign()
	real(8) l,ir,ii,sr,si
		open(unit = 1,file = '../data/data2.txt')
		
		do i = 0,num
			read(1,*) l,ir,ii,sr,si
			eps_ice(i) = (cmplx(ir,ii))*(cmplx(ir,ii))
			eps_sil(i) = (cmplx(sr,si))*(cmplx(sr,si))
		enddo
		alpha_pol_1 = ((eps_sil-1.d0)*(eps_sil+(eps_ice - eps_sil)*(L_1_ice - r_of_vol*L_1_sil))&
				  &+r_of_vol*eps_sil*(eps_ice-eps_sil))/((eps_sil+(eps_ice - eps_sil)*(L_1_ice - r_of_vol*L_1_sil))*&
				  &(1.d0+(eps_sil-1.d0)*L_1_sil)+r_of_vol*eps_sil*L_1_sil*(eps_ice-eps_sil)) ! 
	    alpha_pol_3 = ((eps_sil-1.d0)*(eps_sil+(eps_ice - eps_sil)*(L_3_ice - r_of_vol*L_3_sil))&
				  &+r_of_vol*eps_sil*(eps_ice-eps_sil))/((eps_sil+(eps_ice - eps_sil)*(L_3_ice - r_of_vol*L_3_sil))*&
				  &(1.d0+(eps_sil-1.d0)*L_3_sil)+r_of_vol*eps_sil*L_3_sil*(eps_ice-eps_sil)) ! polarizability
	end subroutine
	
	!prolate case U
	function u(phi,theta)
		real(8) phi,theta
		cksi = 2.d0*pi*a_ice/lambda
		u = cksi*sqrt((cos(theta) - cos(alpha))**2+(ratio_ice)**(-2.d0)*(&
			&(sin(theta))**2+(sin(alpha))**2 - 2.d0*sin(alpha)*sin(theta)*cos(phi)))
	end function 
	
	function GG(phi,theta)
		real(8) phi,theta
		
		GG = 3.0*(sin(u(phi,theta)) - u(phi,theta) * cos(u(phi,theta)))/(u(phi,theta)**3)
		return 
	end function
	
	! //////////////////////// Q absorbtion //////////////////////////////////////////////////
	
	function Q_TE_ABS(alpha,lambda,i)
		real(8) alpha,lambda,Q_TE_ABS
		integer i
		
		cksi = 2.d0*pi*a_ice/lambda
		
		Q_TE_ABS = 4.0d0*cksi*((ksi_0**2 - ff)/(ksi_0-ff*cos(alpha)))**(0.5)*&
						&aimag(alpha_pol_1(i))
		return
	
	end function
	
	
	function Q_TM_ABS(alpha,lambda,i)
		real(8) alpha,lambda,Q_TM_ABS

		integer i
		cksi = 2.d0*pi*a_ice/lambda
		Q_TM_ABS = 4.0d0*cksi*((ksi_0**2 - ff)/(ksi_0-ff*cos(alpha)))**(0.5)*&
						&aimag((sin(alpha))**2*alpha_pol_3(i) + (cos(alpha))**2*alpha_pol_1(i))
		return
	end function
	
	
	
	! //////////////////////// Q scattering //////////////////////////////////////////////////
! ******************** fuctions under integration *********************** !	
	function int_spc(x,y)
		implicit none
		double precision int_spc, x, y
		int_spc = GG(x,y)*GG(x,y)*sin(y)*((cos(x))**2 + (cos(y)*sin(x))**2)

		return
	end
	function int_sc(x,y)
		implicit none
		double precision int_sc, x, y
		int_sc = GG(x,y)*GG(x,y)*cos(y)*sin(y)*sin(y)*cos(x)

		return
	end
	function int_s(x,y)
		implicit none
		double precision int_s, x, y
		int_s = GG(x,y)*GG(x,y)*sin(y)*sin(y)*sin(y)

		return
	end
	!////////////////////////////////////////////////////////
	
    function Q_TE_SCA(alpha,lambda,i)
    	real(8) alpha,lambda,cksi
    	real(8) Q_TE_SCA
  		real(8) integral,integral_trap
  		integer i
  		
  		call trap_2D(int_spc,0.d0,2.d0*pi,0.d0,pi,integral_trap,30,30)
  		cksi = 2.d0*pi*a_ice/lambda
  	
    	Q_TE_SCA = (cksi**4)*((ksi_0**2 - ff)**(1.5)/(ksi_0-ff*cos(alpha))**(0.5))/(9.d0*pi*ksi_0)*&
    				   &(abs(alpha_pol_1(i))**2)*integral_trap
    	
    	
    	return 
    end function 
    
    function Q_TM_SCA(alpha,lambda,i)
    	real(8) alpha,lambda,cksi
    	real(8) Q_TM_SCA
  		real(8) integral_spc,integral_sc,integral_s
  		real(8) integral_spc_trap,integral_sc_trap,integral_s_trap
  		integer i

  		call trap_2D(int_spc,0.d0,2.d0*pi,0.d0,pi,integral_spc_trap,30,30)
  		call trap_2D(int_sc,0.d0,2.d0*pi,0.d0,pi,integral_sc_trap,30,30)
  		call trap_2D(int_s,0.d0,2.d0*pi,0.d0,pi,integral_s_trap,30,30)
  		cksi = 2.d0*pi*a_ice/lambda
  	
    	Q_TM_SCA = (cksi**4)*((ksi_0**2 - ff)**(1.5)/(ksi_0-ff*cos(alpha))**(0.5))/(9.d0*pi*ksi_0)*&
    				   &(((abs(alpha_pol_1(i)))**2)*(cos(alpha)*cos(alpha))*integral_spc_trap + &
    				   &((abs(alpha_pol_3(i)))**2)*sin(alpha)*sin(alpha)*integral_s_trap + &
    				   &2*(REAL(alpha_pol_3(i)*conjg(alpha_pol_1(i))))*sin(alpha)*cos(alpha)*integral_sc_trap)
    	return 
    end function 
    	
end module
