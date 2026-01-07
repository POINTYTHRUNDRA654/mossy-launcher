# Mossy Launcher - AI Programs Detection Script
# This script scans your computer for AI-powered programs that can be used with Mossy Launcher

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Mossy Launcher - AI Programs Scanner" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$foundPrograms = @()

# Function to check registry for installed programs
function Get-InstalledPrograms {
    param([string]$DisplayNamePattern)
    
    $registryPaths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    
    $programs = @()
    foreach ($path in $registryPaths) {
        try {
            $programs += Get-ItemProperty $path -ErrorAction SilentlyContinue | 
                Where-Object { $_.DisplayName -match $DisplayNamePattern }
        } catch {
            # Silently continue if registry path doesn't exist
        }
    }
    return $programs
}

# Function to add found program to results
function Add-FoundProgram {
    param(
        [string]$Name,
        [string]$Description,
        [string]$Path,
        [string]$Category
    )
    
    $script:foundPrograms += [PSCustomObject]@{
        Name = $Name
        Description = $Description
        Path = $Path
        Category = $Category
    }
}

Write-Host "Scanning for AI programs..." -ForegroundColor Yellow
Write-Host ""

# ========================================
# Desktop AI Assistants
# ========================================

Write-Host "[1/8] Checking for AI Desktop Applications..." -ForegroundColor Gray

# ChatGPT Desktop
$chatGptPaths = @(
    "$env:LOCALAPPDATA\Programs\ChatGPT\ChatGPT.exe",
    "$env:APPDATA\ChatGPT\ChatGPT.exe"
)
foreach ($path in $chatGptPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "ChatGPT Desktop" -Description "OpenAI ChatGPT desktop application" -Path $path -Category "AI Assistant"
        break
    }
}

# Check registry for ChatGPT
$chatGptReg = Get-InstalledPrograms "ChatGPT"
if ($chatGptReg) {
    $installLocation = $chatGptReg[0].InstallLocation
    if ($installLocation) {
        Add-FoundProgram -Name "ChatGPT" -Description "OpenAI ChatGPT" -Path $installLocation -Category "AI Assistant"
    }
}

# Claude Desktop
$claudePaths = @(
    "$env:LOCALAPPDATA\Programs\Claude\Claude.exe",
    "$env:APPDATA\Claude\Claude.exe"
)
foreach ($path in $claudePaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Claude Desktop" -Description "Anthropic Claude AI assistant" -Path $path -Category "AI Assistant"
        break
    }
}

# Perplexity Desktop
$perplexityPaths = @(
    "$env:LOCALAPPDATA\Programs\Perplexity\Perplexity.exe",
    "$env:APPDATA\Perplexity\Perplexity.exe"
)
foreach ($path in $perplexityPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Perplexity Desktop" -Description "Perplexity AI search assistant" -Path $path -Category "AI Assistant"
        break
    }
}

# ========================================
# AI-Powered Code Editors
# ========================================

Write-Host "[2/8] Checking for AI-Powered Code Editors..." -ForegroundColor Gray

# Cursor
$cursorPaths = @(
    "$env:LOCALAPPDATA\Programs\Cursor\Cursor.exe",
    "${env:ProgramFiles}\Cursor\Cursor.exe"
)
foreach ($path in $cursorPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Cursor" -Description "AI-powered code editor" -Path $path -Category "Code Editor"
        break
    }
}

# Visual Studio Code
$vscodePaths = @(
    "$env:LOCALAPPDATA\Programs\Microsoft VS Code\Code.exe",
    "${env:ProgramFiles}\Microsoft VS Code\Code.exe"
)
foreach ($path in $vscodePaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Visual Studio Code" -Description "Code editor (can have AI extensions like GitHub Copilot)" -Path $path -Category "Code Editor"
        break
    }
}

# GitHub Desktop (often paired with Copilot)
$ghDesktopPaths = @(
    "$env:LOCALAPPDATA\GitHubDesktop\GitHubDesktop.exe"
)
foreach ($path in $ghDesktopPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "GitHub Desktop" -Description "GitHub desktop client (integrates with Copilot)" -Path $path -Category "Development Tool"
        break
    }
}

# JetBrains IDEs (support AI Assistant)
$jetbrainsPaths = @(
    "${env:ProgramFiles}\JetBrains\PyCharm",
    "${env:ProgramFiles}\JetBrains\IntelliJ IDEA",
    "${env:ProgramFiles}\JetBrains\WebStorm",
    "$env:LOCALAPPDATA\Programs\PyCharm",
    "$env:LOCALAPPDATA\Programs\IntelliJ IDEA"
)
foreach ($path in $jetbrainsPaths) {
    if (Test-Path $path) {
        $ideName = Split-Path $path -Leaf
        Add-FoundProgram -Name "JetBrains $ideName" -Description "JetBrains IDE with AI Assistant support" -Path $path -Category "Code Editor"
    }
}

# ========================================
# Web Browsers with AI Features
# ========================================

