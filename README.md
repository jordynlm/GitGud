# GitGud
Contains command line commands to make GitHub functionalities more effecient, especially in the case of performing commands on multiple repos simultaneously.

Before use, in addition to cloning, users will need to set environmental variable GITGUD_PATH as being the path to the cloned GitGud repository.

Usage of gitgudstackoverflow.py:

Execute `<command> 2>&1 | gitgudstackoverflow.py`

For example, if you aren't in a git repo, and you run "git pull 2>&1 | gitgudstackoverflow.py" will give the top comment result of googling the error message from what happens if you git pull outside of a repo.
