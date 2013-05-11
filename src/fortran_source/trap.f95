module integration_module
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !																									!
    !										Intrgration Part 											!
    !																									!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    !............********************************************************************************.......!
    

contains
	subroutine trap_2D(f,a,b,c,d,integral,nx,ny)
	!==========================================================
	! Integration of f(x,y) on [a,b] for x and [c,d] for y
	! Method: cubature trapezoid rule for nx*ny points  
	! written by: Alex Godunov (October 2009)
	!----------------------------------------------------------
	! IN:
	! f   - Function to integrate (supplied by a user)
	! a	  - Lower limit of integration for x
	! b	  - Upper limit of integration for x
	! c	  - Lower limit of integration for y
	! d	  - Upper limit of integration for y
	! nx  - number of points along x
	! ny  - number of points along y
	! OUT:
	! integral - Result of integration
	!==========================================================
	implicit none
	double precision f, a, b, c, d, integral, sum
	double precision hx, hy, x, y
	integer nx, ny
	integer i, j

	hx = (b-a)/dfloat(nx-1)
	hy = (d-c)/dfloat(ny-1)
	   
	! calculate the corner's terms
	sum = f(a,c)+f(a,d)+f(b,c)+f(b,d)

	! calculate single sums
	do i=2,nx-1
	   x = a + hx*(i-1)
	   sum = sum + 2.0*(f(x,c)+f(x,d))
	end do

	do j=2, ny-1
	   y = c + hy*(j-1)
	   sum = sum + 2.0*(f(a,y)+f(b,y))
	end do

	! calculate the double sum
	do i = 2,nx-1
	   x = a + hx*(i-1)
	   do j = 2,ny-1
		  y = c + hy*(j-1)
		  sum = sum + 4.0*f(x,y)
	   end do
	end do
	integral = 0.25*hx*hy*sum
	return
	end subroutine trap_2D
end module integration_module
