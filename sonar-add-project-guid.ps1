# This script will add Project GUID into the .csproj.
# That is required by Sonar Cloud or Sonar Qube.
# Only needed for .NET Core .csproj projects.
# .NET Framework doesn't need this as it has already a project GUID.

$paths = Get-ChildItem -include *.csproj -Recurse
foreach($pathobject in $paths) 
{
    $path = $pathobject.fullname
    Write-Output $path
    $doc = New-Object System.Xml.XmlDocument
    $doc.Load($path)
    $child = $doc.CreateElement("ProjectGuid")
    Write-Output $child
    $child.InnerText = [guid]::NewGuid().ToString().ToUpper()
    $node = $doc.SelectSingleNode("//Project/PropertyGroup")
    $node.AppendChild($child)
    Write-Output $child.InnerText
    $doc.Save($path)
}
