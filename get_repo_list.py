from github import Github
import sys

g = Github(sys.argv[2])

def get_user_repos(username):
    repos = g.search_repositories(query="user:"+username+" fork:true")
    return repos

for repo in get_user_repos(sys.argv[1]):
    print(repo.name)
