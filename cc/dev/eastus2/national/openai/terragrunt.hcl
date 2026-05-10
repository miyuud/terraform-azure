terraform {
  before_hook "deprecated_stack_guard" {
    commands = ["init", "plan", "apply", "destroy"]
    execute  = ["bash", "-lc", "echo 'Deprecated stack: use ../ai-foundry instead.' >&2; exit 1"]
  }

  # https://github.com/Azure/terraform-azurerm-avm-res-cognitiveservices-account/pull/99
  #source = "git::https://github.com/Azure/terraform-azurerm-avm-res-cognitiveservices-account.git//?ref=v0.6.0"
  source = "git::https://github.com/asttle-sigtech/terraform-azurerm-avm-res-cognitiveservices-account.git//?ref=patch-1"
}

include {
  path = find_in_parent_folders()
}

locals {
  rai_policy_name = "high-severity-filter-202504"
}

inputs = {
  kind     = "OpenAI"
  location = "eastus2"

  name     = "national-team"
  sku_name = "S0"

  cognitive_deployments = {
    "gpt-5.5" = {
      name = "gpt-5.5"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.5"
        version = "2026-04-24"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 1
      }
      rai_policy_name = local.rai_policy_name
    },
    "text-embedding-3-small" = {
      name = "text-embedding-3-small"
      model = {
        format  = "OpenAI"
        name    = "text-embedding-3-small"
        version = "1"
      }
      scale = {
        type     = "Standard"
        capacity = 350
        #capacity = 1000
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-41" = {
      name = "gpt-4.1"
      model = {
        format  = "OpenAI"
        name    = "gpt-4.1"
        version = "2025-04-14"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5-mini" = {
      name = "gpt-5-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5-mini"
        version = "2025-08-07"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5-nano" = {
      name = "gpt-5-nano"
      model = {
        format  = "OpenAI"
        name    = "gpt-5-nano"
        version = "2025-08-07"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5.1-codex-mini" = {
      name = "gpt-5.1-codex-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.1-codex-mini"
        version = "2025-11-13"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5.3-codex" = {
      name = "gpt-5.3-codex"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.3-codex"
        version = "2026-02-24"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5.4" = {
      name = "gpt-5.4"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4"
        version = "2026-03-05"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5.4-nano" = {
      name = "gpt-5.4-nano"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4-nano"
        version = "2026-03-17"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    },
    "gpt-5.4-mini" = {
      name = "gpt-5.4-mini"
      model = {
        format  = "OpenAI"
        name    = "gpt-5.4-mini"
        version = "2026-03-17"
      }
      scale = {
        type     = "GlobalStandard"
        capacity = 400
      }
      rai_policy_name = local.rai_policy_name
    }
  }

  custom_subdomain_name = "national-team"

  # content filters
  rai_policies = {
    high202504 = {
      name             = local.rai_policy_name
      base_policy_name = "Microsoft.Default"
      mode             = "Asynchronous_filter"
      content_filters = [
        # Inputs
        { name = "Hate", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Sexual", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Selfharm", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        { name = "Violence", blocking = true, enabled = true, severity_threshold = "High", source = "Prompt" },
        # Ouputs
        { name = "Hate", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Sexual", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Selfharm", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
        { name = "Violence", blocking = true, enabled = true, severity_threshold = "High", source = "Completion" },
      ]
    }
  }

  enable_telemetry = false
}
