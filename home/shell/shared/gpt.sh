GPT_KEY_FILE=~/.gpt
if [ -f "$GPT_KEY_FILE" ]; then 
    export OPENAI_API_KEY=$(cat "$GPT_KEY_FILE")
else 
    echo "No gpt found"
fi

