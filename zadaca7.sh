if [ $# -eq 0 ]; then
  echo "Send text files like arguments"
  exit 1
fi

for file in $*
do
  if [ -r "$file" ]; then
      cat "$file"
  fi
done
