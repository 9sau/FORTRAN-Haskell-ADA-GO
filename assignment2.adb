with Ada.Text_IO, Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO,Ada.Integer_Text_IO,Ada.Strings.Maps.constants;
use Ada.Text_IO, Ada.Strings.Unbounded, Ada.Strings.Unbounded.Text_IO,Ada.Integer_Text_IO,Ada.Strings.Maps.constants;

procedure assignment2 is
	
	Input : Unbounded_String;
	temp  : Unbounded_String;
	data1 : Unbounded_String;
	data2 : Unbounded_String;
	data3 : Unbounded_String;
	phase2: Unbounded_String;
	cmd	  : Unbounded_String;
	arg	  : Unbounded_String;
	strSum: Unbounded_String;
	dupSum: Unbounded_String;
	sub	  : Unbounded_String;
	
	i	   	   : Integer;
	dataExists : Integer := -1;
	c		   : Integer;
    sum 	   : Integer;
	links	   : Integer;
	unused	   : Integer;
	dummy	   : Integer:=0;

	flag	   : boolean := true;
	alpha	   : boolean := true;
	phase2_flag: boolean := true;
	command    : boolean := true;
	strSumFlag : boolean;
	
	type list is
		
		record
		name	 : Unbounded_String;
		value	 : Unbounded_String;
		nextName : Unbounded_String;
		checked  : boolean;
		end record;
		
	type ListAccess is access list;
	
	LinkedList : array(1..9999) of ListAccess;
	
	function initialiseChecked(x: Integer) return Integer is
		begin
			for x in 1..i loop
				LinkedList(x).checked:=false;
			end loop;
			return 0;
		end;
	
	function checkCharInStrSum(strSum:Unbounded_String) return boolean is
	
	ch:character;
	flag:boolean;
	begin
		for i in 1..length(strSum) loop
			
			ch:=Element(strSum,i);
			if(ch not in '0'..'9')then
				return true;
			else 
				flag:=false;
			end if;		
		end loop;
		return flag;
	end;
	
	function checkExistsNew(arg:Unbounded_String) return Integer is
	
	begin
		for x in 1..i loop
			if(LinkedList(x).nextName=arg)then
				--put(arg);
				--put_line(" Exists");
				return x;
			end if;
		end loop;
	return -1;
	end;
	
	function checkExists(arg:Unbounded_String) return Integer is
	
	begin
		for x in 1..i loop
			if(LinkedList(x).name=arg)then
				--put(arg);
				--put_line(" Exists");
				return x;
			end if;
		end loop;
	return -1;
	end;
	
	function getUnused(arg:Unbounded_String) return Integer is
	count:Integer:=0;
	name:Unbounded_String:=arg;
	index: Integer;
	begin
		if(checkExists(arg)=-1)then
			return -1;
		end if;
		loop
			index:=checkExistsNew(name);
			if(index/=-1)then
				if(not(LinkedList(index).checked))then
					count:=count+1;
					name:=LinkedList(index).name;
					LinkedList(index).checked:=true;
				else
					return 0;
				end if;
			else
				return count;
			end if;
		exit when (index=-1);
		end loop;	
	return 0;
	end;
	
	function getLinks(arg: Unbounded_String) return Integer is
	count:Integer:=0;
	index:Integer;
			
	begin
		index:=checkExists(arg);
			if(index/=-1)then
				for x in 1..i loop
					if(LinkedList(x).nextName=arg)then
						count:=count+1;
					end if;
				end loop;
			else 
				return -1;
			end if;
		
		return count;
	end;
	
	function count(arg:Unbounded_String) return Integer is
	
	count:Integer:=0;
	next:Unbounded_String:=arg;
	index:Integer;
		
	begin
		loop
			index:=checkExists(next);
			if(index/=-1)then
				if(not(LinkedList(index).checked))then
					count:=count+1;
					next:=LinkedList(index).nextName;
					LinkedList(index).checked:=true;
				else
					next:=to_unbounded_String("");
				end if;
			
			else 
				return -1;
				
			end if;
				
		exit when(next="");
		end loop;
	
	return count;
	end;

	function getSum(arg: Unbounded_String) return Unbounded_String is
	s:Unbounded_String;
	next:Unbounded_String:=arg;
	index:Integer;
	
	
	begin
	dupSum:=to_unbounded_String("");	
	s:=to_unbounded_String("");
		loop
			index:=checkExists(next);
			if(index/=-1)then
				if(not(LinkedList(index).checked))then
					append(s,LinkedList(index).value);
					append(dupSum,LinkedList(index).value);
					append(dupSum," ");
					next:=LinkedList(index).nextName;
					LinkedList(index).checked:=true;
				else
					next:= to_unbounded_String("");
				end if;
			else
				return to_unbounded_String("");
			end if;
				
		exit when(next="");
		end loop;
	
	return s;
		
		
	end;
	
	function getCorrectedCommand(temp: Unbounded_String) return Unbounded_String is
		
		ch:character;
		correctedString: Unbounded_String;
	
	begin
		for i in 1..length(temp) loop
			ch:=Element(temp,i);
			if(ch/=' ')then
				append(correctedString,ch);
					
					if(correctedString="COUNT")then 
					--put_line("In COUNT"); 
					append(correctedString,slice(temp,i+1,length(temp)));
					return Translate(correctedString,Ada.Strings.Maps.Constants.Upper_Case_Map);
					end if;
					
					if(correctedString="SUM")then 
					--put_line("In SUM");
					append(correctedString,slice(temp,i+1,length(temp)));
					return Translate(correctedString,Ada.Strings.Maps.Constants.Upper_Case_Map);
					end if;
					
					if(correctedString="UNUSED")then 
					--put_line("In UNUSED");
					append(correctedString,slice(temp,i+1,length(temp)));
					return Translate(correctedString,Ada.Strings.Maps.Constants.Upper_Case_Map);
					end if;
					
					if(correctedString="LINKS")then
					--put_line("In LINKS");
					append(correctedString,slice(temp,i+1,length(temp)));
					return Translate(correctedString,Ada.Strings.Maps.Constants.Upper_Case_Map);
					end if;
					
					if(correctedString="QUIT")then 
					--put_line("In QUIT"); 
					append(correctedString,slice(temp,i+1,length(temp)));
					return Translate(correctedString,Ada.Strings.Maps.Constants.Upper_Case_Map);
					end if;
			end if;
		end loop;
	
	return to_unbounded_String("");
	end;
	
	function checkCommand(temp: Unbounded_String) return boolean is
		ch:character;
		flag:boolean:=false;
					
		begin
			for i in 1..length(temp) loop
				ch:=Element(temp,i);
				if((ch>='a' and ch<='z') or (ch>='A' and ch<='Z') or (ch in '0'..'9') or ch=' ')then
					flag:=true;
				else
				flag:=false;
				goto completed;
				end if;
			end loop;
			
