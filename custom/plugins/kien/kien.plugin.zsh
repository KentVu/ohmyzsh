### adb
alias adb_='adb ${ADB_DEVICE:+-s $ADB_DEVICE}'

function adb_findPid {
    case "$1" in
        -r) 
			regex_syntax=$1 ; shift ;;
    esac
	sed="awk \"{print}\" ORS=\| |sed s/.$//"
	#echo $sed
	eval "adb_ shell ps -ef |grep -Ei \"$1\" |awk '{print \$2}'" "${regex_syntax:+|$sed}"
}
