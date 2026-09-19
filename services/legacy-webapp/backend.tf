terraform {
  cloud {

    organization = "leshawn-rice"

    workspaces {
      name = "test-workspace"
    }
  }
}
