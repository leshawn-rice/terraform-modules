locals {
  # Flatten the databases/containers map into a single map of containers keyed by
  # "<database>/<container>" so each container can be created with for_each.
  containers = merge([
    for database_name, database in var.databases : {
      for container_name, container in database.containers :
      "${database_name}/${container_name}" => merge(container, {
        database_name  = database_name
        container_name = container_name
      })
    }
  ]...)
}
