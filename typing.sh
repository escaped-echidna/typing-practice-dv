#!/usr/local/bin/bash

letter_array_for_comparison=(a b c d e f g h i j k l m n o p q r s t u v w x y z ";" "," "." "/" "'" "?" A B C D E F G H I J K L M N O P Q R S T U V W X Y Z "‰" "{" "}" "[" "]" ")" "(" "/" "*" "~" "!" "@" "#" "$" "%" "^" "&" "*" "()" "{}" "[]" "-" "--" "=" "+" "<" ">" "<-" "|" "<>" "μ" "δ")

symbol_array=(";" "," "." "/" "'" "?" "/" "*" "‰" "{" "}" "[" "]" ")" "(" "~" "!" "@" "#" "$" "%" "^" "&" "*" "()" "{}" "[]" "-" "--" "=" "+" "<" ">" " <- " "|" "<>" "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "_" "~")

#importing two letter data

two_letter_sets=( $(cut -d ',' -f1 letter_data.csv ) )
two_letter_sets[0]="th"

#importing three letter data

three_letter_sets=( $(cut -d ',' -f2 letter_data.csv ) )
three_letter_sets[0]="che"

#importing 1000 most common english words

common_words=( $(cut -d ',' -f3 letter_data.csv ) )
common_words[0]="the"


#importing SAT words

sat_words=( $(cut -d ',' -f4 letter_data.csv ) )
sat_words[0]="theremin"




#set parameters here
num_single_letters=19
num_two_letters=17
num_three_letters=13 
num_common_words=8 
num_sat_words=6 

current_correct=0;
current_incorrect=0;



main_menu()
{
	echo Welcome to Letter Combination Type Practice! 
	echo

	#read the menu options...
	menu_options

	echo 
	echo -n Please pick an number:
	read number


	while [ $number != 1 -a $number != 2 -a $number != 3 -a $number != 4 -a $number != 5 -a $number != 6  -a $number != 7 ]
	do
		echo
		echo "Please pick a number between 1 and 6!"
		echo	

		#read the menu options...
		menu_options

		echo 
		echo -n Please pick a number:
		read number
	done


	if test $number -eq 1
	then
		type_letters letters
	fi

	if test $number -eq 2
	then
		type_letters symbols
	fi

	if test $number -eq 3
	then
		type_letters two_letters
	fi

	if test $number -eq 4
	then
		type_letters three_letters	
	fi
	if test $number -eq 5
	then
		type_letters common_words	
	fi
	
	if test $number -eq 6
	then
		type_letters sat_words
	fi

	if test $number -eq 7
	then
		echo
	fi



}

type_letters(){

		prompt_type=$1
		response=""
		string_prompt="ERROR - NO STRING PROMPT GIVEN"

		echo
		echo --------------------------------------------------------
		echo


		case $prompt_type in 

			letters)
				echo Ok, lets type some letters!
				string_prompt=$(assemble_string_of_letters $num_single_letters) ;;


			symbols)
				echo Ok, lets type some symbols!
				string_prompt=$(assemble_string_of_symbols $num_single_letters) ;;


			two_letters)
				echo "OK, Let's type some two-letter combinations!"
				string_prompt=$(assemble_two_letters $num_two_letters) ;;

			three_letters)
				echo "OK, Let's type some three-letter combinations!" 
				string_prompt=$(assemble_three_letters $num_three_letters) ;;

			common_words)
				echo "OK, Let's type some of the 1000 most common English words!" 
				string_prompt=$(assemble_common_words $num_common_words) ;;
			sat_words)
				echo "OK, Let's type some SAT vocabulary words!" 
				string_prompt=$(assemble_sat_words $num_sat_words) ;;


		esac

		echo
		echo "Enter '4' if you want to go back" 
		echo "to the main main menu, '5' to quit"
		echo
		echo type the following:
		echo
		echo ":: ""$string_prompt"
		echo -n ":: "
		read response

		while [ "$response" != "4" -a "$response" != "5" ]

		do
			echo 
			if [ "$response" == "$string_prompt" -o "$response" == "${string_prompt} " ]
			then
				correct_response
			else
				incorrect_response
			fi

			echo 
			echo "Anyway, Here's the next set:            [4] MAIN MENU"
			echo "                                        [5] QUIT"
			echo 

			case $prompt_type in 

				letters)
					string_prompt=$(assemble_string_of_letters $num_single_letters) ;;

				symbols)
					string_prompt=$(assemble_string_of_symbols $num_single_letters) ;;

				two_letters)
					string_prompt=$(assemble_two_letters $num_two_letters) ;;

				three_letters)
					string_prompt=$(assemble_three_letters $num_three_letters) ;;
				
				common_words)
					string_prompt=$(assemble_common_words $num_common_words) ;;

				sat_words)
					string_prompt=$(assemble_sat_words $num_sat_words) ;;



			esac
			echo ":: ""$string_prompt"
			echo -n ":: "
			read response
			if [ "$response" == "5" -o $response == 5 ]
			then
				echo
				echo "Goodbye!"
				quit="yes"
				echo
				break
			fi

		done

		if [ "$response" == "5" -o "$quit" == "yes" ]
		then
			echo
		else
			if [ $response == 4 -o "$response" == "4" ]
			then
				echo 
				echo ---------------------------
				echo 
				main_menu
			fi
		fi


}


