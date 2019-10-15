## GitHub Workflow
###### This text will serve as a guide for the workflow that contributors are expected to follow when working in this repository.

### Index
1) [Master and Dev](#1---master-and-dev)
2) [Branching](#2---branching)
3) [Merging](#3---merging)
4) [Committing](#4---committing)
5) [Conflicts](#5---conflicts)
6) [Tips](#6---tips)

### 1 - Master and Dev
The two primary branches in this project are *master* and *dev*. These branches serve as the accumulation of all additions made in this project.

##### Master
The **master** branch will contain the most recent, deliverable version of our project and will generally be updated at the end of every sprint.
    It is vital that master branch always remains functional throughout the entire project and is only updated via fast forwards with the dev branch.
    The Git Master (see [roles](/Roles.md)) is the only individual who should update the master branch.

##### Dev
The **dev** branch will contain the most recent changes made to our project and will be used to sort out any discrepencies between other branches. 
    All other branches will branch off from dev, except for the master branch.
    The dev branch *should* be functional at all times, but is susceptible to errors as it will contain all development progress.

### 2 - Branching
Branches will have a particular naming convention to identify their task type and the sprint that they come from. The naming pattern can be interpreted as such:
```python
branchName = taskToken + "/" + "s" + sprintNumber + "/" + branchTitle
```
##### Task tokens
Task tokens provide means to categorize tasks into the various layers we will be working with in the project. 
The following table provides the current list of tokens we will be using.

| Token     | Task Name       | Purpose                                                                                                  |
| --------: | :--------------:  | -----------------------------------------------------------------------------  |
| ABE        | App back end    | Any code relating to the back end development of the mobile application. |
| AFE        | App front end    | Any code relating to the front end development of the mobile application. |
| API         | AWS API           | Any code relating to the API development on AWS.                                  |
| BUG       | Bug fix              | Any code used to quickly patch bugs on the dev branch.                           |
| DOC       | Documentation | Any documentation that should be included in the repository.                    |
| MDB       | AWS Mongo DB | Any code relating to the Mongo database development on AWS.              |
| RPI         | Raspberry Pi      | Any code relating to the Raspberry Pi.                                                      |
| SHT        | Shit                  | Any branch that is purely for trying shit out.                                              |


### 3 - Merging

### 4 - Committing

### 5 - Conflicts

### 6 - Tips