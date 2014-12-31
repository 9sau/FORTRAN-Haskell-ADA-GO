package main
import "os"
import "fmt"
import "bufio"
import "strings"

	var count int
	var count1 int
	var count2 int
	var x [2][]string
	var inc int
	func main() {
	in := bufio.NewReader(os.Stdin)
	input, err := in.ReadString('\n')
	temp := input[:len(input)-1]
	x[0]=make([]string,len(temp))
	x[1]=make([]string,len(temp))
	count=0
	if(temp=="QUIT"){
		os.Exit(1)
	}
	
	
	//fmt.Println(temp)
	
	if (err!=nil){
		fmt.Println("ERR")
	}
	
	if (strings.Contains(temp,"&")) {//if 1
		//fmt.Println("Line contains &")
		arr := strings.Split(temp, "&")
		
		str1:=strings.Trim(arr[0]," ")
		str2:=strings.Trim(arr[1]," ")
		
		if(len(arr)>2){
			fmt.Println("ERR")//: String 2 contains another &")
			os.Exit(1)
		}
		inc=0
		flag1 := parseType(str1)
		if(!flag1){
			fmt.Println("ERR")
			os.Exit(1)
		}
		count1=count
		count=0
		inc++
		flag2 := parseType(str2)
		if(!flag2){
			fmt.Println("ERR")
			os.Exit(1)
		}
		count2=count
		//fmt.Print("Parsing of str1 "+str1+" : ")
		//fmt.Println(flag1)
		
		//fmt.Print("Parsing of str2 "+str2+" : ")		
		//fmt.Println(flag2)
		//fmt.Println(x[0],count1)
		//fmt.Println(x[1],count2)
		unify(str1,str2)
		main()
		} else {//else 1
				fmt.Println("ERR")//:Line does not contain &")
			}
}//func main ends
	
	func unify(str1 string, str2 string) {
		
		
		if(count1!=count2){
			fmt.Println("BOTTOM")// : Length not same")
			os.Exit(1)
		}
		
		for i:=0;i<count1;i++ {
			
			if(!(x[0][i]==x[1][i] || (parseVarName(x[0][i]) && parseVarName(x[1][i])))){
				fmt.Println("BOTTOM")// : Mismatch of brackets")
				os.Exit(1)
			}
			
		if(x[0][i]!=x[1][i]){
			
			str1 = strings.Replace(str1,x[0][i],x[1][i],-1)
			}
		
		if(x[0][i]=="int" ||x[0][i]=="float" || x[0][i]=="string" || x[0][i]=="long"){
				if(x[1][i]=="[]" || x[1][i]=="()"){
					fmt.Println("BOTTOM")// : Length not same")
					os.Exit(1)
				}
			}
		}
		
			fmt.Println(str1)
			

	}
	
	
	
	func parseType(str string) bool {
		if(str==""){
			return true
		}
		if(str[0]=='`'){//if 2 for typeVar
			
				//fmt.Println(str+" in VarType `")
				matches := parseVarName(str)
					if (matches){//if 3
						//fmt.Println(str+" Variable is correct")
						return true
							} else{//else 3
									
									//fmt.Println("ERR")//: "+str+" Variable name conctraint violated")
									//os.Exit(1)
									return false
								}
					} else{//else 2
						
							//fmt.Println(""+str+" Does not contain `")
							if(str=="int" || str =="float" || str=="long" || str=="string"){//if 4 for primitive type
											x[inc][count]=str
											count++
											return true
										} else{//else 4
											
											
											//line:=strings.Replace(temp," ","",-1)
											//fmt.Println("Not a Primitive Type")
													if (str[0]=='(') {//if 5
														
														indexOfClosePar:=strings.LastIndex(str,")")
														if(indexOfClosePar==-1) {//if 6
															//fmt.Println("ERR")//:type is funcType but no closing ')'")
														 	return false
														 	//os.Exit(1)
														 }
														
														
														
														indexOfDash:=strings.LastIndex(str,"-")
		
														if(indexOfDash==-1){
															//fmt.Println("ERR")// : no '-' found")
															//os.Exit(1)
															return false
															}
														s1:=strings.Trim(str[0:indexOfDash]," ")
														s2:=strings.Trim(str[indexOfDash+1:]," ")
														dupstr:=s1+"-"+s2
														//fmt.Println("Dupstr : "+dupstr)
														if(!(dupstr[indexOfClosePar+1:indexOfClosePar+3]=="->")){//if 7
																return false
																	}
														//afterArrow:=strings.Trim(dupstr[indexOfClosePar+3:]," ")
														//fmt.Println("afterArrow : "+afterArrow)
														
														
														indexOfNewDash:=strings.Index(str,"-")
														if(indexOfNewDash==-1){
															//fmt.Println("ERR")// : no '-' found")
															//os.Exit(1)
															return false
															}
														
														news1:=strings.Trim(str[0:indexOfNewDash]," ")
														news2:=strings.Trim(str[indexOfNewDash+1:]," ")
														//fmt.Println("news1 : "+news1+" | news2 : "+news2)
														newdupstr:=news1+"-"+news2
														//fmt.Println("NewDupstr : "+newdupstr)
														
														indexOfNewDupDash:=strings.Index(newdupstr,"-")
														if(!(newdupstr[indexOfNewDupDash:indexOfNewDupDash+2]=="->")){//if 7
																//fmt.Println("is arrow " + newdupstr[indexOfNewDupDash:indexOfNewDupDash+2])
																return false
																	}
														
														t1:=strings.Trim(newdupstr[0:indexOfNewDupDash]," ")
														t2:=strings.Trim(newdupstr[indexOfNewDupDash+2:]," ")
														
														//fmt.Println("before arrow : "+t1+" After Arrow : "+t2)
														
														if(t2==""){
															return false
														}
														
														if(t2[0]=='('){
															
															indexOfNewClosePar:=strings.LastIndex(t1,")")
															if(indexOfNewClosePar==-1) {//if 6
																//fmt.Println("ERR")//:type is funcType but no closing ')'")
														 		//os.Exit(1)
														 		return false
														 		}
															x[inc][count]="()"
															count++	
															newresult1:=parseArgList(t1[1:indexOfNewClosePar])
															newresult2:=parseType(t2)
															
														//fmt.Println("I am in other part")
														x[inc][count]="()"
														count++	
														return newresult1 && newresult2
															
														}
														if(strings.Trim(dupstr[indexOfClosePar+3:]," ")==""){
															return false
														}
														x[inc][count]="()"
														count++	
															
														t3:=strings.Trim(dupstr[0:indexOfClosePar+1]," ")
														t4:=strings.Trim(dupstr[indexOfClosePar+3:]," ")
														//fmt.Println("I am in first part | t3 = "+t3[1:indexOfClosePar]+" | t4 = "+t4)
														result1:=parseArgList(t3[1:indexOfClosePar])
														result2:=parseType(t4)
														
														
														return result1 && result2
														 
													} else {//else 5
															//fmt.Println("first char not '('")
															
															if(str[0]=='['){
																
																	listType:=parseListType(str)
																	return listType
																} else{
																//fmt.Println("ERR")// : Wrong Input")	
																return false
																//os.Exit(1)
															}
														
														}
											}
						}
		
			}
	
	func parseVarName(str string) bool {

			if(!(len(str)>=2)){
				//fmt.Println("Var Length not > 2")
				return false
			}
			
			if(!(str[1]>='a' || str[1]<='z' || str [1]>='A' || str[1]<='Z')) {
						//fmt.Println("2nd char is not a-z")
						return false
						}
			if(len(str)>2){
				temp:=str[2:]
				//fmt.Println("Temp : "+temp)
				for i:=0;i<len(temp);i++ {
						//fmt.Println("In for loop")
						if(!((temp[i]>='a' && temp[i]<='z') || (temp[i]>='A' && temp[i]<='Z') || (temp[i]>='0' && temp[i]<='9'))){
						//fmt.Println("Charachter not in a-z 0-9")
						return false
							}
					}
				}
			x[inc][count]=str
			count++
			return true
	
	}
	
	/*if (argList[0]=='('){
							return parseType(argList[0:indexOfComma])
								} */
	func parseArgList(argList string) bool {
		//fmt.Println("In Parse arg List")
		var indexOfComma int=-1
		if(argList=="") {
			return true
			} else{
				indexOfComma=strings.LastIndex(argList,",")
				
					if(indexOfComma==-1){
						
						//fmt.Println("Send argList "+argList+" to parseType")
						return parseType(argList)
						
					} 
				if(argList[0]=='('){
				//indexOfComma=strings.LastIndex(argList,",")
				//indexOfClosePar:=strings.LastIndex(argList,")")
				r1:= parseType(argList[0:indexOfComma])
				//fmt.Println(argList[:indexOfComma])
				r2:= parseType(argList[indexOfComma+1:])
				return r1 && r2
				} else {
							//fmt.Println("Split argList "+argList+" on comma ")
							indexOfComma=strings.Index(argList,",")
							typ:=argList[0:indexOfComma]
							result1:= parseType(strings.Trim(typ," "))
							arg:=strings.Trim(argList[indexOfComma+1:]," ")
							if(len(arg)<=0){
								//fmt.Println("Nothing after Comma")
								return false
							}
							//fmt.Println("arg in parseArgList Function "+arg)
							result2 := parseArgList(strings.Trim(arg," "))
							return result1 && result2
						}
				
				}
	}
	
	func parseFuncType(str string) bool {
		//fmt.Println("In Func Type")
		x[inc][count]="()"
		count++				 
		return parseArgList(strings.Trim(str," "))
				
		}
	
	func parseListType(str string) bool {
		indexOfSquarePar:=strings.LastIndex(str,"]")
		if(indexOfSquarePar==-1) {//if 6
			fmt.Println("ERR")//:type is ListType but no closing ']'")
		 	return false
		 }
		x[inc][count]="[]"
		count++
		return parseType(strings.Trim(str[1:len(str)-1]," "))
	}