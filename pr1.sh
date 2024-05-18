#!/bin/bash
<<doc
Name: Avinash A
Date:
Title:
Sample I/O:
Sample O/P:
doc

b=0
clear
while [ $b -eq 0 ]
do
    echo -e " 1)login \n 2)sign up \n 3)exit"
    echo "Please sign up before logging in"
    read -p "Enter the option : " op
    case $op in
	1)
	    #echo "Login"
	    clear
	    a3=0
	    while [ $a3 -eq 0 ]
	    do
		read -p "Enter username : " usr
		arr1=(`cat username.csv`)
		arr2=(`cat password.csv`)
		flag=0
		l=${#arr1[@]}
		for i in `seq 0 $((l-1))`
		do
		    if [ ${arr1[i]} = $usr ]
		    then
			a3=1
			flag=1
			inx=$i
			break
		    fi
		done
		if [ $flag -eq 0 ]
		then
		    clear
		    echo -e "username does not exists"
		fi	       		
	    done
	    a4=0
	    while [ $a4 -eq 0 ]
	    do
		read -s -p "Enter the password : " pass
		if [ "$pass" = "${arr2[inx]}" ]
		then
		    clear 
		    echo "Login successful"
		    a4=1
		else
		    clear
		    echo "wrong password!!"
		fi
	    done
	    a5=0
	    while [ $a5 -eq 0 ]
	    do
		clear
		echo -e " 1)Instructions \n 2)Take a test \n 3)exit "
		read -p "Enter the option : " op
		case $op in
		    1)
			clear
			echo "Test instructions"
			echo "1) Test has total of 10 questions"
			echo "2) You cannot go back to the question answered"
			echo "3) You have 10sec to answer a question"
			echo
			read -p "Do you want to continue (y/n)?" var
			if [ $var = n ]
			then
			    exit
			fi
			;;
		    2)
			clear 
			for i in `seq 5 5 50`
			do
			    echo
			    head -$i question1.txt | tail -5
			    echo
			    for i in `seq 10 -1 1`
			    do
				echo -e -n "\r Enter the option $i : "
				read -t1 opt
				if [ ${#opt} -gt 0 ]
				then 
				    break; 
				else
				    opt=e
				fi
			    done
			    echo $opt >> userans.csv
			done
			echo
			echo "Successfully Test has been completed"
			echo
			read -p "Do you want to continue (y/n)?" var
			if [ $var = n ]
			then
			    exit
			fi
			j=1
			res=0
			clear
			for i in `seq 5 5 50`
			do
			    head -$i question1.txt | tail -5
			    cra=`cat crans1.csv | head -$j | tail -1`
			    echo
			    echo "The correct answer is $cra"
			    mya=`cat userans.csv | head -$j | tail -1`
			    echo "Your answer was $mya"
			    if [ $cra = $mya ]
			    then
				res=$((res+1))
			    fi		
			    j=$((j+1))
			    echo
			done
			echo "Total marks scored : $res/10"
			echo
			sed -i 1,10d userans.csv
		    	read -p "Do you want to continue (y/n)?" var
			if [ $var = n ]
			then
			    exit
			fi
			;;
		    3)
			exit
			;;	
		esac
	    done		    
	    ;;
	2)
	    # sign up
	    # echo "sign up"
	    clear
	    a1=0
	    while [ $a1 -eq 0 ]
	    do
		read -p "Enter the username : " usr
		flag=0
		arr=(`cat username.csv | tr "\n" " "`)
		for i in ${arr[@]}
		do
		    if [ $i = $usr ]
		    then
			clear
			echo "Username exists. Please enter different username"	
			flag=1
			break
		    fi
		done
		if [ $flag -eq 0 ]
		then
		    a1=1
		fi
	    done
	    #echo "username set"
	    a2=0
	    while [ $a2 -eq 0 ]   	
	    do
		read -s -p "Enter a password : " pass
		echo
		read -s -p "Confirm password : " confpass
		echo
		if [ $pass = $confpass ]
		then
		    clear
		    echo "username and password is set succesfully"
		    echo "Sign up Successfull"
		    echo
		    echo $usr >> username.csv
		    echo $pass >> password.csv
		    a2=1
		else
		    clear
		    echo -e "Password is not matching \nPlease try again"
		fi
	    done
	    ;;
	3)
	    echo "exit"
	    exit 
    esac
done 
