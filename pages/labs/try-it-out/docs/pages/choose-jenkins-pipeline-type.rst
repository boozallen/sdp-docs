.. _Choose Jenkins Pipeline Type:

------------------------------
Choose a Jenkins Pipeline Type
------------------------------

Now that you have all the services you need running on Docker, you will now be choosing the type of Jenkins pipeline that you will be configuring for a Spring Boot API sample application that we created just for this guide.

To begin, navigate to the homepage of your Jenkins instance.

Click **New Item** on the left-hand menu to create a new Jenkins pipeline. 

.. image:: ../images/choose-jenkins-pipeline-type/click_new_item.png

For the **Item Name**, enter **sample-spring-boot-api**. Note that the **item name** you give it is arbitrary, but for consistency and referencing purposes, we'll be calling it **sample-spring-boot-api**. Below, you should see several options for the type of job to use. For the options that can currently be used with the Jenkins Templating Engine, they can be described as follows:
    
    * Pipeline: Use this option when you want a one off job that may or may not be tied to a Source Control Management(SCM) tool.
    * Folder: This option is useful for grouping things together that might not be connected otherwise to ensure they all inherit specific pipeline configurations. For example, if you had two GitHub repositories that were in different organizations, you could select this option, configure a configuration for it, and then create two new items (likely multipbranch pipelines) within the folder to be able to inherit from the original parent folder's pipeline configurations.
    * GitHub Organization: This option is useful for setting a single pipeline configuration for all repositories under a specific GitHub Organization at the same time.
    * Multibranch Pipeline: Use this option when you have a specific GitHub repository that you'd like to configure. When using this option, you cannot setup a child Git repository or Git organization to inherit from this item's configured pipeline configurations.

For the purposes of this guide, we will be using a **Multibranch Pipeline**, as we will only be configuring a pipeline for a single GitHub repository. The settings for the new pipeline should look like the following screen:

.. image:: ../images/choose-jenkins-pipeline-type/multibranch_pipeline_selected.png

Click **OK**. You should be taken to a screen to configure your new pipeline. 

To use the Jenkins Templating Engine, you will need to configure the configuration section 
labeled Jenkins Templating Engine to specify the Git repository where your pipeline configurations are stored,
the relative path to your Jenkinsfile, and the location of any Git repositories that contain library sources, which are essentially many of the tools that the Solutions Delivery Platform team has created to be already integrated with this platform (i.e. Git, Docker, SonarQube, Twistlock, etc.).
 
If you have been following this guide in order, you will not have already configured a GitHub repository with some pipeline configurations. You will be creating one in the next step.