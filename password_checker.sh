#!/bin/bash
#===============================================================================
#
#          FILE:  password_checker.sh
# 
#         USAGE:  ./password_checker.sh 
# 
#   DESCRIPTION:  Test a password for basic complexity requirements. 8 char, Upper, Lower, Symbol, Num. Does not exist in Rockyou.
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Brandon Wittet (), Brandon.wittet@gmail.com
#       COMPANY:  Open Source
#       VERSION:  1.0
#       CREATED:  2022-08-08 08:44:31 AM PDT
#      REVISION:  ---
#===============================================================================

function main () {

	check_args "$@"; return_val=$?
	
	if [[ "${return_val}" -ne 0 ]]; then
		echo "Enter a single argument only"
		exit 1
	fi
	
	check_cmplx $1
	

}    # ----------  end of function main  ----------



function check_args () {

	if [[ ${#@} -gt 1 ]]; then
		return 1
	return 0
	fi


}    # ----------  end of function check_args  ----------



function check_cmplx () {

	if [[ "${#1}" -lt 8 ]]; then
		printf "Password is %s characters long. Must be at least 8" "${#1}"
		exit 1
	fi	
	
	cmplx_check=$(echo "${1}" | sed '0,/[[:lower:]]/{s//~/}' | sed '0,/[[:upper:]]/{s//~/}' | sed '0,/[[:digit:]]/{s//~/}' | sed '0,/[!@#$%^&*()]/{s//~/}')
	sorted=$(echo "${cmplx_check}" | grep -o . | sort | tr -d "\n")
	
	if [[ "${sorted}" =~ .*~~~~.* ]]; then
		printf "Password meets requirements"
		exit 0 
	fi

	printf "Password is missing requirements. Must contain upper, lower, nums and special chars"
	exit 1
	
	

}    # ----------  end of function check_cmplx  ----------

main "$@"