assemble_string_of_letters(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#letter_array_for_comparison[@]}

	#initialize the string
	output_string=""


	#find a random number between 1 and the array length 

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked=${letter_array_for_comparison[$random_index]}
	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked"



	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do
		#find a random number between 1 and the array length (less one)

		random_index=$[ ( $RANDOM % $array_length ) ]

		letter_picked="${letter_array_for_comparison[$random_index]}"

		#add random letter to the end of the output...
		output_string="${output_string} "
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"
}


assemble_string_of_symbols(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#symbol_array[@]}

	#initialize the string
	output_string=""


	#find a random number between 1 and the array length

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked=${symbol_array[$random_index]}
	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked"



	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do
		#find a random number between 1 and the array length (less one)

		random_index=$[ ( $RANDOM % $array_length ) ]

		letter_picked="${symbol_array[$random_index]}"

		#add random letter to the end of the output...
		output_string="${output_string} "
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"
}



assemble_two_letters(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#two_letter_sets[@]}

	#initialize the string
	output_string=""

	#find a random number between 1 and the array length (less one)

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked_1=${two_letter_sets[$random_index]}

	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked_1"

	random_index_2=$[ ( $RANDOM % $array_length ) ]

	letter_picked_2=${two_letter_sets[$random_index_2]}

	#add random letter to the end of the output...
	output_string="${output_string} "
	output_string="${output_string}$letter_picked_2"

	random_index_3=$[ ( $RANDOM % $array_length ) ]

	letter_picked_3=${two_letter_sets[$random_index_3]}

	#add random letter to the end of the output...
	output_string="${output_string} "
	output_string="${output_string}$letter_picked_3"


	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do
		#initialize letter_picked

		letter_picked=""

		#find a random number, either 0 or 1 or 2

		random_index=$[ ( $RANDOM % 3 ) ]

		if [ $random_index == 1 ]
		then
			letter_picked=$letter_picked_1
		else
			if [ $random_index == 2 ]
			then
				letter_picked=$letter_picked_2

			else
				letter_picked=$letter_picked_3
			fi
		fi
	

		#add random letter to the end of the output...


		random_index_space=$[ ( $RANDOM % 5 ) ]
	
		space_thing=""

		if [ $random_index_space != 1 ]
		then
			space_thing=" "

		fi


		output_string="${output_string}$space_thing"
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"



}



assemble_three_letters(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#three_letter_sets[@]}

	#initialize the string
	output_string=""

	#find a random number between 1 and the array length (less one)

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked_1=${three_letter_sets[$random_index]}

	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked_1"

	random_index_2=$[ ( $RANDOM % $array_length ) ]

	letter_picked_2=${three_letter_sets[$random_index_2]}

	#add random letter to the end of the output...
	output_string="${output_string} "
	output_string="${output_string}$letter_picked_2"

	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do
		#initialize letter_picked

		letter_picked=""

		#find a random number, either 0 or 1 or 2

		random_index=$[ ( $RANDOM % 2 ) ]

		if [ $random_index == 0 ]
		then
			letter_picked=$letter_picked_1
		else	
			letter_picked=$letter_picked_2
		fi
	

		#add random letter to the end of the output...


		random_index_space=$[ ( $RANDOM % 5 ) ]
	
		space_thing=""

		if [ $random_index_space != 1 ]
		then
			space_thing=" "

		fi


		output_string="${output_string}$space_thing"
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"

}

assemble_common_words(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#common_words[@]}

	#initialize the string
	output_string=""

	#find a random number between 1 and the array length (less one)

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked_1="${common_words[$random_index]}"

	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked_1"

	
	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do

		#find a random number between 1 and the array length (less one)

		random_index=$[ ( $RANDOM % $array_length ) ]

		letter_picked="${common_words[$random_index]}"
		
		#add random letter to the end of the output...

		output_string="${output_string} "
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"

}


assemble_sat_words(){

	#set the length of the string you want to see
	number_of_items=$1

	#find length of the array

	array_length=${#sat_words[@]}

	#initialize the string
	output_string=""

	#find a random number between 1 and the array length (less one)

	random_index=$[ ( $RANDOM % $array_length ) ]

	letter_picked_1="${sat_words[$random_index]}"

	#add random letter to the end of the output...
	output_string="${output_string}$letter_picked_1"

	
	for  ((  i = 0 ;  i <= $number_of_items;  i++  ))
	do

		#find a random number between 1 and the array length (less one)

		random_index=$[ ( $RANDOM % $array_length ) ]

		letter_picked="${sat_words[$random_index]}"
		
		#add random letter to the end of the output...

		output_string="${output_string} "
		output_string="${output_string}$letter_picked"

	done

	echo "$output_string"

}





menu_options(){
	echo Choose from the following options...
	echo 
	echo "1) Letters and symbols"
	echo "2) Numbers and symbols"
	echo "3) Common 2-letter combinations"
	echo "4) Common 3-(or more)-letter combinations"
	echo "5) 1000 most common English words"
	echo "6) SAT words" 
	echo "7) Quit"

}




correct_response(){
current_correct=$(($current_correct+1))

echo --------------------------------------
echo
echo YES! Good Job.
echo
echo Current score is $current_correct correct and $current_incorrect incorrect
echo
echo --------------------------------------

}

incorrect_response(){

current_incorrect=$(($current_incorrect+1))

echo --------------------------------------
echo
echo Sorry, try again!
echo
echo Current score is $current_correct correct and $current_incorrect incorrect
echo
echo --------------------------------------

}



main_menu
