---
layout: post
title: A Git Cheatsheet
subtitle: A compilation of Git commands I frequently use
published: false
---

There are lots of tutorials out there and hard to pick one good one. Here are
a bunch:

http://sixrevisions.com/resources/git-tutorials-beginners/

And here are bookmarks I've found useful about git:

https://pinboard.in/search/u:seananderson?query=git

Here's one good one I remember:

http://rogerdudler.github.io/git-guide/

To work with GitHub you'll need to do this first:

https://help.github.com/articles/generating-ssh-keys

You'll also want to make sure your `.gitconfig` file matches your GitHub
account:

https://help.github.com/articles/setting-your-email-in-git

Then clone the link at the top of the main site. For example,

```
git clone git@github.com:seananderson/ss3sim.git
```

Then edit files.

Note that all future lines expect you to be somewhere within the main
folder. I.e. somewhere within "ss3sim" or a subfolder.

If there are any new files then add them:

```
git add R/my-new-file.r
```

And then commit them locally:

```
git commit
```

Now fill in a commit message that's less than 50 characters stating what you did. [A note about Git commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)

If I'm committing everything at once, I usually commit with this:

```
git commit -av
```

The `-a` means commit everything that's changed, even if I haven't added changed file with 'git add'. Drop the `a` if you only want to commit what you've manually added with ` add`. The `-v` means 'verbose', which helps to see all the changes you will commit.

Once you've committed all your changes, push your changes to the server:

```
git push
```

Oh, and before working you'll want to get in the habit of pulling any changes:

```
git pull
```

I use this as my cheat sheet for branching:
http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging

And for anything fancy I end up Googling it.

## Sean's branching cheat sheet

Create and checkout a new branch named `my-branch`:

```
git branch my-branch
git checkout my-branch
```

or, just:

```
git checkout -b my-branch
```

Now edit your branch. When you want to push the branch to the remote repository:

```
git push origin my-branch
```

You can switch to any branch by running:

```
git checkout my-branch
```

Remember that the main branch is named `master`.

If you want to pull in changes from a remote branch, first change to the branch and then run:

```
git pull
```

If you haven't had that branch locally yet, you can instead run:

```
git checkout --track origin/my-branch
```
to fetch and track a new remote branch.

If you want to pull in updates to `master` since your branch was created, run the following while in your branch:

```
git rebase master
```

To merge the branch into `master`:

```
git checkout master
git merge my-branch
```

Compare branches:

```
git diff branch_1..branch_2
git diff branch_1...branch_2
```

Delete a remote branch:

```
git push origin --delete my-branch
```

If you just want to delete a local branch (or a branch that was only local):

```
git branch -d my-branch
```

## Sean's forking cheat sheet

Fetch upstream (in a fork):

```
git fetch upstream
git merge upstream/master
```

Push upstream (from a fork):

```
git push
git push upstream
```
