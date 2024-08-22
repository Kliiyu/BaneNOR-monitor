$confirmation = Read-Host "Do you want to generate schedule display link? [y/n]"

while($confirmation -ne "y")
{
    if ($confirmation -eq 'n') {exit}
    $confirmation = Read-Host "Do you want to generate train schedule display link? [y/n]"
}

$link = "http://rtd.opm.jbv.no:8080/web_client/std?station="

$station = Read-Host "Enter your station [format: XXX, example: SSE = Sandnes]"
$link = $link + $station

function addToLink {
    param (
        $inputLink,
        $new
    )
    return $inputLink + $new
}

function question {
    param (
        $prompt,
        $option1,
        $option2,
        $option1result,
        $option2result
    )
    $result = Read-Host $prompt "["$option1"/"$option2"]"
    while($result -ne $option1 -or $result -ne $option2) {
        if ($result -eq $option1) {
            return addToLink $link $option1result
        } else {
            return addToLink $link $option2result
        }
    }
}

$link = question "Do you want to see arrival or departure?" "a" "d" "&content=arrival" "&content=departure"
$link = question "Do you want landscape or portrait orientation?" "l" "p" "&layout=landscape" "&layout=portrait"
$link = question "Do you want to display station notices?" "y" "n" "&notice=yes" "&notice=no"

Write-Output "Generated link: "
Write-Output $link