<<completed>>	return flag;
	end;
	
	function checkAplhaNumeric(extracted:Unbounded_String) return boolean is
		ch:character;
		flag:boolean:=false;
		begin
		
			for i in 1..Length(extracted) loop
			
			ch:=Element(extracted,i);
				if((ch>='a' and ch<='z') or (ch>='A' and ch<='Z') or (ch>='0' and ch<='9'))then
			
					flag:=true;
				else
					flag:=false;
				goto finish;
					
				end if;
			end loop;
		
<<finish>>	return flag;
		end;
		

 begin
  --Put_line("enter a string");
	i:=0;
	loop
		get_line(Input);
		temp:=input;
		dataExists:=-1;
		flag:=true;
		if(index(input,";")=0 and input /="") then 
			flag:=false;
			goto error;
		
		else if(length(input)>0)then
		
			data1:=to_unbounded_String(slice(input,1,index(input,";")-1));
			
			if(index(data1," ")/=0 or length(data1)=0 or not(checkAplhaNumeric(data1)))then 
				flag:=false;
				goto error;
			end if;

			input:=to_unbounded_String(slice(input,index(input,";")+1,Length(input)));
			
			if(index(input,";")=0) then 
				flag:=false;
				goto error;
			end if;
												
			data2:=to_unbounded_String(slice(input,1,index(input,";")-1));
		
			input:=to_unbounded_String(slice(input,index(input,";")+1,Length(input)));
		
			data3:=to_unbounded_String(slice(input,1,Length(input)));
			
			if(Length(data3)=0)then
				goto label_null;
				end if;
			
			if(index(data3," ")/=0 or index(data3,";")/=0 or not(checkAplhaNumeric(data3)))then 
				flag:=false;
				goto error;
			end if;
					
