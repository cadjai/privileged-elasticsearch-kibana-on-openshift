# privileged-elasticsearch-kibana-on-openshift
Deploying elastic.co elasticsearch and kibana as privileged containers on OpenShift Container platform
This version deploys elasticsearc:5.6.8 and kibana:5.6.8 but any newer version can be deployed using these configurations. 
All that is required is to create all the rquired openshift objects (scc, sa, cm,...) and then the templates. You can create each of those running the `oc create -f <filename>` command.

