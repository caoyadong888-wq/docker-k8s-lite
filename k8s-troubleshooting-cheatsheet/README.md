# Kubernetes troubleshooting cheatsheet (lite)

Free subset: Pending, CrashLoopBackOff, and ImagePullBackOff, plus a short read-only collector.

## English

### Deliverables

- `deliverables/cheatsheet.md` — three symptoms and the kubectl that reads them
- `deliverables/triage.sh` — pods, events, and describe/logs for unhealthy pods
- `examples/manifests/pending-pod.yaml`
- `examples/manifests/crashloop-deployment.yaml`
- `examples/manifests/imagepull-pod.yaml`

```bash
bash deliverables/triage.sh shop ./triage-out
```

The full pack adds OOMKilled, DNS, Service endpoints, Ingress, Node NotReady, PVC, the decision-tree PNG, the remaining manifests, and the wider `triage.sh`.

Full version: GUMROAD_URL

## 中文

免费子集只覆盖三类：Pending、CrashLoopBackOff、ImagePullBackOff，以及一个较短的只读收集脚本。

### 交付物

- `deliverables/cheatsheet.md`：三类症状和对应 kubectl
- `deliverables/triage.sh`：pods、events，以及对不健康 Pod 的 describe 和 logs
- `examples/manifests/` 里的三份示例清单

```bash
bash deliverables/triage.sh shop ./triage-out
```

完整版还包括 OOM、DNS、Service 端点、Ingress、节点 NotReady、PVC、决策图 PNG、其余清单，以及收集项更多的 `triage.sh`。

Full version: GUMROAD_URL
