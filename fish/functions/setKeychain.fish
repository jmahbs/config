function setKeychain --argument key
  if test (count $argv) -lt 1
    echo "Missing environment variable name"
  return 0
  else 
    read -s -l -p "echo 'Set keychain variable $key: ' ; echo '> '"  secret
    security add-generic-password -U -a $USER -D "environment variable" -s $key -w $secret
  end
end
