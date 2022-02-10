param (
    $publicRepo,
    $gitUser,
    $gitToken
)

$destPath = "c:\temp\clone_repo"
new-item -path $destPath -itemtype directory
Set-Location -Path $destPath
start-process git -ArgumentList "clone https://$($gitUser):$gitToken@github.com/$gitUser/$publicRepo.git" -Wait -NoNewWindow
Set-Location -Path $destPath\$publicRepo
start-process git -ArgumentList "pull"-Wait -NoNewWindow
Get-ChildItem -path $destPath\$publicRepo\* -exclude /git | Remove-Item -Force
#Remove-Item  -Recurse -Force -Exclude ".git\*"
Copy-Item -Path $PSScriptRoot\* -Destination $destPath\$publicRepo -Recurse -Force -Exclude .git
start-process git -ArgumentList "add ." -Wait -NoNewWindow
start-process git -ArgumentList "commit -m automated_push" -Wait -NoNewWindow
start-process git -ArgumentList "push -u origin main" -Wait -NoNewWindow
Set-Location -Path $PSScriptRoot
Remove-Item -path $destPath -Recurse -Force