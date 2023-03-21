function Welcome {
    $logoMSG = "玄战网络策划自动化部署工具"
    $descMSG = "坚持爱与和平，爱玩家不喂翔，保持微笑冷静!"
    $lastMSG = "最后修改：2023-03-22"

    $noteMSG = "查看帮助：lhxb-help "

    $TerminalWidth = $Host.UI.RawUI.BufferSize.Width
    $Speed = 5
    function WriteLine {
        param([string]$Line, [int]$Speed, [string]$color = "White")
        [int]$Start = 1
        [int]$End = $Line.Length
        $StartPosition = $HOST.UI.RawUI.CursorPosition
        $Spaces = " " * ($TerminalWidth / 2)

        if ($Line -eq "") { return }
        $len = 0
        foreach ($Pos in $Start .. $End) {
            $bytes = [System.Text.Encoding]::UTF8.GetByteCount($Line.Substring($Pos - 1, 1))
            if ($bytes -eq 3) {
                $len += 2
            }
            else {
                $len += 1
            }
            $TextToDisplay = $Spaces.Substring(0, $TerminalWidth / 2 - $len / 2) + $Line.Substring(0, $Pos)
            write-host -nonewline $TextToDisplay -ForegroundColor $color
            start-sleep -milliseconds $Speed
            $HOST.UI.RawUI.CursorPosition = $StartPosition
        }
        write-host ""
    }

    WriteLine $logoMSG $Speed -color "Blue"
    WriteLine $descMSG $Speed -color "Red"
    WriteLine $noteMSG $Speed -color "Yellow"
    WriteLine $lastMSG $Speed -color "Green"
}

Welcome

$PSVersion = Get-Host
Write-Host $PSVersion.Version.Major
if ($PSVersion.Version.Major -lt 7) {
    Write-Host "建议安装POWERSHELL 7.0及更高版本获取追加体验。"
    winget install powershell
}

# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
# irm get.scoop.sh | iex