#https://superuser.com/questions/1068382/how-to-remove-all-the-tiles-in-the-windows-10-start-menu
#Unpins all tiles from the Start Menu
    Write-Output "Unpinning all tiles from the start menu"
    (New-Object -Com Shell.Application).
    NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
    Items() |
    %{ $_.Verbs() } |
    ?{$_.Name -match 'Un.*pin from Start'} |
    %{$_.DoIt()}