local language, server, formatter, diagnostics, dap = unpack(require 'plugins.lsp.dsl')

return language {
  name = 'clang',

  server.configured {
    name = 'clangd',
  },

  formatter.disabled {},

  diagnostics.disabled {},

  dap.disabled {},
}
