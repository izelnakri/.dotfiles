if pgrep devdocs
then
  pkill -f devdocs
else
  bash -c "exec -a devdocs devdocs-desktop"
fi
