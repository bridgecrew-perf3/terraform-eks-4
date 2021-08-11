locals {
  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${module.eks.eks_endpoint}
    certificate-authority-data: ${module.eks.eks_certificate_authority}
  name: ${module.eks.eks_id}
contexts:
- context:
    cluster: ${module.eks.eks_id}
    user: ${module.eks.eks_id}
  name: ${module.eks.eks_id}
current-context: ${module.eks.eks_id}
kind: Config
preferences: {}
users:
- name: ${module.eks.eks_id}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      args:
      - --region
      - ${var.region}
      - eks
      - get-token
      - --cluster-name
      - ${module.eks.eks_id}
      command: aws
      env:
      - name: AWS_PROFILE
        value: ${var.profile}
KUBECONFIG
}

resource "local_file" "kubeconfig" {
  count    = var.create_kube_config ? 1 : 0
  content  = local.kubeconfig
  filename = pathexpand("~/.kube/${module.eks.eks_id}")
}
