#!/bin/sh
kubectl get applicationdeployments.deployment.stratum.swissre.com -A|grep -v AGE|awk '{print "kubectl delete applicationdeployments.deployment.stratum.swissre.com -n " $1 " " $2}'
kubectl get applicationnamespaces.deployment.stratum.swissre.com -A|grep -v AGE|awk '{print "kubectl delete -n default applicationnamespaces.deployment.stratum.swissre.com " $2}'
