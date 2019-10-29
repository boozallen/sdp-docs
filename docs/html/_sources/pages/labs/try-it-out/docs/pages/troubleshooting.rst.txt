.. _try-it-out troubleshooting:

---------------------
Troubleshooting
---------------------

On this page, we'll be going over what we think might be some of the problems you might encounter while running our Try It Out Lab as well
as potential solutions to get past them.

============================
Deploy the DevOps Tools Page
============================

**Problem 1**: When I run the command ``docker-compose -f ./try-it-out/docker-compose.yaml up --build -d --scale sonar-scanner=0``, I get the following
error: 

    .. code-block:: bash

        No such file or directory: '././try-it-out/docker-compose.yaml

    **Solution**: Make sure that you are in the **sdp-labs** directory and not within a child directory such as the **try-it-out** directory. 
    In your current directory in your terminal, run ``pwd`` and make sure that the directory path ends with **sdp-labs**. If it doesn't,
    in your terminal, navigate to the **sdp-labs** directory and ensure that the path does end with **sdp-labs**.

**Problem 2**: When I run the command ``docker-compose -f ./try-it-out/docker-compose.yaml up --build -d --scale sonar-scanner=0``,
some Docker containers don't get started.

    **Solution 1**: It's very likely that you ran out of memory within your Docker engine due to all the Docker images you have within it.
    We suggest running the following command to get rid of all your unneeded Docker containers and Docker images. 

        .. code-block:: bash

            docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs docker rmi

        .. note:: 

            You cannot undo the effects of this command once it is done.

    **Solution 2**: Make sure that you have enough resources allocated to your Docker engine. 
    Follow the sections under the Advanced section to change the resources you allocate to Docker depending on if you're using
    `Docker for Windows`_ or `Docker for Mac`_.

        This lab requires the following resources allocated to Docker to ensure that all services run smoothly:
            
            - 2CPUs
            - 3.0GIB Memory
            - 1.0GIB Swap

    **Debugging Tip**: If the above solutions don't work when you run the ``docker-compose up`` command again, run the following command
    which will show the logs and hopefully provide some insight on why it's not working as expected:

        .. code-block:: bash
        
            docker-compose -f ./try-it-out/docker-compose.yaml up --build --scale sonar-scanner=0

.. _Docker for Windows: https://docs.docker.com/docker-for-windows/#advanced

.. _Docker for Mac: https://docs.docker.com/docker-for-mac/#preferences-menu

