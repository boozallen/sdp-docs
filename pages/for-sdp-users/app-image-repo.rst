.. _Application Image Repository: 
----------------------------
Application Image Repository
----------------------------

Images that get built via SDP will be pushed to a container image repository. 

.. csv-table:: Application Image Repository Settings
   :header: "Field", "Description"

   "libraries.docker.registry", "The container image repository where images will be pushed to."
   "libraries.docker.cred", "The Jenkins credential ID to log into the application image repository"


**Example Configuration**

.. code:: groovy

      docker{
        registry = "docker-registry.default.svc:5000/red-hat-summit" // "0.0.0.0:5000" // registry url
        cred = "sdp-docker-registry"// jenkins cred id to authenticate
      }
    }

