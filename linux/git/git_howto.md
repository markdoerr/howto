
# git howto

## undo changes
# Revert changes to modified files.
    git reset --hard
  
## renaming branch
    git branch -m <newname>

## github and development branches

s. https://www.braintreepayments.com/braintrust/our-git-workflow

### initial preparations

    1 create new github repository
    1 clone repository
    1 rename origin: git remote rename origin github

    
    git checkout -b release1.0
    
    git checkout -b github_master
    
    
    # now working on master and related branches
    git checkout master
    
    # before commit
    
    vim VERSION
    vim CHANGELOG
    git add --all . ; git commit -am ""
    
### releasing

    git checkout release0.9
    git merge master
    
    git add --all . ; git commit -am ""
    vim CHANGELOG
    
### publication on github

    git checkout github_master
    git merge --squash release0.9 
    
    git commit -m "v0.0.1 data workflow skeleton"
    git tag v0.0.1 -m "v0.0.1"
    
    git push --tags github HEAD:master
    
    
    
