# DNS Performance testing container image (bien.nguyen@f5.com)
Build the container image
```
docker build -t biennt/dnsperf .
```
run as docker container
```
docker run -it --name dnsperf1 -e 'datafile=example2k.txt' -e 'server=10.0.20.201' -e 'thread=2' biennt/dnsperf
```
or deploy to k8s
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dnsperf
  labels:
    app: dnsperf
spec:
  replicas: 8
  selector:
    matchLabels:
      app: dnsperf
  template:
    metadata:
      labels:
        app: dnsperf
    spec:
      containers:
      - name: dnsperf
        image: biennt/dnsperf
        imagePullPolicy: IfNotPresent
        env:
        - name: datafile
          value: "example2k.txt"
        - name: server
          value: "192.168.100.11"
        - name: thread
          value: "4"
      restartPolicy: Always
```