Write-Host "[3/8] Checking for AI-Capable Web Browsers..." -ForegroundColor Gray

# Microsoft Edge (has Copilot built-in)
$edgePaths = @(
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles}\Microsoft\Edge\Application\msedge.exe"
)
foreach ($path in $edgePaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Microsoft Edge" -Description "Browser with built-in Copilot AI" -Path $path -Category "Web Browser"
        break
    }
}

# Google Chrome (supports AI extensions)
$chromePaths = @(
    "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
foreach ($path in $chromePaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Google Chrome" -Description "Browser (supports ChatGPT, Claude, and other AI extensions)" -Path $path -Category "Web Browser"
        break
    }
}

# Brave Browser (has AI assistant Leo)
$bravePaths = @(
    "${env:ProgramFiles}\BraveSoftware\Brave-Browser\Application\brave.exe",
    "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\Application\brave.exe"
)
foreach ($path in $bravePaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Brave Browser" -Description "Browser with built-in Leo AI assistant" -Path $path -Category "Web Browser"
        break
    }
}

# Arc Browser
$arcPaths = @(
    "$env:LOCALAPPDATA\Programs\Arc\Arc.exe"
)
foreach ($path in $arcPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Arc Browser" -Description "Browser with AI features" -Path $path -Category "Web Browser"
        break
    }
}

# ========================================
# AI Art & Image Generation
# ========================================

Write-Host "[4/8] Checking for AI Art & Image Generation Tools..." -ForegroundColor Gray

# Stable Diffusion (various implementations)
$stableDiffusionPaths = @(
    "C:\stable-diffusion-webui",
    "$env:USERPROFILE\stable-diffusion-webui"
)
foreach ($path in $stableDiffusionPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Stable Diffusion WebUI" -Description "AI image generation tool" -Path $path -Category "AI Art"
        break
    }
}

# AUTOMATIC1111 Stable Diffusion
if (Test-Path "$env:USERPROFILE\stable-diffusion-webui\webui.py") {
    Add-FoundProgram -Name "AUTOMATIC1111 SD WebUI" -Description "Stable Diffusion WebUI" -Path "$env:USERPROFILE\stable-diffusion-webui" -Category "AI Art"
}

# ComfyUI
$comfyPaths = @(
    "C:\ComfyUI",
    "$env:USERPROFILE\ComfyUI"
)
foreach ($path in $comfyPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "ComfyUI" -Description "Node-based Stable Diffusion interface" -Path $path -Category "AI Art"
        break
    }
}

# Midjourney (check for Discord which is used to access it)
if (Test-Path "$env:LOCALAPPDATA\Discord") {
    $discordApps = Get-ChildItem "$env:LOCALAPPDATA\Discord\app-*\Discord.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($discordApps) {
        Add-FoundProgram -Name "Discord" -Description "Can access Midjourney AI art generator" -Path $discordApps.FullName -Category "AI Art Access"
    }
}

# ========================================
# AI Writing & Productivity Tools
# ========================================

Write-Host "[5/8] Checking for AI Writing & Productivity Tools..." -ForegroundColor Gray

# Notion (has AI features)
$notionPaths = @(
    "$env:LOCALAPPDATA\Programs\Notion\Notion.exe"
)
foreach ($path in $notionPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Notion" -Description "Productivity tool with Notion AI" -Path $path -Category "Productivity"
        break
    }
}

# Obsidian (supports AI plugins)
$obsidianPaths = @(
    "$env:LOCALAPPDATA\Programs\Obsidian\Obsidian.exe",
    "$env:APPDATA\Obsidian\Obsidian.exe"
)
foreach ($path in $obsidianPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Obsidian" -Description "Note-taking app (supports AI plugins)" -Path $path -Category "Productivity"
        break
    }
}

# Grammarly Desktop
$grammarlyPaths = @(
    "$env:LOCALAPPDATA\Programs\Grammarly\Grammarly.exe"
)
foreach ($path in $grammarlyPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Grammarly" -Description "AI-powered writing assistant" -Path $path -Category "Writing Assistant"
        break
    }
}

# ========================================
# AI Voice & Audio Tools
# ========================================

Write-Host "[6/8] Checking for AI Voice & Audio Tools..." -ForegroundColor Gray

# ElevenLabs (if desktop app exists)
$elevenLabsPaths = @(
    "$env:LOCALAPPDATA\Programs\ElevenLabs\ElevenLabs.exe"
)
foreach ($path in $elevenLabsPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "ElevenLabs" -Description "AI voice generation tool" -Path $path -Category "AI Voice"
        break
    }
}

# OBS Studio (can be used with AI plugins)
$obsPaths = @(
    "${env:ProgramFiles}\obs-studio\bin\64bit\obs64.exe",
    "${env:ProgramFiles(x86)}\obs-studio\bin\32bit\obs32.exe"
)
foreach ($path in $obsPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "OBS Studio" -Description "Streaming software (supports AI plugins)" -Path $path -Category "Streaming/Recording"
        break
    }
}

