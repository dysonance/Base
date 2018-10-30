#!/bin/sh

export USER_EMAIL="jamos125@gmail.com"
export USER_NAME="Jacob Amos"

git filter-branch -f --env-filter '
USER_EMAIL="$USER_EMAIL"
USER_NAME="$USER_NAME"
if [ "$GIT_COMMITTER_EMAIL" != "$USER_EMAIL" ]; then
    if [ "$GIT_COMMITTER_NAME" = "$USER_NAME" ]; then
        export GIT_AUTHOR_NAME="$USER_NAME"
        export GIT_AUTHOR_EMAIL="$USER_EMAIL"
        export GIT_COMMITTER_NAME="$USER_NAME"
        export GIT_COMMITTER_EMAIL="$USER_EMAIL"
    fi
fi
' HEAD
