function getKeychain --argument key
  if test (count $argv) -lt 1
    echo "Missing environment variable name"
  return 0
  else 
    security find-generic-password -w -a $USER -D "environment variable" -s $key
  end
end
