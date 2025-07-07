# data "azuread_domains" "example" {
#   only_initial = true
# }

resource "azuread_application" "internal" {
  display_name = "internal"
  owners = [
    "a37bca3e-66c3-4150-8029-500cb5d3181c",
  ]
  app_role {
    allowed_member_types = ["User"]
    description          = "Admins can perform all task actions"
    display_name         = "Admin"
    enabled              = true
    id                   = "00000000-0000-0000-0000-222222222222"
    value                = "Admin.All"
  }

  app_role {
    allowed_member_types = ["User"]
    description          = "Reders can read things"
    display_name         = "Reader"
    enabled              = true
    id                   = "00000000-0000-0000-0000-222222222333"
    value                = "Reader.All"
  }

  app_role {
    allowed_member_types = ["Application"]
    description          = "Externals can less"
    display_name         = "External"
    enabled              = true
    id                   = "00000000-0000-0000-0000-222222222444"
    value                = "External.All"
  }

  group_membership_claims = [
    "All",
    "ApplicationGroup",
    "DirectoryRole",
  ]
  identifier_uris = [
    "api://kaczka"
  ]

  api {
    known_client_applications      = []
    mapped_claims_enabled          = true
    requested_access_token_version = 2

    oauth2_permission_scope {
      admin_consent_description  = "a"
      admin_consent_display_name = "a"
      enabled                    = true
      id                         = "00000000-0000-0000-0000-000000000111"
      type                       = "User"
      user_consent_description   = "a"
      user_consent_display_name  = "a"
      value                      = "test"
    }

  }

  optional_claims {
    access_token {
      additional_properties = [
        "on_premise_security_identifier",
      ]
      essential = false
      name      = "groups"
    }
  }
  web {
    redirect_uris = [
      "http://localhost:8080/callback",
      "https://oidcdebugger.com/debug",
    ]

    implicit_grant {
      access_token_issuance_enabled = true
      id_token_issuance_enabled     = false
    }
  }

}

# data "azuread_client_config" "current" {}

resource "azuread_service_principal" "internal" {
  client_id = azuread_application.internal.client_id
}

resource "azuread_group" "admins" {
  display_name     = "admins"
  security_enabled = true
}

resource "azuread_app_role_assignment" "example" {
  app_role_id         = azuread_service_principal.internal.app_role_ids["Admin.All"]
  principal_object_id = azuread_group.admins.object_id
  resource_object_id  = azuread_service_principal.internal.object_id
}

resource "azuread_group" "readers" {
  display_name     = "readers"
  security_enabled = true
}

resource "azuread_app_role_assignment" "example2" {
  app_role_id         = azuread_service_principal.internal.app_role_ids["Reader.All"]
  principal_object_id = azuread_group.readers.object_id
  resource_object_id  = azuread_service_principal.internal.object_id
}

resource "azuread_application" "external" {
  owners = [
    "a37bca3e-66c3-4150-8029-500cb5d3181c",
  ]
  display_name = "external"
  group_membership_claims = [
    "All",
    "ApplicationGroup",
    "DirectoryRole",
  ]
  optional_claims {
    access_token {
      additional_properties = [
        "on_premise_security_identifier",
      ]
      essential = false
      name      = "groups"
    }
  }
  api {
    known_client_applications      = []
    mapped_claims_enabled          = true
    requested_access_token_version = 2

  }

  required_resource_access {
    resource_app_id = azuread_application.internal.client_id

    resource_access {
      id   = azuread_service_principal.internal.app_role_ids["External.All"]
      type = "Role"
    }
  }
}

resource "azuread_service_principal" "external" {
  client_id = azuread_application.external.client_id
}

resource "azuread_app_role_assignment" "external" {
  app_role_id         = azuread_service_principal.internal.app_role_ids["External.All"]
  principal_object_id = azuread_service_principal.external.object_id
  resource_object_id  = azuread_service_principal.internal.object_id
}
