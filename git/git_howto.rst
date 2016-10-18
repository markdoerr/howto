
git howto
=========

Creating a repository
_____________________

git repository initial preparations
------------------------------------

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
    vim README.rst
    vim LICENSE
    
    for python packages: 
      add MANIFEST.in
      setup.cfg
      setup.py 
      requirements.txt
      sphinx-apidoc -o docs . (s. http://www.sphinx-doc.org/en/stable/invocation.html#invocation-apidoc)
    
    vim .gitignore
    
    git add --all . ; git commit -am ""

git repo on local server
------------------------

If you were to not share the repositories, and just wanted to access them for yourself (like I did, since I have no collaborators), you’d do the following as yourself. Otherwise, do it as the Git user we added above.

If using the Git user, log in as them:

login git
Now we can create our repositories:

mkdir myrepo.git
cd !$
git --bare init
The last steps creates an empty repository. We’re assuming you already have a local repository that you just want to push to a remote server.

Repeat that last step for each remote Git repository you want.

Log out of the server as the remaining operations will be completed on your local machine.  


Commiting changes
_________________

    git commit -am "comment"
    

Undo changes
-------------


To correct the commit message, you simply "commit again" - without any staged changes but with the correct message:

    git commit --amend -m "This is the correct message"

In case you want to add some more changes to that last commit, you can simply stage them as normal and then commit again:

    git add some/changed/file.ext
    git commit --amend -m "commit message"

Revert changes to modified files
................................

To undo the last commit, "reset" command is used:

    git reset --soft HEAD~1

Reset will rewind your current HEAD branch to the specified revision. 
In our example above, we'd like to return to the one before the current revision - effectively making our last commit undone.

Note the --soft flag: this makes sure that the changes in undone revisions are preserved. After running the command, you'll find the changes as uncommitted local modifications in your working copy.

If you don't want to keep these changes, simply use the --hard flag. Be sure to only do this when you're sure you don't need these changes anymore.

    git reset --hard HEAD~1

Deleting last changes
.....................

    git reset --hard


Working with branchs
____________________

Renaming branch
---------------

# in current branch
    git branch -m <newname>

# general method
    git branch -m <oldname> <newname>



Simple Release
______________

    git checkout release0.9
    git merge master
    vim CHANGELOG
        
    git add --all . ; git commit -am ""

    
Publication on gitHub
_____________________


    git checkout github_master
    git merge --squash release0.9 
    
    git commit -m "v0.0.1 data workflow skeleton"
    git tag v0.0.1 -m "v0.0.1"
    
    git push --tags github HEAD:master

    
gitHub and development branches workflow
_________________________________________

Here oure current git workflow is described. Until prooven that this is not working well, we start with:

We maintain 4 branch types for each project:

 * master - Active development occurs on this branch
 * verX.Y-feature - in these branches we develop new features that are merged into the verX.Y. until a feature freeze, afterwards bug-fixes might be developed in separate branches
 
 * verX.Y - Release branch = (feature freeze), with bugfixes, contains versions and update of the changelog
 * github_master — We squash commits from the release branch into single “release” commits on this branch as well as tagging releases. This branch tracks github/master.
  

CREATING THE REPO
-----------------
s. braintree_ and [#]_ for more info

Make a new repository on GitHub
 * select right .gitignore and LICENSE (GPL3)
 
clone the repository:

    git clone https://github.com/dirname/project.git

    cd my_project

    git remote rename origin github # rename origin

    # before commit
    
    vim .gitignore
    vim VERSION
    vim CHANGELOG
    vim LICENSE
    vim README.rst # create a README.rst file in reStructuredText format
    for python packages: 
      add MANIFEST.in
      setup.py
    
    git add .
    
    git commit -am "basic config files added"
    git tag -a v0.0.1 -m 'Version 0.0.1'
    
    git checkout -b github_master
    
    git checkout master
    
    git checkout -b v0.1_release
    
    git checkout github_master
    
    git push --tags github HEAD:master # push the current branch’s HEAD to the master branch on the github remote.
    
    
    # adding local servers
    git remote add myserver git@our-git-server:repo.git

    # now working on master and related branches
    
    git checkout master

    
    
      setup.cfg (if required)
      requirements.txt
      sphinx-apidoc -o docs . (s. http://www.sphinx-doc.org/en/stable/invocation.html#invocation-apidoc)
    
    

Take a look at the visualization of the commit history on the sample project above. First we create a repo with three branches and two remotes. The remotes will be our internal git server (origin) and github.

    mkdir my_project
    cd my_project
    git init

    git remote add origin git@our-git-server:repo.git
    git remote add github git@github.com:username/repo.git
    
    touch README
    git add .
    git commit -m "initial commit"
    git push origin master
    
    git checkout -b release
    git push origin release
    
    git checkout -b github_master
    git push origin github_master



RELEASING
---------

Suppose we create three commits that add milk, eggs and fabric softener to our shopping_bag. After this work, we’re ready to release 1.0.0. First, we checkout the release branch and merge our changes in from master.

    git checkout release
    git merge master

Next, we bump the version to 1.0.0 and update the changelog. We preform this work on the release branch.

    vim VERSION
    vim CHANGELOG
    in case of a python project: sphinx-apidoc -o docs .
    
    git commit -am "updated changelog and bumped version"

We’re now ready to move to the github_master branch.

    git checkout github_master
    
We want to merge the changes from release into the github_master branch but we don’t want to see each individual commit. Git helps us out here with the git merge --squash command. This will merge all the changes from a specific ref, squash them into a single set of changes and leave the changes staged. We commit the staged changes with the message “1.0.0” and tag the commit.

    git merge --squash release
    git commit -m "1.0.0"
    
    git tag -a v0.0.1 -m 'Version 0.0.1' # git tag 1.0.0 -m "1.0.0"

With the commits squashed and tagged, it’s time to push to github. We want to push the current branch’s HEAD to the master branch on the github remote.

    git push --tags github HEAD:master
    #git push github HEAD:master
    

Last but not least, we need to push these changes to the branches on origin and merge the squashed commit back to release and master.

You may suspect that git would be confused merging a squashed commit back into branches containing the non-collapsed commits, but it all works just as expected. Git is smart enough to realize no changes need to be made when merging in the squashed commit, but we should still merge to keep our branches in sync.

    git push origin github_master
    
    git checkout release
    git merge github_master
    git push origin release
    
    git checkout master
    git merge release
    git push origin master

Our release is finished. If you look at the image above you’ll notice the nice cascade of commits from github_master to master as the squashed commit is merged.

BUG FIX RELEASES
----------------

Anxious to get back to work, we continue our development on master adding water balloons to our shopping_bag project. Suddenly, we find a bug — we don’t have a cheese pizza in the released code! We want to add a cheese pizza to a new release but ignore the water balloons commit (noted by the arrow below).

    commit visualization

First, we checkout the release branch.

    git checkout release

Next, we fix the bug on release. When the fix is complete it’s time to release the bug fix. First, we update the version and changelog.

    vim VERSION
    vim CHANGELOG
    git add .
    git commit -m "updated changelog and bumped version"

We then merge these changes into github_master squashed, tag the release and push these changes to github.

    git checkout github_master
    git merge --squash release
    
    git commit -m "1.0.1"
    git tag 1.0.1 -m "1.0.1"
    
    git push github HEAD:master

Finally we merge these changes back into release and master, pushing each branch to origin. These steps are the same as the previous release but are shown below for reference.

    git push origin github_master
    
    git checkout release
    git merge github_master
    git push origin release
    
    git checkout master
    git merge release
    git push origin master

With that, our bugfix release is complete and we can continue development on master.

SUMMARY
-------

This style of development works nicely for us at Braintree and we were happy to find a git workflow to make it possible. It allows us to commit early and often between releases while keeping our public repositories on github clean and noise-free. We think it’s a testament to git’s power and flexibility that it is able to adapt itself to our working style so nicely.

    
    
References
__________

.._braintree: https://www.braintreepayments.com/braintrust/our-git-workflow
..[#]: source/examples/git
