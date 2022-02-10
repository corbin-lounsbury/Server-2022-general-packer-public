param (
    $publicRepo,
    $gitUser,
    $gitToken
)

$destPath = "c:\temp\clone_repo"
new-item -path $destPath -itemtype directory
start-process git -ArgumentList "clone https://$($gitUser):$gitToken@github.com/$gitUser/$publicRepo.git" -Wait -NoNewWindow
Remove-Item -path $destPath\$publicRepo\* -Recurse -Force
Copy-Item -Path $PSScriptRoot\* -Destination $destPath\$publicRepo -Recurse -Force
Set-Location -Path $destPath\$publicRepo
git add .
git commit -m "automated push"
git push -u origin main
Remove-Item -path $destPath -Recurse -Force