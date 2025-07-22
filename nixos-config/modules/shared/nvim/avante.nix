{ pkgs, ...}: {
  programs.nvf.settings.vim.extraPlugins = {
    avante-nvim = {
      package = pkgs.stdenv.mkDerivation {
        pname = "avante-nvim";
        version = "0.0.25";
        
        src = pkgs.fetchFromGitHub {
          owner = "yetone";
          repo = "avante.nvim";
          rev = "v0.0.25";
          hash = "sha256-lmyooXvQ+Cqv/6iMVlwToJZMFePSWoVzuGVV7jsSOZc=";
        };
        
        prebuiltLib = pkgs.fetchurl {
          url = "https://github.com/yetone/avante.nvim/releases/download/v0.0.25/avante_lib-darwin-aarch64-luajit.tar.gz";
          sha256 = "68e0af48c7303cd2df3f7f943d9a69d7b6e66a352151a0834c5ededf7b1990f6";
        };
        
        nativeBuildInputs = with pkgs; [ gnutar gzip ];
        
        buildPhase = ''
          # Create build directory and extract prebuilt binaries
          mkdir -p build
          tar -xzf $prebuiltLib -C build
        '';
        
        installPhase = ''
          mkdir -p $out
          cp -r . $out/
          
          # Ensure build directory is properly included
          chmod -R u+w $out
        '';
        
        dontFixup = true;
      };
    };
  };

    programs.nvf.settings.vim.luaConfigRC.avante = ''
    require('avante').setup({
      provider = "claude",
      auto_suggestions = false,

    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        api_key_name = "ANTHROPIC_API_KEY",
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4-turbo-preview",
        api_key_name = "OPENAI_API_KEY",
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
      
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4",
        api_key_name = "GITHUB_TOKEN",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false,
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },

    })
  '';
}
