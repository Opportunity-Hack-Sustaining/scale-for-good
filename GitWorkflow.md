## GitHub Workflow
###### This text will serve as a guide for the workflow that contributors are expected to follow when working in this repository.

### Index
1) [Master and Dev](#1---master-and-dev)
2) [Branching](#2---branching)
3) [Merging](#3---merging)
4) [Committing](#4---committing)
5) [Conflicts](#5---conflicts)

### 1 - Master and Dev
The two primary branches in this project are *master* and *dev*. These branches serve as the accumulation of all additions made in this project.

#### Master
The **master** branch will contain the most recent, deliverable version of our project and will generally be updated at the end of every sprint.
    * It is vital that master branch always remains functional throughout the entire project and is only updated via fast forwards with the dev branch.
    * The Git Master is the only individual who should approve pull requests to the master branch.

#### Dev
The **dev** branch will contain the most recent changes made to our project and will be used to sort out any discrepencies between other branches. 
    * All other branches will branch off from dev, except for the master branch.
    * The dev branch *should* remain functional, but is susceptible to errors as it will contain all development progress.

### 2 - Branching
Branches will have a particular naming convention to identify their task type and the sprint that they come from. The naming pattern can be interpreted as such:
```python
branchName = taskToken + "/" + "s" + sprintNumber + "/" + branchTitle
```
An example of this naming convention being used for a branch name:
```
git checkout -b "doc/s1/ReadmeAndWorkflow"
```

#### Task tokens
**Task tokens** provide means to categorize tasks into the various layers we will be working with in the project. 
The following table provides the current list of tokens we will be using.

| Token     | Name               | Purpose                                                                                                  |
| --------: | :--------------:  | -----------------------------------------------------------------------------  |
| abe        | App back end     | Any code relating to the back end development of the mobile application. |
| afe         | App front end    | Any code relating to the front end development of the mobile application. |
| api         | AWS API            | Any code relating to the API development on AWS.                                  |
| bug        | Bug fix               | Any code used to quickly patch bugs on the dev branch.                          |
| doc        | Documentation  | Any documentation that should be included in the repository.                   |
| mdb       | AWS Mongo DB | Any code relating to the Mongo database development on AWS.              |
| rpi          | Raspberry Pi      | Any code relating to the Raspberry Pi.                                                      |
| sht         | Shit                   | Any branch that is purely for trying shit out.                                             |

#### Sprint number and branch title
The **sprint number** evidently represents the sprint number that the branch is currently being developed on.
The **branch title** is whatever name the branch creator decides to give to the branch. This name should be reasonably short and clearly identify the purpose behind this branch.

The intent behind this naming convention is to create a wildcard listing convention for all branches. 
By using the task token or sprint number, one could filter through the various branches to find the branches pertaining to that specific grouping.
For example, using `git branch --list "doc/*"` would list all branches categorized as documentation. Additionally, using `git branch --list "*/s1/*"` would list all branches that we developed during sprint 1.

### 3 - Merging
All development done in this project will be done by branching off from dev and remerging back into it. Any merge done onto the dev or master branch must be done through a pull request.
Pull requests must be reviewed by another team member and must have not merge conflicts to be approved. Additionally, any pull requests that do not pass semantic checks will not be approved (for more see the [Process Definitions guide](https://docs.google.com/document/d/1NESWm63OmFAcAY1dW_YJ7AVUofGFQQ8WwYitfEBta64/edit?usp=sharing)).

Merging between development branches can be done, but should ideally be reserved when one is the author of both branches being merged or both authors mutually agree that it is necessary.

### 4 - Committing
All commits that are not merging pull requests should be strictly done on development branches (i.e. never commit directly to dev or master). Furthermore, every commit should contain a commit message, as well as a *commit token*.

The convention in which commit messages are formatted is as follows:
```python
commitMessage = commitToken + ": " + actualCommitMessage
```

#### Commit tokens
**Commit tokens** are used to communicate the purpose of each commit. This will help developers write their commit messages much quicker as well as allow reviewers to understand the commit history for branches better.
The table below lists the commit tokens that we will currently be using for our commit messages.

| Token     | Name                | Purpose                                                                                                                                   |
| --------: | :---------------: | -----------------------------------------------------------------------------------------------------  |
| I             | Initial                 | Indicates the first commit for a branch.                                                                                      |
| U            | Update              | Indicates that this commit updates the current branch. Used for most commits.                         |
| M           | Merge                | indicates that this commit is for a merge. Usually done for fast forwards.                                    |
| R            | Ready               | Indicates that this commit is ready for dev.                                                                                |
| UR          | Update + ready | Indicates that this commit is updating the branch and is ready (only done after an *R* commit.) |

### 5 - Conflicts

The intention behind making all merges fast forwards is to avoid merge conflicts. However, it is likely that at some point when attempting to merge onto dev a merge conflict will occur.
In this scenario, it is the responsibility of the developer making the pull request to solve the merge conflict. If the merge conflict is occuring due to an addition of a particular branch, it may be helpful to have the developer of that branch review the pull request, to ensure that the branch's functionality is not tampered with.
