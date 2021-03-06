# Content analysis scripts

## [.\wip](.\wip) folder

This folder contains scripts that in development. Use at your own risk!

## [find-emptyrows.ps1](find-emptyrows.ps1)

This script scans all of the MD files in the current folder tree looking for markdown tables that contain empty rows.

Example usage:
```powershell
cd C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs
C:\MyRepos\tools-by-sean\analysis-tools\find-emptyrows.ps1 > C:\temp\emptyrow_report.txt
```

The output includes the number of empty rows found and the filename. 

## [get-linkcoverage.ps1](get-linkcoverage.ps1)

This script scans the current folder and all subfolders for MD files looking for hyperlinks to other MD files within the documents. The output contains the following fields:

- linkfile = target filename without the path
- linkpath = fullpath of the link
- linktype
    - TOC = listed in the TOC 
    - self = not a real link - just a reference for a file in the folder
    - topic = a link to a document from another non-TOC document
- srcfile = the name of the file (without path) containing the link
- fullpath = fullpath to the file
- label = the text of hyperlink (innertext)
- bookmark = the bookmark portion of the link
- title = the title text of the link

The output can be converted to CSV format. The resulting spreadsheet can then be used to find files that missing from the TOC or are not linked to by any other content.

Example usage:
```powershell
cd C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking
C:\MyRepos\tools-by-sean\analysis-tools\get-linkcoverage.ps1 | export-csv -notype C:\temp\link_report.csv
```

## [get-links.ps1](get-links.ps1)

This script creates a report of all hyperlinks in markdown documents. Links to other articles,
media files, and external websites are tested.

## [fix-highbit.ps1](fix-highbit.ps1) & [charlist.json](charlist.json)

This script 
This script scans the current folder and all subfolders for MD files looking for highbit characters within the documents and replaces them based on character mapping rules defined in charlist.json. Byte sequences not defined in charlist.json are passed through unchanged.

## [show-highbit.ps1](show-highbit.ps1) & [charlist.json](charlist.json)

This script scans the current folder and all subfolders for MD files looking for highbit characters within the documents. Highbit characters can cause formatting issues, especially when the byte pattern is not a valid UTF8 encoded sequence. The output shows the byte pattern found and the name or type of character that it represents. Content owners should remove all highbit characters and replace them with an appropriate ASCII equivalent or an HTML entity value. 

For example: use the HTML enitity `&reg;` for the &reg; character.

Example usage:
```powershell
cd C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking
C:\MyRepos\tools-by-sean\analysis-tools\show-highbit.ps1 > C:\temp\highbit_report.txt
```

Example output:
```
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\branchcache\deploy\BranchCache-Deployment-Guide.md
    AE = reg symbol
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\branchcache\deploy\Enable-BranchCache-on-a-File-Share--Optional-.md
    E2 80 99 = right single quote
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\core-network-guide\cncg\server-certs\Create-an-Alias-CNAME-Record-in-DNS-for-WEB1.md
    E2 80 9C = left double quote
    E2 80 9D = right double quote
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\core-network-guide\cncg\server-certs\Server-Certificate-Deployment-Overview.md
    EF BB BF = BOM
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\dns\deploy\Scenario--Use-DNS-Policy-for-Geo-Location-Based-Traffic-Management-with-Primary-Servers.md
    E2 80 99 = right single quote
    E2 80 9C = left double quote
    E2 80 9D = right double quote
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\dns\What-s-New-in-DNS-Server.md
    E2 80 99 = right single quote
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\bgp\Border-Gateway-Protocol--BGP-.md
    E2 80 99 = right single quote
    9D = 
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\add-to-existing-vpn\Step-1--Configure-the-DirectAccess-Infrastructure_3.md
    E2 80 94 = mdash
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\add-to-existing-vpn\Step-1--Plan-DirectAccess-Infrastructure.md
    E2 80 94 = mdash
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\add-to-existing-vpn\Step-2--Plan-the-DirectAccess-Deployment_4.md
    E2 80 94 = mdash
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\single-server-advanced\Step-1--Plan-the-DirectAccess-Infrastructure.md
    E2 80 94 = mdash
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\single-server-wizard\Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md
    97 = 
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\single-server-wizard\Plan-a-Basic-DirectAccess-Deployment.md
    97 = 
    C:\MyRepos\WindowsServerDocs-pr\WindowsServerDocs\networking\remote-access\directaccess\tlg-cluster-nlb\Overview-of-the-Test-Lab-Scenario_5.md
    97 = 
```