.. _SDP Pipeline Images: 
-----------------------------
SDP Pipeline Image Repository
-----------------------------

You must specify the image repository where SDP will pull the pipeline container 
images from.  If you deployed SDP onto OpenShift, this is most likely the integrated
container registry. 


.. csv-table:: SDP Pipeline Image Repository Settings
   :header: "Field", "Description"

   "libraries.sdp.image.registry", "The container image repository where SDP pipeline images will be pulled from"
   "libraries.sdp.image.cred", "The Jenkins credential ID to log into the sdp image repository"


**Example Configuration**

.. code:: groovy

    libraries{
      sdp{
        images{
          registry = "https://docker-registry.default.svc:5000" // "http://0.0.0.0:5000" // registry url
          cred = "sdp-docker-registry"// jenkins cred id to authenticate
        }
      }
    }
