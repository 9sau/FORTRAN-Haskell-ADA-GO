	Program assignment1

	INTEGER::CheckNumber

	integer n,i
	real temp,minimum,maximum,summation,average

	summation=0
	average=0
	minimum=0
	maximum=0

	read(*,*,IOSTAT=CheckNumber)n

	if(CheckNumber==0)then
		if(n==0)then
		goto 700
		endif

		read(*,*,IOSTAT=CheckNumber)temp

		if(CheckNumber==0)then
		minimum=temp
		maximum=temp
		summation=temp

		do 10 i=1,n-1

		read (*,*,IOSTAT=CheckNumber)temp
		
			if(CheckNumber==0)then
		
				if(temp<minimum)then
				minimum=temp
	
				elseif(temp>maximum)then
				maximum=temp
	
				endif

		summation=summation+temp

			else
			write(*,*)'ERR'
			goto 100

			endif

 10	continue

	average=summation/n
	
		else
		write (*,*)'ERR'
		goto 100

		endif

 700	write(*,800)'Num:',n 
	write(*,900)'Sum:',summation
	write(*,900)'Avg:',average
	write(*,900)'Min:',minimum
	write(*,900)'Max:',maximum

 800	format(A,I10)
 900	format(A,F12.2)

	else
	write(*,*)'ERR'
	goto 100

	endif

 100	end

		

	
