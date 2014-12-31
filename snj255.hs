import Data.Char
import System.Exit

series a b c d = a:series b c d ((c+d)*b `div` a)

isInteger s = case reads s :: [(Integer, String)] of
  [(_, "")] -> True
  _         -> False
 
isDouble s = case reads s :: [(Double, String)] of
  [(_, "")] -> True
  _         -> False
 
isNumeric :: String -> Bool
isNumeric s = isInteger s || isDouble s

main = do
--putStrLn "Enter a command"
str <-getLine
--putStrLn str

if (str == "QUIT" )then do
	--putStrLn "I am in QUIT"
	exitWith ExitSuccess
else do
let cmd = takeWhile(/=' ') str
--putStr "Command is "
--putStrLn cmd

let list2 = dropWhile(/=' ') str
if null cmd || null list2 then do 		--if 1
	putStrLn "ERR" 	-- Command or Argument list is empty
	exitWith ExitSuccess

else do									--else of if 1
if length (tail list2) ==0 then do
	putStrLn "ERR"	-- : Length of Argument list is 0"
	exitWith ExitSuccess
else do
let temp = tail list2

let flag1 = ' ' `elem` temp 
--print flag1

if flag1 then do
	putStrLn "ERR" -- : Argument has spaces"
	exitWith ExitSuccess
else do

--putStrLn "Arguments do not contain space"

let flag = isNumeric temp
if not flag then do						--if 2
		putStrLn "ERR" 		-- : Argument has characters"
		exitWith ExitSuccess
	else do							--else of if 2

--putStr "Argument is "
let temp2 = takeWhile(/='.') temp
let arg = read temp2::Int
--print arg

if not (arg>=0) then do
		putStrLn "ERR"	-- : Argument not > 0"
		exitWith ExitSuccess
	else
		--putStrLn "Argument >= 0"
		if cmd=="NTH" && isInteger temp then do
	let arg1 = read temp::Int
	--putStrLn "I am in NTH"	--check if  num exceed the length of list
	print ((series 1 1 1 1) !! arg1)
		else if cmd == "SUM" && isInteger temp then do
			let arg1 = read temp::Int
			--putStrLn "I am in SUM"
			let s= take (succ arg1) (series 1 1 1 1)
			print (sum s)
			else if cmd =="BOUNDS" && arg > 0 then do
					
					let lb = takeWhile (<arg) (series 1 1 1 1) 		-- gives lower bound list	--INFINITE SERIES NOT ACCEPTABLE
					let x = length lb
					let hb = take (succ (succ x)) (series 1 1 1 1)	-- gives higher bound list	--INFINITE SERIES NOT ACCEPTABLE
					if null lb || null hb then do
						putStrLn "ERR"	--lower or higher bound list is empty"
						exitWith ExitSuccess
					else do
						print (last lb)
						if arg `elem` hb then 
							print (last hb)
						else
							print (last (init hb))
					--putStrLn "I am in BOUNDS"
					else do 
						putStrLn "ERR"	-- : Bad Command"
						exitWith ExitSuccess
main
