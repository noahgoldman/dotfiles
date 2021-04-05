function k-pod-ip() {
    if [[ $# -ne 1 ]]; then
        echo "Expected a single argument (pod name)"
        return 1
    fi
    kubectl get pods -ojson $1 | jq -r '.status.podIPs | first | .ip'
    return 0
}
