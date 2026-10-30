resource "datadog_dashboard" "eks_production_dashboard" {
  title        = "EKS Production Cluster Overview"
  description  = "Production-grade overview covering cluster utilization, node health, and core workloads."
  layout_type  = "ordered"
  reflow_type  = "auto"

  # 1. Template Variables for Dynamic Filtering
  template_variable {
    name    = "env"
    prefix  = "env"
    defaults = ["production"]
  }

  template_variable {
    name    = "cluster"
    prefix  = "kube_cluster_name"
    defaults = ["rohit-eks"]
  }

  # ----------------------------------------------------------------------------
  # SECTION 1: Cluster High-Level KPIs
  # ----------------------------------------------------------------------------
  widget {
    group_definition {
      title       = "Overview & Health KPIs"
      layout_type = "ordered"

      widget {
        query_value_definition {
          title      = "Total Active Nodes"
          live_span  = "1h"
          precision  = 0
          request {
            q          = "sum:kubernetes.nodes.ready{kube_cluster_name:$cluster} by {kube_cluster_name}"
            aggregator = "last"
          }
        }
      }

      widget {
        query_value_definition {
          title      = "Running Pods"
          live_span  = "1h"
          precision  = 0
          request {
            q          = "sum:kubernetes.pods.running{kube_cluster_name:$cluster} by {kube_cluster_name}"
            aggregator = "last"
          }
        }
      }

      widget {
        query_value_definition {
          title      = "CPU Requests Utilization"
          live_span  = "1h"
          autoscale  = true
          custom_unit = "%"
          request {
            q          = "(sum:kubernetes.cpu.requests{kube_cluster_name:$cluster} / sum:kubernetes.cpu.capacities{kube_cluster_name:$cluster}) * 100"
            aggregator = "avg"
          }
        }
      }
    }
  }

  widget {
    group_definition {
      title       = "Node Utilization & Golden Signals"
      layout_type = "ordered"

      widget {
        timeseries_definition {
          title     = "Node CPU Utilization (%)"
          live_span = "1h"

          request {
            q            = "avg:system.cpu.user{kube_cluster_name:$cluster} by {host} + avg:system.cpu.system{kube_cluster_name:$cluster} by {host}"
            display_type = "line"
          }
        }
      }

      widget {
        timeseries_definition {
          title     = "Memory Usage by Node"
          live_span = "1h"

          request {
            q            = "avg:system.mem.pct_usable{kube_cluster_name:$cluster} by {host}"
            display_type = "line"
          }
        }
      }

      widget {
        timeseries_definition {
          title     = "Network I/O (Bytes/sec)"
          live_span = "1h"

          request {
            q            = "avg:system.net.bytes_sent{kube_cluster_name:$cluster} by {host}"
            display_type = "line"
          }

          request {
            q            = "avg:system.net.bytes_rcvd{kube_cluster_name:$cluster} by {host}"
            display_type = "line"
          }
        }
      }
    }
  }

  widget {
    group_definition {
      title       = "Workload & Pod Status"
      layout_type = "ordered"

      widget {
        toplist_definition {
          title     = "Pods with High Container Restarts"
          live_span = "4h"

          request {
            q = "top(sum:kubernetes.containers.restarts{kube_cluster_name:$cluster} by {pod_name}, 10, 'mean', 'desc')"
          }
        }
      }

      widget {
        timeseries_definition {
          title     = "Disk Space Utilization"
          live_span = "1h"

          request {
            q            = "avg:system.disk.in_use{kube_cluster_name:$cluster} by {host} * 100"
            display_type = "area"
          }
        }
      }
    }
  }
}