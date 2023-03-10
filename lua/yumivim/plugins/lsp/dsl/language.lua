local function language(config)
  local servers = {}
  local formatters = {}
  local diagnostics = {}
  local debuggers = {}

  for _, item in pairs(config) do
    -- Only validate and utilise tables, the rest are language level config opts
    if type(item) == 'table' then
      if item.type == 'server' then
        if item.configure_with == 'lspconfig' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            pre = { item.pre, 'function' },
            overrides = { item.overrides, 'table' },
            declared_config = { item.declared_config, 'table' },
            after = { item.after, 'function' },
          }
        elseif item.configure_with == 'external' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            setup = { item.setup, 'function' },
          }
        else
          print(('Unknown configure type %s'):format(item.configure_with))
        end

        table.insert(servers, item)
      elseif item.type == 'formatter' then
        if item.configure_with == 'null-ls' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            source = { item.source, 'table' },
          }
        elseif item.configure_with == 'lsp' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            declared_config = { item.declared_config, 'table' },
            overrides = { item.overrides, 'table' },
          }
        end

        table.insert(formatters, item)
      elseif item.type == 'diagnostics' then
        if item.configure_with == 'null-ls' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            source = { item.source, 'table' },
          }
        elseif item.configure_with == 'lsp' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            declared_config = { item.declared_config, 'table' },
            overrides = { item.overrides, 'table' },
          }
        end

        table.insert(diagnostics, item)
      elseif item.type == 'debugger' then
        if item.configure_with == 'dap' then
          vim.validate {
            type = { item.type, 'string' },
            configure_with = { item.configure_with, 'string' },
            adapter = { item.adapter, 'table' },
            config = { item.config, 'table' },
          }
        end

        table.insert(debuggers, item)
      elseif item.type == 'disabled' then
        -- Ignore
        vim.validate {
          type = { item.type, 'string' },
        }
      else
        print(('Unknown type %s'):format(item.type))
      end
    end
  end

  return {
    servers = servers,
    formatters = formatters,
    diagnostics = diagnostics,
    debuggers = debuggers,
    enabled = config.enabled or true,
  }
end

return language