# ========================================
# AI Development Frameworks
# ========================================

Write-Host "[7/8] Checking for AI Development Tools..." -ForegroundColor Gray

# Python (often used for AI/ML)
$pythonPaths = @(
    "$env:LOCALAPPDATA\Programs\Python\Python*\python.exe",
    "${env:ProgramFiles}\Python*\python.exe",
    "C:\Python*\python.exe"
)
$pythonFound = $false
foreach ($pattern in $pythonPaths) {
    $matches = Get-ChildItem $pattern -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($matches) {
        Add-FoundProgram -Name "Python" -Description "Programming language (used for AI/ML development)" -Path $matches.FullName -Category "Development Tool"
        $pythonFound = $true
        break
    }
}

# Anaconda / Miniconda (Python distribution for data science/AI)
$condaPaths = @(
    "$env:USERPROFILE\anaconda3\python.exe",
    "$env:USERPROFILE\miniconda3\python.exe",
    "C:\ProgramData\Anaconda3\python.exe",
    "C:\ProgramData\Miniconda3\python.exe"
)
foreach ($path in $condaPaths) {
    if (Test-Path $path) {
        $condaType = if ($path -match "Anaconda") { "Anaconda" } else { "Miniconda" }
        Add-FoundProgram -Name $condaType -Description "Python distribution for data science and AI/ML" -Path (Split-Path $path) -Category "Development Tool"
        break
    }
}

# Jupyter Notebook (check for common installation)
if (Get-Command jupyter -ErrorAction SilentlyContinue) {
    $jupyterPath = (Get-Command jupyter).Source
    Add-FoundProgram -Name "Jupyter Notebook" -Description "Interactive computing for AI/ML development" -Path $jupyterPath -Category "Development Tool"
}

# ========================================
# AI Gaming & Entertainment
# ========================================

Write-Host "[8/8] Checking for AI Gaming & Entertainment Tools..." -ForegroundColor Gray

# NVIDIA GeForce Experience (has AI features)
$nvidiaGFEPaths = @(
    "${env:ProgramFiles}\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe"
)
foreach ($path in $nvidiaGFEPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "NVIDIA GeForce Experience" -Description "Gaming software with AI features (DLSS, RTX)" -Path $path -Category "Gaming"
        break
    }
}

# Steam (many AI-powered games)
$steamPaths = @(
    "${env:ProgramFiles(x86)}\Steam\steam.exe",
    "${env:ProgramFiles}\Steam\steam.exe"
)
foreach ($path in $steamPaths) {
    if (Test-Path $path) {
        Add-FoundProgram -Name "Steam" -Description "Gaming platform (hosts AI-powered games)" -Path $path -Category "Gaming"
        break
    }
}

# ========================================
# Display Results
# ========================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "           Scan Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($foundPrograms.Count -eq 0) {
    Write-Host "No AI programs were detected on your computer." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "This doesn't mean you don't have AI programs - they may be:" -ForegroundColor Gray
    Write-Host "  • Installed in non-standard locations" -ForegroundColor Gray
    Write-Host "  • Web-based applications you access through browsers" -ForegroundColor Gray
    Write-Host "  • Programs not yet known to this detection script" -ForegroundColor Gray
} else {
    Write-Host "Found $($foundPrograms.Count) AI program(s) that can be used with Mossy Launcher:" -ForegroundColor Green
    Write-Host ""
    
    # Group by category
    $categories = $foundPrograms | Group-Object -Property Category | Sort-Object Name
    
    foreach ($category in $categories) {
        Write-Host "┌─ $($category.Name) " -ForegroundColor Cyan -NoNewline
        Write-Host ("─" * (50 - $category.Name.Length)) -ForegroundColor Cyan
        
        foreach ($program in $category.Group | Sort-Object Name) {
            Write-Host "│" -ForegroundColor Cyan
            Write-Host "│  ✓ " -ForegroundColor Green -NoNewline
            Write-Host "$($program.Name)" -ForegroundColor White
            Write-Host "│    $($program.Description)" -ForegroundColor Gray
            Write-Host "│    Location: $($program.Path)" -ForegroundColor DarkGray
        }
        Write-Host "└" -ForegroundColor Cyan -NoNewline
        Write-Host ("─" * 50) -ForegroundColor Cyan
        Write-Host ""
    }
}

Write-Host ""
Write-Host "What can Mossy Launcher do with these programs?" -ForegroundColor Yellow
Write-Host "  • Observe which AI programs you're actively using" -ForegroundColor Gray
Write-Host "  • Track your workflow across different AI tools" -ForegroundColor Gray
Write-Host "  • Provide contextual assistance based on your active program" -ForegroundColor Gray
Write-Host "  • Log and sync your AI interactions (with your consent)" -ForegroundColor Gray
Write-Host ""
Write-Host "Note: This scan only detects installed desktop applications." -ForegroundColor DarkGray
Write-Host "Many AI tools are web-based and accessed through browsers." -ForegroundColor DarkGray
Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
