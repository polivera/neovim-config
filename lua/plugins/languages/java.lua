-- LSP configuration for Java (jdtls)
local M = {}

M.setup = function()
    -- Get the jdtls installation path from Mason
    local mason_registry = require("mason-registry")
    local ok, jdtls_pkg = pcall(mason_registry.get_package, "jdtls")
    if not ok or not jdtls_pkg:is_installed() then
        return
    end
    local jdtls_path = jdtls_pkg:get_install_path()

    -- Determine the OS-specific config directory
    local function get_os_config()
        if vim.fn.has("mac") == 1 then
            return "config_mac"
        elseif vim.fn.has("unix") == 1 then
            return "config_linux"
        else
            return "config_win"
        end
    end

    -- Get project name for workspace directory
    local function get_workspace_dir()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
        return workspace_dir
    end

    vim.lsp.config("jdtls", {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
            "-configuration", jdtls_path .. "/" .. get_os_config(),
            "-data", get_workspace_dir(),
        },
        root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
        settings = {
            java = {
                eclipse = {
                    downloadSources = true,
                },
                configuration = {
                    updateBuildConfiguration = "interactive",
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                format = {
                    enabled = true,
                },
            },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
            },
            contentProvider = { preferred = "fernflower" },
            extendedClientCapabilities = {
                progressReportProvider = false,
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        },
        init_options = {
            bundles = {},
        },
    })
end

return M
