# Kubernetes troubleshooting cheatsheet (lite)

Three branches only: Pending, CrashLoopBackOff, and ImagePullBackOff. Namespace `shop`, pod `shop-api-7d9f8c6b5d-abcde`. The full pack adds OOM, DNS, Service, Ingress, Node NotReady, PVC, the decision-tree PNG, and the rest of the manifests.

## Pod Pending

The scheduler has not placed the pod, or a volume is blocking `ContainerCreating`. Read Events at the bottom of `describe`, not the spec.

```bash
kubectl get pods -n shop -o wide
kubectl get pods -n shop --field-selector=status.phase=Pending -o wide
kubectl describe pod shop-api-7d9f8c6b5d-abcde -n shop
kubectl get events -n shop --sort-by=.lastTimestamp
kubectl describe nodes
kubectl get resourcequota -n shop
```

`FailedScheduling` plus `Insufficient cpu` means the request does not fit. `pending-pod.yaml` asks for 32 CPU so it stays Pending.

## CrashLoopBackOff

The process exits and kubelet backs off. The useful logs are the previous container.

```bash
kubectl describe pod shop-api-7d9f8c6b5d-abcde -n shop
kubectl logs shop-api-7d9f8c6b5d-abcde -n shop --all-containers --tail=200
kubectl logs shop-api-7d9f8c6b5d-abcde -n shop --all-containers --previous --tail=200
kubectl get pod shop-api-7d9f8c6b5d-abcde -n shop -o jsonpath='{.status.containerStatuses[*].restartCount}'
```

Exit 1 with an application trace is the process. `CreateContainerConfigError` is a missing ConfigMap or Secret. `OOMKilled` is a memory limit, covered in the full pack.

## ImagePullBackOff

There are no application logs until the image exists on the node.

```bash
kubectl describe pod shop-api-7d9f8c6b5d-abcde -n shop
kubectl get pod shop-api-7d9f8c6b5d-abcde -n shop -o jsonpath='{.status.containerStatuses[*].state}'
kubectl get secrets -n shop
kubectl get serviceaccount shop-api -n shop -o yaml
```

`manifest unknown` is a bad tag (`imagepull-pod.yaml`). `unauthorized` means the ServiceAccount has no `imagePullSecrets` for that registry.

## Collect the first files

```bash
bash triage.sh shop ./triage-out
```

The lite script writes `pods.txt`, `events.txt`, and describe/logs for pods whose STATUS is not `Running` or `Completed`.
