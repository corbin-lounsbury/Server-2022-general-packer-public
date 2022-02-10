param (
    $publicRepo,
    $gitUser,
    $gitToken
)

$destPath = "c:\temp\clone_repo"
new-item -path $destPath -itemtype directory
Set-Location -Path $destPath

# Clones the public directory and cleans it out, sparing the .git folder
start-process git -ArgumentList "clone https://$($gitUser):$gitToken@github.com/$gitUser/$publicRepo.git" -Wait -NoNewWindow
Set-Location -Path $destPath\$publicRepo
Get-ChildItem -path $destPath\$publicRepo\* -exclude /git | Remove-Item -Force

# Copies the working directory in, commits,  and pushes to the public repo
Copy-Item -Path $PSScriptRoot\* -Destination $destPath\$publicRepo -Recurse -Force -Exclude .git,post
start-process git -ArgumentList "add ." -Wait -NoNewWindow
start-process git -ArgumentList "commit -m automated_push" -Wait -NoNewWindow
start-process git -ArgumentList "push -u origin main" -Wait -NoNewWindow

# Goes back to the execution directory and removes the repo clone directory
Set-Location -Path $PSScriptRoot
Remove-Item -path $destPath -Recurse -Force