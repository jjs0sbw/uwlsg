# UW Linux Study Group

## Quarter One Material

Vagrant CentOS 6.6 configuration files:

  Vagrant shell provider [DONE]

  Vagrant Ansible provider [In Work]

  Vagrant Docker provider [To Do]

## Quarter Two Material

Vagrant CentOS 7.3 configuration files:

  Vagrant shell provider [To Do]

  Vagrant Ansible provider [To Do]

  Vagrant Docker provider [To Do]

## Quarter Three Material

Vagrant Ubuntu 16.04 configuration files:

  Vagrant shell provider [To Do]

  Vagrant Ansible provider [In Work]

  Vagrant Docker provider [To Do]


  ## Start new notes repository
  ### Outline ideas and issues associated with DevOps
  #### Main tasks and approach
    Track One: Teraform script to deploy Gitlab on Digital Ocean.  (Adrian -
    lead contact)
    -- First cycle of Gitlab deploy-distroy-redeploy is complete. (09-24-2017)

    Track Two: Ansible or Kitchen script to automate the republishing of a
    local git repo to the cloud repo after the original cloud repo has
    been destroyed and rebuilt. (Joe -- lead contact)
    -- First cycle completed by hand. Need to create a script. (09-24-2017)

    Track Three: Kitchen scripts to test Digital Ocean configuration of
    a newly deployed Gitlab system. (Cho - lead contact)
    -- Need to work Github commands and update process. (09-24-2017)

    At this time the study group is all about system configuration and
    provisioning.  

    Task 1: Adrian is building a script that will allow anyone with a
    unused domain name, a Digital Ocean account and a public ssh key to
    deploy Gitlab to Digital Ocean with a single "apply" command.  Very
    useful, eliminates some areas for human error.  From time to time
    Adrian will completely destroy the Gitlab instance on Digital Ocean
    and redeploy a new exact same copy on Digital Ocean.  This is the
    general plan.

    Task 2: Joe is creating a script to redeploy a git repository from a
    local system (laptop) back to Digital Ocean after a new Gitlab
    instance has been deployed.

    Task 3: Cho is exploring the construction of a Kitchen script to
    test the deployed Gitlab configuration and settings.

    Once we get the Gitlab automatic deployment working and tested then
    we will move toward adding separate storage volumes as well as a
    CI/CD process for our new Gitlab instance.

    ### General System Architecture Approach
    Our system has three levels, 1) Github, 2) Gitlab and 3) Gitlab Projects.

    #### Github [Level One]
    The Level One system component contains the scripts needed to deploy Gitlab
    to Digital Ocean.


  #### Overview of Terraform Up & Running
  First read the book: "Terraform Up & Running." Presents a good overview
  of DevOps and standard DevOps tools.

  The next step is to figure out how all the software tools in the DevOps
  space are related.  These tools are:
   1. Chef
   2. Puppet
   3. Ansible
   4. SaltStack
   5. OpenStack Heat
   6. Teraform

  Configuration-Provisioning:
  Chef, Puppet, Ansible and SaltStack are configuration management tools.
  Teraform and OpenStack Heat are provisioning tools.

  Mutable-Immutable infrastructure:
  Chef, Puppet, Ansible and SaltStack default to a mutable infrastructure
  paradigm. Teraform and OpenStack Heat default to an immutable
  infrastructure paradigm.

  Declarative-Procedural Language:
  Chef and Ansible encourage a procedural style approach where the code specifics
  how to achieve an end state, using a step by step process.  Terraform, Saltstack,
  Puppet, and Openstack Heat all use a declaritive syle language where the end
  state is specified and the tool figures out how to achieve the state.

  Masterless-Master Mode
  Ansible, Openstack Heat and Terraform all ar ematerless by default.  By default,
  Chef, Puppet and Saltstack all require the use of an master server.

  Agentless-Agent software
  Ansible, Openstack Heat and Terraform do not require the installation of any
  extra agents.  Saltstack, Puppet and Chef all require the installation of agents.

  Chef, Ansible and Puppet appear to be the most popular tools with Terraform and
  Saltstack a close second.  Terraform is the newest tool set with the other tools
  sets all having about 4 or 5 more years of maturity.
