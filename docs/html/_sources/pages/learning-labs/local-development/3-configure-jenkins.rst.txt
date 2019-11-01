.. Local Development Configure Jenkins: 

-------------------
Configuring Jenkins
-------------------

In the last section, we ran a local Jenkins instance via Docker and validated 
it's running on ``http://localhost:8080``. 

Now, we're going to configure that Jenkins instance by: 

* Entering the initial admin password
* Installing the default suggested plugins 
* Installing the Jenkins Templating Engine

======================
Initial Admin Password
====================== 

There are *two* ways to get the initial admin password for Jenkins. 

***************
1. Cat the file
*************** 

The initial admin password is stored in ``/var/jenkins_home/secrets/initialAdminPassword`` within the container. 

You can print this password in your terminal by running: ``docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword``

.. image:: ../../../images/learning-labs/local-development/cat-init-password.png

Copy and paste this password into the text box in Jenkins. 

.. note:: 

    If you're using a mac, i'd recommend running ``docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword | pbcopy``
    which will automatically insert the password into your clipboard for pasting. 

***********************************
2. Fetch it from the container logs
*********************************** 

The initial admin password is also printed to standard out while Jenkins starts up.  To view the Jenkins logs, run 
``docker logs jenkins``.  

In the output, you should see something similar to this: 

.. image:: ../../../images/learning-labs/local-development/logs_init_password.png 
   :align: center 

Copy and paste the password into the text box in Jenkins. 

================================
Installing the Suggested Plugins
================================

After entering the initial admin password, Jenkins will bring you to a *Customize Jenkins* page. 

Click the ``Install suggested plugins`` button. 

This will bring you to a loading screen displaying the progress as Jenkins installs the most popular 
community plugins. 

========================
Setup Initial Admin User
========================

After the plugins are done installing, Jenkins will send you to a screen to configure the default 
admin user.  

.. image:: ../../../images/learning-labs/local-development/initial_admin_user.png 
   :align: center 

Feel free to create a custom username and password or continue as admin. 

.. important:: 

    If you click "continue as admin" then the username will be ``admin`` and the password
    will be the initial admin password we found earlier. 

======================
Instance Configuration 
======================

After creating the initial admin user, Jenkins will send you to a screen where you can
configure the instance's URL.  The text box will be prepopulated with what's currently 
in your browser, so click *Save and Finish* in the bottom righthand side of the screen. 

========================================
Installing the Jenkins Templating Engine
========================================

At this point, you've completed the Jenkins Startup Wizard process.  Click "*Start Using Jenkins*" 
and you will be directed to the Jenkins home page. 

.. image:: ../../../images/learning-labs/local-development/jenkins-home-page.png 
   :align: center 

Now, we're going to install the Jenkins Templating Engine, which can be found as the
``Templating Engine Plugin`` in the Jenkins Update Center. 

1.  In the lefthand navigation menu, select *Manage Jenkins* 
2.  In the middle of the screen, Select *Manage Plugins* 
3.  Select the *Available* tab at the top
4.  In the upper right *Filter* text box, type: ``Templating Engine``

At this point you should see: 

.. image:: ../../../images/learning-labs/local-development/jte-update-center.png 
   :align: center 

Make sure to select the Templating Engine Plugin and click
"*Download now and install after restart*". 

This will direct you to a screen showing the download progress of JTE.  

The plugin will not become active until you select 
"*Restart Jenkins when installation is complete and no jobs are running*". 

.. image:: ../../../images/learning-labs/local-development/restart-post-install-jte.png
   :align: center 

At this point, Jenkins will restart automatically.  Log in again with either the custom 
admin user you created earlier or the initial admin password. 

.. important::

    You can run ``docker logs -f jenkins`` to see the Jenkins logs.  It will say
    "Jenkins is fully up and running" when Jenkins has completed the restart and 
    is ready to be interacted with. 