<<label_null>> 			
				if(i/=0)then
					
					dataExists:=checkExists(data1);
					if(dataExists/=-1)then
						flag:=false;
						goto error;
					end if;
				end if;
	
				--Put_line("value of i = " & Integer'image(i));
				i:=i+1;
				LinkedList(i):=new list;
				LinkedList(i).name:=data1;
				Translate(LinkedList(i).name,Ada.Strings.Maps.Constants.Upper_Case_Map);
				LinkedList(i).value:=data2;
				LinkedList(i).nextName:=data3;
				Translate(LinkedList(i).nextName,Ada.Strings.Maps.Constants.Upper_Case_Map);
				LinkedList(i).checked:=false;
		
			end if;
		
		end if;
		
<<over>>exit when (temp="");
	end loop;
	
------------------------------end of phase1-----------------------------------------
	loop
	phase2_flag:=true;
	--put_line("Enter Command for phase 2");
	get_line(phase2);
	dummy:=initialiseChecked(dummy);
	Translate(phase2,Ada.Strings.Maps.Constants.Upper_Case_Map);
	cmd:=phase2;
	command:= checkCommand(phase2);
		
		if(not(command))then
			--Put_line("Command is not alphanumeric ");
			phase2_flag:=false;
			goto error2;			
		end if;
		
		--Put_line("Command is alphanumeric with spaces");
		--put_line(phase2);
		phase2:=getCorrectedCommand(phase2);
		
		if(phase2="")then
			phase2_flag:=false;
			goto error2;			
		end if;
		
		--put_line("Corrected String");
		--put_line(phase2);
		--put_line("Correction ends");
		
		if(index(phase2," ")/=0)then
				arg:=to_unbounded_String(slice(phase2,index(phase2," ")+1,length(phase2)));
				phase2:=to_unbounded_String(slice(phase2,1,index(phase2," ")-1));
				--put("Phase2 : ");
				--put_line(phase2);
				--put("ARG : ");
				--put_line(arg);
				
				if(length(arg)=0)then
					phase2_flag:=false;
					goto error2;
				end if;
				
				if(index(arg," ")/=0 and phase2/="QUIT")then
					phase2_flag:=false;
					goto error2;
				end if;
		else
				--put_line("No space after the command");
				if(phase2/="QUIT")then
					phase2_flag:=false;
					goto error2;
				end if;
		end if;
		
---------------------COUNT---------------------------------		
		
		if(phase2="COUNT")then 
			--put_line("In COUNT");
			
			c:=0;
			c:=count(arg);
			if(c=-1)then
				--put_line("Inconsistent list");
				phase2_flag:=false;
				goto error2;
			end if;
			
			--put("Count is ");
			Put_line(Integer'image(c));
			
		end if;
---------------------COUNT Ends-----------------------------

---------------------SUM------------------------------------
		
		if(phase2="SUM") then
		--put_line("In SUM");
			
		sum:=0;
		strSumFlag:=false;
		strSum:=getSum(arg);
			if(strSum="")then
				--put_line("Inconsistent List");
				phase2_flag:=false;
				goto error2;
			end if;
			
		strSumFlag:=checkCharInStrSum(strSum);
			if(strSumFlag)then
				--put_line("Contains alphabets");
				--put("Final Sum is ");
				put_line(strSum);
			else
				--put_line("Does not Contain alphabets");
					loop
						sub:=to_unbounded_String(slice(dupSum,1,index(dupSum," ")-1));
						
						sum:=sum+Integer'Value(to_String(sub));
						
						dupSum:=to_unbounded_String(slice(dupSum,index(dupSum," ")+1,length(dupSum)));
					exit when(dupSum="");
					end loop;
				--put("Final Sum is ");
				put_line(Integer'image(sum));
			end if;
			
		end if;	
---------------------SUM Ends--------------------------------

-----------------------UNUSED---------------------------------
		unused:=0;
		if(phase2="UNUSED")then 
			--put_line("In UNUSED");
			unused:=getUnused(arg);
			
			if(unused=-1)then
				phase2_flag:=false;
				goto error2;
			end if;
			
			--put("Unused : ");
			put_line(Integer'image(unused));
		end if;
			
----------------------UNUSED Ends-----------------------------

-----------------------LINKS---------------------------------
		links:=0;
		if(phase2="LINKS")then 
			--put_line("In LINKS");
			links:=getLinks(arg);
		
			if(links=-1)then
				phase2_flag:=false;
				goto error2;
			end if;
			
			--put("Links : ");
			put_line(Integer'image(links));	
		end if;

-----------------------LINKS Ends-----------------------------
		
<<error2>> if(phase2_flag=false) then put_line("ERR");end if;
	exit when (phase2="QUIT");
	end loop;
	
<<error>> if(flag=false)then put_line("BAD"); end if;	

end assignment2;